
import Debug.Trace
import Control.Monad                (foldM)
import Test.Hspec
import Test.HUnit

import Text.Parsec
import Text.Parsec.Language  (emptyDef)
import Text.Parsec.Expr
import Text.Parsec.Error
import qualified Text.Parsec.Token as T

import Control.Monad.Trans.Except
import Control.Monad.State.Lazy
import Control.Monad.Identity (Identity)
import Data.Bifunctor (first)
import Data.Fixed (mod')
import Data.Map.Lazy (Map)
import qualified Data.Map.Lazy as Map

data AST = Atom String
         | Number Double
         | Operator Char AST AST
         | Function String [String] AST
         | FunctionCall String [AST]
         | Whitespace
         deriving Show

type Interpreter = Map String AST
type Result = Maybe Double
type Parser = Parsec String Interpreter AST

T.TokenParser {
        T.identifier = identifier,
        T.reserved = reserved,
        T.symbol = symbol,
        T.reservedOp = reservedOp,
        T.naturalOrFloat = naturalOrFloat,
        T.whiteSpace = whiteSpace,
        T.parens = parens
    }
    = T.makeTokenParser $ emptyDef {
        T.reservedNames = ["fn"],
        T.reservedOpNames = ["+", "-", "*", "/", "%", "=", "=>"]
    }

parser :: Parser
parser = do
    ex <- function <|> expression <|> (whiteSpace >> return Whitespace)
    eof
    return ex

function :: Parser
function = do
    reserved "fn"
    name <- identifier
    args <- many identifier
    reservedOp "=>"
    ex <- expression
    return $ Function name args ex

expression :: Parser
expression = operators
         <|> factor

operators :: Parser
operators = chainr1 ops p
    where
        ops = buildExpressionParser opTable factor
        p = reservedOp "=" >> return (Operator '=')

opTable :: OperatorTable String Interpreter Identity AST
opTable = [
        [ infixOp '*', infixOp '/', infixOp '%' ],
        [ infixOp '+', infixOp '-' ]
    ]

infixOp :: Char -> Operator String Interpreter Identity AST
infixOp op = Infix (reservedOp [op] >> (return (Operator op))) AssocLeft

factor :: Parser
factor = functionCall
     <|> parens expression
     <|> variable
     <|> number

functionCall :: Parser
functionCall = do
    store <- getState
    name <- identifier
    args <- case Map.lookup name store of
        Just (Function _ args _) -> count (length args) expression
        _ -> many expression
    return $ FunctionCall name args

variable :: Parser
variable = do
    var <- identifier
    store <- getState
    return $ case Map.lookup var store of
        Nothing -> Atom var
        Just (Number n) -> Number n

number :: Parser
number = do
    n <- naturalOrFloat
    return $ case n of
        Left integer -> Number (fromIntegral integer)
        Right double -> Number double

method :: Char -> (Double -> Double -> Double)
method '+' = (+)
method '-' = (-)
method '*' = (*)
method '/' = (/)
method '%' = mod'

-- Eval AST
eval :: AST -> StateT Interpreter (Except String) Result

-- Whitespace
eval Whitespace = return Nothing

-- Number "1"
eval (Number x) = return $ Just x

-- Assignment "x = 1", "x = y = 1"
eval (Operator '=' (FunctionCall name []) ex) = do
    (Just x) <- eval ex
    store <- get
    case Map.lookup name store of
        Nothing -> do -- "x = 1"
            put $ Map.insert name (Number x) store
            return $ Just x
        Just (Number _) -> do -- "x = y = 1"
            put $ Map.insert name (Number x) store
            return $ Just x
        _ -> lift $ throwE "assign error"

-- Operation "1 + 1", "x + y"
eval (Operator f a b) = do
    (Just x) <- eval a
    (Just y) <- eval b
    return $ Just $ (method f) x y

-- Function Assignment "fn foo x y => x + y"
eval func@(Function name params body) = do
    store <- get
    case Map.lookup name store of
        Just (Number _) -> lift $ throwE "func error"
        _ -> do
            -- check error "fn foo x y => x + y"
            put $ Map.insert name func store
            funcEval (FunctionCall name (map (const $ Number 0.0) params))
            return Nothing

-- Function Call "x"
eval func@(FunctionCall name []) = do
    store <- get
    case Map.lookup name store of
        Nothing -> lift $ throwE $ name ++ " undefined"
        Just (Number x) -> return $ Just x
        _ -> funcEval func

-- Function Call "foo x y"
eval func@(FunctionCall name params) = do
    store <- get
    case Map.lookup name store of
        Nothing -> lift $ throwE $ "no function " ++ name
        Just (Function _ _ _) -> funcEval func

funcEval :: AST -> StateT Interpreter (Except String) Result
funcEval (FunctionCall name params) = do
    store <- get
    let Just (Function _ args body) = Map.lookup name store
    if length params /= length args
    then lift $ throwE "funcEval error"
    else do
        let argvs = (\(Right (Just x, _)) -> Number x) <$> (\p -> runExcept $ runStateT (eval p) store) <$> params
        let argMap = Map.union (Map.fromList $ zip args argvs) (Map.filter (not . isNumber) store)
        case runExcept $ runStateT (eval body) argMap of
            Left e -> lift $ throwE "funcEval error"
            Right (result, store) -> return result
        where
            isNumber :: AST -> Bool
            isNumber (Number _) = True
            isNumber _ = False

input :: String -> Interpreter -> Either String (Result, Interpreter)
input s store = do
    ast <- (first show) (runParser parser store "" s)
    runExcept $ runStateT (eval ast) store

newInterpreter :: Interpreter
newInterpreter = Map.empty

-- Test

main :: IO ()
main = hspec $ do
    let int0 = newInterpreter

    it "Basic arithmetic" $ do
        assertNone int0 ""
        assertDouble_ int0 "1 + 1" 2
        assertDouble_ int0 "2 - 1" 1
        assertDouble_ int0 "2 * 3" 6
        assertDouble_ int0 "8 / 4" 2
        assertDouble_ int0 "7 % 4" 3

    it "Variables" $ do
        assertDouble int0 "x = y = z = 1" 1
        int1 <- assertDouble int0 "x = 1" 1
        assertDouble_ int1 "x" 1
        assertDouble_ int1 "x + 3" 4
        assertError_ int1 "y"

    it "Assignment" $ do
        int1 <- assertDouble int0 "13 + (y = 3)" 16
        assertDouble_ int1 "y" 3

    it "Functions" $ do
        int1 <- assertNone int0 "fn avg x y => (x + y) / 2"
        assertDouble_ int1 "avg 4 2" 3
        assertDouble_ int1 "avg avg 4 2 avg 4 2" 3
        assertError_ int1 "avg 7"
        assertError_ int1 "avg 7 2 4"
        assertError_ int1 "gva 7 2 4"
        assertError_ int0 "fn add x y => x + z"

    it "Conflicts" $ do
        withInterpreter ["x = 1", "fn avg x y => (x + y) / 2"] $ \int0 -> do
            assertError_ int0 "fn x => 0"
            assertError_ int0 "avg = 5"

withInterpreter exprs f =
  case foldM apply newInterpreter exprs of
       Right interp -> f interp >> return ()
       Left err -> pendingWith ("Unexpected error: " ++ err)
  where
    apply int0 s = input s int0 >>= return . snd

assertNone int s = assertEvaluate int s Nothing
assertNone_ int s = assertNone int s >> return ()
assertDouble int s ex = assertEvaluate int s (Just ex)
assertDouble_ int s ex = assertDouble int s ex >> return ()

assertEvaluate int0 s ex =
  case input s int0 of
       Right (x, int1) -> assertEqual inputStr ex x >> return int1
       Left msg -> assertFailure errorMsg >> return undefined
         where errorMsg = unlines [ inputStr
                                  , "expected: " ++ show ex
                                  , "but got error: " ++ msg
                                  ]
  where inputStr = "   input: " ++ show s

assertError_ int s =
  case input s int of
       Left _ -> return ()
       Right (val, _) -> assertFailure errorMsg
         where errorMsg = unlines [ "  input: " ++ show s
                                  , "expected error"
                                  , "but got: " ++ show val
                                  ]

isLeft (Left _) = True
isLeft _ = False

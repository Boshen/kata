import Text.Parsec
import Text.Parsec.Char
import Data.Char

data Math = S | N Double | Ex (Double -> Double -> Double)
type Parser = Parsec String ()

op :: Char -> (Double -> Double -> Double)
op '+' = (+)
op '-' = (-)
op '*' = (*)
op '/' = (/)

parseOp :: Parser Math
parseOp = do
    c <- satisfy (`elem` "+-*/")
    return $ Ex (op c)

parseNum :: Parser Math
parseNum = do
    n <- many1 $ satisfy (\c -> isDigit c || c == '.')
    return $ N (read n)

parseSpace :: Parser Math
parseSpace = do
    space
    return S

parser :: Parser [Math]
parser = many $ (choice [parseNum, parseOp, parseSpace])

ppp :: String -> Double
ppp s = case parse parser "" s of
    Left _ -> 0
    Right math -> let s = run [] math in if length s == 0 then 0 else head s

run :: [Double] -> [Math] -> [Double]
run stack [] = stack
run stack s@(x:xs) = case x of
    N x -> run (x : stack) xs
    Ex f -> run ((f b a) : (drop 2 stack)) xs
        where
            (a:b:[]) = take 2 stack
    _ -> run stack xs

main = do
    print $ ppp ""

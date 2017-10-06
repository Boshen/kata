import Test.Hspec
import Text.Parsec
import Text.Parsec.Char
import Data.Either
import Data.Char

type Parser = Parsec String ()

parens = ["()", "{}", "[]"]

parensSet :: Char -> Char -> Parser ()
parensSet open close = between (char open) (char close) (optional $ many1 parensSets)

parensSets :: Parser ()
parensSets = choice $ map (\(open:close:[]) -> parensSet open close) parens

allParensSet :: Parser [()]
allParensSet = manyTill parensSets eof

validBraces :: String -> Bool
validBraces s = isRight $ parse allParensSet "" s

main = hspec $ do
  describe "validBraces" $ do
    it "should work for some examples" $ do
      validBraces "())))"          `shouldBe` False
      validBraces "()"             `shouldBe` True
      validBraces ")("             `shouldBe` False
      validBraces ")"              `shouldBe` False
      validBraces "(())((()())())" `shouldBe` True
      validBraces "()"             `shouldBe` True
      validBraces "[([)"           `shouldBe` False
      validBraces "())({}}{()][][" `shouldBe` False
      validBraces "({})[({})]"     `shouldBe` True

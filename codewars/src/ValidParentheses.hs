import Test.Hspec
import Text.Parsec
import Text.Parsec.Char
import Data.Either
import Data.Char

parensSet :: Parsec String () ()
parensSet = between (char '(') (char ')') (optional $ many1 parensSet)

allParensSet :: Parsec String () [()]
allParensSet = manyTill parensSet eof

validParentheses :: String -> Bool
validParentheses s = isRight $ parse allParensSet "" (filter (`elem` "()") s)

main = hspec $ do
  describe "validParentheses" $ do
    it "should work for some examples" $ do
      validParentheses "())))" `shouldBe` False
      validParentheses "()" `shouldBe` True
      validParentheses ")(" `shouldBe` False
      validParentheses ")"  `shouldBe` False
      validParentheses "(())((()())())"  `shouldBe` True

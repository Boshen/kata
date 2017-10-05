import Test.Hspec
import Text.Parsec
import Text.Parsec.Char
import Data.Either

type Parser = Parsec String ()

parser :: Parser Int
parser = do
    c <- option '+' (char '-')
    digits <- many1 digit
    eof
    return $ read (c : digits)

parses :: String -> Bool
parses = isRight . parse parser ""

main = hspec $ do
  describe "Example tests" $ do
    it "Put your own tests here:" $ do
      parses "2193" `shouldBe` True
      parses "-437104" `shouldBe` True
      parses "4321.0432" `shouldBe` False
      parses "" `shouldBe` False

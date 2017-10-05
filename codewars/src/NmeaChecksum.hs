import Test.Hspec

import Text.ParserCombinators.ReadP
import Numeric (readHex)
import Data.Bits (xor)
import Data.Char (isHexDigit)

parser = do
    char '$'
    sentence <- munch1 ((/=) '*')
    char '*'
    checksum <- munch1 isHexDigit
    return (sentence, checksum)

correctCase sentence checksum =
    (foldl1 xor . map fromEnum) sentence == (fst . head . readHex) checksum

check s = case (readP_to_S parser) s of
    (x:xs) -> (uncurry correctCase) (fst x)
    _ -> False

main = hspec $ do
  describe "Static tests" $ do
    it "Test Correct 1" $
      check "$GPAAM,A,A,0.10,N,WPTNME*32\r\n" `shouldBe` True
    it "Test Correct 2" $
      check "$GPRMC,152226.580,A,37.659,N,54.216,E,0.57,0.17,140924,,*3A\r\n" `shouldBe` True
    it "Test Correct 3" $
      check "$GPGSV,3,2,12,04,31,054,00,06,29,220,29,01,28,302,25,17,26,133,00*74\r\n" `shouldBe` True
    it "Test Incorrect 1" $
      check "$GPRMC,104427.591,A,5920.7009,N,01803.2938,E,0.146345,320.93,141204,,*93\r\n" `shouldBe` False
    it "Test Incorrect 2" $
      check "$GPGSA,A,3,05,24,17,30,02,,,,,,,,5.6,3.3,4.5*T4\r\n" `shouldBe` False
    it "Test Incorrect 3" $
      check "$GPRMC,104427.591,A,5920.7009,N,01803.2938,E,0.146345,320.93,141204,,*0808\r\n" `shouldBe` False

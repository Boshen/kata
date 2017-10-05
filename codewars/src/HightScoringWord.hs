import Data.Char

import Test.Hspec
import Data.List
import Data.Char

high :: String -> String
high = maximumBy (\a b -> compare (z a) (z b)) . words
    where z = sum . (map (\x -> ord x - 97))

main :: IO ()
main = hspec $ do
   describe "Sample test" $ do
     it "man i need a taxi up to ubud" $ do
      high "man i need a taxi up to ubud" `shouldBe` "taxi"
     it "what time are we climbing up the volcano" $ do
       high "what time are we climbing up the volcano" `shouldBe` "volcano"
     it "take me to semynak" $ do
      high "take me to semynak" `shouldBe` "semynak"
     it "massage yes massage yes massage" $ do
       high "massage yes massage yes massage" `shouldBe` "massage"
     it "take two bintang and a dance please" $ do
       high "take two bintang and a dance please" `shouldBe` "bintang"

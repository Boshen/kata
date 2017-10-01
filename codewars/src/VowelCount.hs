-- http://www.codewars.com/kata/vowel-count/

import Test.Hspec
import Test.QuickCheck

import Data.Char
import Data.Set (Set)
import qualified Data.Set as Set

vowels :: Set Char
vowels = Set.fromList ['a', 'e', 'i', 'o', 'u']

isVowel :: Char -> Bool
isVowel = flip Set.member $ vowels

getCount :: String -> Int
getCount = length . filter isVowel

main = hspec $ do
  describe "getCount" $ do
    it "should work for some examples" $ do
      getCount "ape"         `shouldBe` 2
      getCount "banana"      `shouldBe` 3
      getCount "batman"      `shouldBe` 2
      getCount "abracadabra" `shouldBe` 5

    it "should work for vowel-only strings" $ do
      property $ \n -> n >= 0 ==>
        getCount (take n . cycle $ "aeiou") `shouldBe` n
    it "should work for consonant strings" $ do
      property $ \n -> n >= 0 ==>
        getCount (take n . cycle $ "bcdfghjklmnpqrstvwxyz") `shouldBe` 0

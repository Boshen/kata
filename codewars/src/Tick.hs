import Test.Hspec

import Data.Char
import Data.Map.Strict (Map, (!))
import qualified Data.Map.Strict as Map

add' (Just x) = Just $ if x + 1 > 255 then 0 else x + 1
add' Nothing = Just 1
minus' (Just x) = Just $ if x - 1 < 0 then 255 else x - 1
minus' Nothing = Just 255

run :: Int -> Map Int Int  -> String -> String -> String
run selectorIndex memory output (x:xs) = case x of
    '>' -> run (selectorIndex + 1) memory output xs
    '<' -> run (selectorIndex - 1) memory output xs
    '+' -> run selectorIndex (Map.alter add' selectorIndex memory) output xs
    '-' -> run selectorIndex (Map.alter minus' selectorIndex memory) output xs
    '*' -> run selectorIndex memory (output ++ [chr $ memory ! selectorIndex]) xs
    '&' -> output
    '/' -> run selectorIndex memory output (if (Map.findWithDefault 0 memory selectorIndex) == 0 then drop 1 xs else xs)
    '\\' -> run selectorIndex memory output (if (Map.findWithDefault 0 memory selectorIndex) /= 0 then drop 1 xs else xs)
    _ -> run selectorIndex memory output xs

interpreter :: String -> String
interpreter tape = run 0 (Map.singleton 0 0) "" (cycle tape)

main :: IO ()
main = hspec $ do
  describe "Example Tests" $ do
    it "Hello world!" (interpreter "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++**>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>++++++++++++++++++++++++++++++++*>+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*<<*>>>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*<<<<*>>>>>++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*>+++++++++++++++++++++++++++++++++*&" `shouldBe` "Hello world!")
    it "Step forward 1" (interpreter "-/*&" `shouldBe` [chr(255)])
    it "Step forward 2" (interpreter "-\\*&" `shouldBe` [])
    it "Step forward 3" (interpreter "+a*\\&" `shouldBe` [])

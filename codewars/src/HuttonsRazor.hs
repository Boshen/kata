import Test.Hspec
import Text.Printf

data Razor
  = Lit Int
  | Add Razor Razor

interpret :: Razor -> Int
interpret (Lit x) = x
interpret (Add (Lit x) (Lit y)) = x + y
interpret (Add d (Lit x)) = x + (interpret d)
interpret (Add (Lit x) d) = x + (interpret d)

pretty :: Razor -> String
pretty (Lit x) = show x
pretty (Add (Lit x) (Lit y)) = printf "(%d+%d)" x y
pretty (Add d (Lit x)) = printf "(%s+%d)" (pretty d) x
pretty (Add (Lit x) d) = printf "(%d+%s)" x (pretty d)

ex1 :: Razor
ex1 = Add (Lit 1) (Lit 2)

ex2 :: Razor
ex2 = Add (Lit 1) (Add (Lit 2) (Add (Lit 3) (Lit 4)))

ex3 :: Razor -> Razor
ex3 r = Add (Lit 1000000) r

-----------------------------------------------

main :: IO ()
main = hspec $ do
  describe "basic examples interpret properly" $ do
    it "interpret ex1 = 3" $
      interpret ex1 `shouldBe` 3
    it "interpret ex2 = 10" $
      interpret ex2 `shouldBe` 10
    it "interpret (ex3 ex1) = 1000003" $
      interpret (ex3 ex1) `shouldBe` 1000003
  describe "basic examples pretty print properly" $ do
    it "pretty ex1 = (1+2)" $
      pretty ex1 `shouldBe` "(1+2)"
    it "pretty ex2 = (1+(2+(3+4)))" $
      pretty ex2 `shouldBe` "(1+(2+(3+4)))"
    it "pretty (ex3 ex1) = (1000000+(1+2))" $
      pretty (ex3 ex1) `shouldBe` "(1000000+(1+2))"

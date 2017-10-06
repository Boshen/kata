import Test.Hspec
import Test.Hspec.Core.Spec ( Result(..) )

import Data.Maybe
import Control.Applicative
import Control.Monad

data Dagger
  = Literal  Double
  | Add      Dagger Dagger
  | Multiply Dagger Dagger
  | Absolute Dagger
  | Signum   Dagger
  | Negate   Dagger
  | Divide   Dagger Dagger
  deriving (Show)

instance Num Dagger where
    (+) = Add
    (*) = Multiply
    abs = Absolute
    signum = Signum
    negate = Negate
    fromInteger = Literal . fromInteger

instance Fractional Dagger where
    (/) = Divide
    fromRational = Literal . fromRational

interp :: Dagger -> Maybe Double
interp (Literal x) = return x
interp (Add d1 d2) = liftA2 (+) (interp d1) (interp d2)
interp (Multiply d1 d2) = liftA2 (*) (interp d1) (interp d2)
interp (Absolute d) = abs <$> interp d
interp (Signum d) = signum <$> interp d
interp (Negate d) = negate <$> interp d
interp (Divide d1 d2) = case interp d2 of
    Just 0 -> Nothing
    d2' -> liftA2 (/) (interp d1) d2'

--

ex1 :: Num a => a
ex1 = 1 + abs (negate 3)

ex2 :: Fractional a => a
ex2 = 1 / 2

ex3 :: Fractional a => a
ex3 = 1 / (1 - 1)

ex4 :: Fractional a => a -> a
ex4 x = (2 * x + 2) / 3

ex5 :: Fractional a => a
ex5 = ex3 + ex3

main :: IO ()
main = hspec $ do
  describe "Examples" $ do
    it "should interpret ex1" $ shouldInterpret (interp ex1) ex1
    it "should interpret ex2" $ shouldInterpret (interp ex2) ex2
    it "should interpret ex4" $
      shouldInterpret (interp (ex4 ex2)) (ex4 ex2)
  describe "Failure" $ do
    it "should have Nothing interpreting ex3" $ do
      interp ex3 `shouldBe` Nothing
    it "should have Nothing interpreting ex5" $ do
      interp ex5 `shouldBe` Nothing

------------------------------------------------------------

shouldInterpret :: Maybe Double -> Double -> Result
shouldInterpret Nothing _ = error "failed to compute"
shouldInterpret (Just a) b = shouldBeClose a b

shouldBeClose :: Double -> Double -> Result
shouldBeClose a b
  | a `withinEps` b = Success
  | otherwise = error $ show a ++ " is not close to " ++ show b

withinEps :: Double -> Double -> Bool
withinEps a b = (a - b) <= eps where
  eps = 0.00001

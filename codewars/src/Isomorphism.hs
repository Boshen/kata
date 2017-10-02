module ISO where

import Test.Hspec
import Test.QuickCheck
import Data.Either

import Data.Void
import Data.Maybe
-- A type of `Void` have no value.
-- So it is impossible to construct `Void`,
-- unless using undefined, error, unsafeCoerce, infinite recursion, etc
-- And there is a function
-- absurd :: Void -> a
-- That get any value out of `Void`
-- We can do this becuase we can never have void in the zeroth place.

-- so, when are two type, `a` and `b`, considered equal?
-- a definition might be, it is possible to go from `a` to `b`,
-- and from `b` to `a`.
-- Going a roundway trip should leave you the same value.
-- Unfortunately it is virtually impossible to test this in Haskell.
-- This is called Isomorphism.

type ISO a b = (a -> b, b -> a)

-- given ISO a b, we can go from a to b
substL :: ISO a b -> (a -> b)
substL = fst

-- and vice versa
substR :: ISO a b -> (b -> a)
substR = snd

-- There can be more than one ISO a b
isoBool :: ISO Bool Bool
isoBool = (id, id)

isoBoolNot :: ISO Bool Bool
isoBoolNot = (not, not)

-- isomorphism is reflexive
refl :: ISO a a
refl = (id, id)

-- isomorphism is symmetric
symm :: ISO a b -> ISO b a
symm (a, b) = (b, a)

-- isomorphism is transitive
-- ISO a b = (a -> b, b -> a)
-- ISO b c = (b -> c, c -> b)
-- ISO a c = (a -> c, c -> a)
trans :: ISO a b -> ISO b c -> ISO a c
trans (ab, ba) (bc, cb) = (bc . ab, ba . cb)

-- We can combine isomorphism:
isoTuple :: ISO a b -> ISO c d -> ISO (a, c) (b, d)
isoTuple (ab, ba) (cd, dc) =
  (\(a, c) -> (ab a, cd c), \(b, d) -> (ba b, dc d))

-- type ISO a b = (a -> b, b -> a)
-- type ISO [a] [b] = ([a] -> [b], [b] -> [a])
isoList :: ISO a b -> ISO [a] [b]
isoList (a, b) = (map a, map b)

-- type ISO a b = (a -> b, b -> a)
-- type ISO (Maybe a) (Maybe b) = (Maybe a -> Maybe b, Maybe b -> Maybe a)
isoMaybe :: ISO a b -> ISO (Maybe a) (Maybe b)
isoMaybe (ab, ba) = (fmap ab , fmap ba)

-- type ISO a b = (a -> b, b -> a)
-- type ISO c d = (c -> d, d -> c)
-- type ISO (Either a c) (Either b d) = (Either a c -> Either b d, Either b d -> Either a c)
-- (Either (a -> b) (c -> d)) -> (Either (b -> a) (d -> c))
isoEither (ab, ba) (cd, dc) = (ac, bd)
    where
        ac = \x -> case x of
            Left a -> Left $ ab a
            Right c -> Right $ cd c
        bd = \x -> case x of
            Left b -> Left $ ba b
            Right d -> Right $ dc d

-- type ISO a b = (a -> b, b -> a)
-- type ISO c d = (c -> d, d -> c)
-- ISO (a -> c) (b -> d) = ((a -> c) -> (b -> d), (b -> d) -> (a -> c))
isoFunc :: ISO a b -> ISO c d -> ISO (a -> c) (b -> d)
isoFunc (ab, ba) (cd, dc) = (\ac -> cd . ac . ba, \bd -> dc . bd . ab)

-- Going another way is hard (and is generally impossible)
-- type ISO (Maybe a) (Maybe b) = (Maybe a -> Maybe b, Maybe b -> Maybe a)
-- type ISO a b = (a -> b, b -> a)
-- (Maybe a -> Maybe b) -> (a -> b)
isoUnMaybe :: ISO (Maybe a) (Maybe b) -> ISO a b
isoUnMaybe (mamb, mbma) = (ab, ba)
    where
        justa x = mamb (Just x)
        nothinga = mamb Nothing
        justb x = mbma (Just x)
        nothingb = mbma Nothing
        ab = \x -> head $ catMaybes [justa x, nothinga]
        ba = \x -> head $ catMaybes [justb x, nothingb]

-- Remember, for all valid ISO, converting and converting back
-- Is the same as the original value.
-- You need this to prove some case are impossible.

-- We cannot have
-- isoUnEither :: ISO (Either a b) (Either c d) -> ISO a c -> ISO b d.
-- Note that we have
-- (Either [()] ()) -> (Either [()] Void)
-- (Either [()] Void) -> (Either [()] ())
isoEU :: ISO (Either [()] ()) (Either [()] Void)
isoEU = (ab, ba)
    where
        ab = \a -> case a of
            Left xs -> Left $ () : xs
            Right _ -> Left []
        ba = \b -> case b of
            Left [] -> Right ()
            Left xs -> Left $ tail xs
            Right x -> absurd x

-- where (), the empty tuple, has 1 value, and Void has 0 value
-- If we have isoUnEither,
-- We have ISO () Void by calling isoUnEither isoEU
-- That is impossible, since we can get a Void by substL on ISO () Void
-- So it is impossible to have isoUnEither

-- And we have isomorphism on isomorphism!
isoSymm :: ISO (ISO a b) (ISO b a)
isoSymm = (symm, symm)

-- test

bISO :: ISO Bool Bool
bISO = (not, not)

lrl :: ISO a b -> (a -> a)
lrl (ab, ba) = ba . ab

main = hspec $ do
  describe "subst" $ do
    it "substL" $ do
      substL bISO    True  `shouldBe` False
      substL bISO    False `shouldBe` True
      substL isoBool False `shouldBe` False
      substL isoBool True  `shouldBe` True
    it "substR" $ do
      substR bISO    True  `shouldBe` False
      substR bISO    False `shouldBe` True
      substR isoBool True  `shouldBe` True
      substR isoBool False `shouldBe` False
    it "isoEU" $ do
      isLeft (substL isoEU (Right ())) `shouldBe` True
    it "lrl isoEU (Left (replicate n ())) == Left (replicate n ())" $
      property $ \(NonNegative n) ->
        lrl isoEU (Left (replicate n ())) == Left (replicate n ())

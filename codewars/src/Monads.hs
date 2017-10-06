{-# LANGUAGE NoImplicitPrelude #-}

import Prelude hiding (Monad, Identity, Maybe(..), State, Reader, Writer, (>>=), return)
import Data.Monoid

class Monad m where
  return :: a -> m a
  (>>=) :: m a -> (a -> m b) -> m b

data Identity a = Identity a
  deriving (Show, Eq)


data Maybe a = Nothing | Just a
  deriving (Show, Eq)
data State s a = State {runState :: s -> (a, s)}
data Reader s a = Reader {runReader :: s -> a }
data Writer w a = Writer {runWriter :: (w, a)}

instance Monad Identity where
  return = Identity
  (Identity v) >>= f = f v

instance Monad Maybe where
  return = Just
  Nothing >>= f = Nothing
  (Just v) >>= f = f v

instance Monad (State s) where
  return a = State $ \s -> (a, s)
  (State g) >>= f = State $ \s -> let (a, s') = g s
                                    in runState (f a) s'

instance Monad (Reader s) where
  return a = Reader $ \s -> a
  (Reader g) >>= f = Reader $ \s -> let s' = g s
                                    in runReader (f s') s

instance Monoid w => Monad (Writer w) where
  return a = Writer (mempty, a)
  (Writer (w, a)) >>= f = let (w', a') = runWriter (f a)
                          in Writer (mappend w w', a')

a :: String -> Identity String
a x = Identity $ reverse x
testIdentity :: Identity String
testIdentity = (return "test") >>= a >>= a

b :: String -> Maybe String
b x = Just $ reverse x
testMaybe :: Maybe String
testMaybe = (return "test") >>= b >>= b

c :: String -> State Integer String
c x = State $ \s -> (reverse x, s + 1)
testState :: State Integer String
testState = (return "test") >>= c >>= c

d :: String -> Reader Integer String
d x = Reader $ \s -> reverse x ++ show s
testReader :: Reader Integer String
testReader = (return "test") >>= d >>= d

e :: String -> Writer String Int
e x = Writer (reverse x, length x)
testWriter :: Writer String Int
testWriter = (return "test") >>= e >>= e

main = do
    print testIdentity
    print testMaybe
    print $ runState testState 1
    print $ runReader testReader 1
    print $ runWriter testWriter

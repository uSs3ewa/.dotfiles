module Demo where

fmap id cont == cont

fmap f (fmap g cont) == fmap (f . g) cont

instance Functor (Either e) where
  fmap _ (Left x) = Left x
  fmap g (Right y) = Right y

fmap id (Left x) == Left x
fmap id (Right y) == Right y

fmap f (fmap g (Left x))
  == fmap f (Left x)
  == Left x



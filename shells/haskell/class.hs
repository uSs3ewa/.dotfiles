class Functor f where
  fmap :: (a -> b) -> f a -> f b

instance Functor Identity where
  fmap g (Identity x) = Identity (g x)

instance Functor Maybe where
  fmap _ Nothing = Nothing
  fmap g (Just x) = Just (g x)

-- fmap - Functor map
instance Functor [] where
  fmap = map


-- Functor (Either e)
-- Functor ((,) s)
-- Functor ((->) e)

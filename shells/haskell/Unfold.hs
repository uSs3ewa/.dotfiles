-- the haskell unfolder edition
-- unfoldr

module lib
  | someFunc
  | where

import Debug.Trace

someFunc :: IO()
someFunc = putStrLn "someFunc"

main = 

data NonEmpty:ist a = NonEmptyList a [a]
  deriving Functor

foldr :: Foldable t => (a -> b -> b) -> b -> [a] -> b

-- foldr (+) 0 [1,2,3]
-- (Just 5)



module Unfoldr where

unfoldr :: (s -> Maybe (a, s)) -> s [a]
unfoldr gen s = 
  case gen s of
  Nothing -> []
  Just (a, s') -> a : unfoldr gen s'

unfoldr' :: (s -> ListF a s) -> s -> [a]
unfoldr' = undefined

foldr :: (a -> r -> r) -> r -> [a] -> r
foldr = undefined

foldr' :: (ListF a r -> r) -> [a] -> r
foldr' = undefined

data List a = Nil | Cons a (List a)
data List a r = NilF | ConsF a r
-- ListF a (List a)



enumFromTo' :: Int -> Int -> [Int]
enumFromTo' lo hi =
  unfoldr
  (\ cur -> if cur > hi then Nothing else Just (cur, cur + 1))
  lo

nats :: [Int]
-- nats = (:) 0 (map (+1) nats)
nats = 0 : map (+1) nats

firstTen :: [Int]
firstTen = take 10 nats

fibs :: [Int]
fibs = 
  unfoldr
  (\ (x, y) -> traceShow (x, y) $ Just (x, (y, x + y)))
  (0, 1)

map' :: (a -> b) -> [a] -> [b]
map' f xs =
  unfoldr
  (\ l -> 
    case l of
      [] -> Nothing
      y : ys -> Just (f y, ys)
  )
  xs

-- !Stream - lazy list!
-- map in python lazy

{-
filter :: (a -> Bool) -> [a] -> [a]
filter p xs =
  unfoldr
  (\ l ->
    case l of
      [] -> Nothing
      y : ys -> if p y then Just (y, ys) else _
  )
  xs 
-}

-- !string fusion!
-- !lambda case! : \x -> case x of
-- \case

-- if head a == True then head a : takeWhile p lst else Nothing
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile p lst = 
  unfoldr 
    (
    \lst -> case lst of -- \case
      [] -> Nothing
      x:xs -> if p x then Just (x, xs) else Nothing
    )
    lst

abba :: [Int]
-- !applicative monada!
abba = [(+1), (*2), (^3)] <*> [10, 20, 30]

-- !pattern guards!
zip :: [a] -> [b] -> [(a, b)]
zip xs ys = 
  unfoldr
  (\ (l1, l2) ->
    case s of
      ([], []) -> Nothing
      (x : xs, y : ys) -> Just ((x, y), (xs, ys))
      _ -> Nothing
  )
  (xs, ys)

newtype Indentity a = Identity a

data Maybe a = Nothin | Just a

data (,) a b = (,) a b -- type product

data Either a b = Left a | Right b -- type sum

data [] a = [] | a  : [] a

data Tree a = Leaf | Brand (Tree a) a (Tree a)

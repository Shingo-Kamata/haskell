data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)  

infiniteTree :: a -> Tree a
infiniteTree x = Node x (infiniteTree x) (infiniteTree x)

instance Functor Tree where  
    fmap f EmptyTree = EmptyTree  
    fmap f (Node x leftsub rightsub) = Node (f x) (fmap f leftsub) (fmap f rightsub)  
instance Applicative Tree where
    pure f = infiniteTree f 
    EmptyTree <*> _ = EmptyTree
    _ <*> EmptyTree = EmptyTree
    (Node f leftsub rightsub) <*> (Node a leftsub' rightsub')
              =  Node (f a) (leftsub <*> leftsub') (rightsub <*> rightsub')

treea = Node 3 (Node 2 (Node 10 (Node 6 EmptyTree EmptyTree) (Node 0 EmptyTree EmptyTree)) EmptyTree) (Node 14 EmptyTree EmptyTree)

treeb = Node 8 (Node 1 (Node 15 EmptyTree EmptyTree) (Node 16 EmptyTree EmptyTree))(Node 5 (Node 5 EmptyTree EmptyTree) EmptyTree)

treeope = Node (+) (Node (-) (Node (\x y -> x+y*y) EmptyTree EmptyTree) (Node (\x y -> x*y-y)  EmptyTree EmptyTree)) (Node (*) EmptyTree EmptyTree)

import Data.List
import Control.Applicative

catalan :: (a -> a -> a) -> [a] -> [a]
catalan f (a:[]) = [a]
catalan f xs = let
  n = pred $ length xs
  in foldr (\x y -> let 
    (i, j) = splitAt x xs
    g = catalan f
    in (f <$> (g i) <*> (g j)) ++ y) [] [n, pred n..1]

catalans :: [a -> a -> a] -> [a] -> [a]
catalans fs (a:[]) = [a]
catalans fs xs = let
  n = pred $ length xs
  in foldr (\x y -> let 
    (i, j) = splitAt x xs
    g = catalans fs
    in (fs <*> (g i) <*> (g j)) ++ y) [] [n, pred n..1]

catalan' :: (a -> a -> a) -> [a] -> [a]
catalan' f = catalans [f] 

type S a = (String,a)
gs :: [S (a -> a -> a)] ->[S a -> S a -> S a]
gs = map (\(sf,f) (sx,x) (sy,y) -> (sf ++ "(" ++ sx ++ "," ++ sy ++ ")", f x y)) 

catalansScan :: (Show a) => [S (a -> a-> a)] -> [a] -> [S a]
catalansScan fs xs = let
  hs = gs fs
  ys = map (\x -> (show x, x)) xs
  in catalans hs ys
    
catalanScan :: (Show a) => S (a -> a-> a) -> [a] -> [S a]
catalanScan f = catalansScan [f]

fillCatalan :: (Eq a, Show a)=> a -> [a] -> [S (a->a->a)]-> [String]
fillCatalan ans xs fs = let r = catalansScan fs xs
  in map fst $ filter ((== ans).snd) r

s10Puzzle :: [Double] -> [String]
s10Puzzle f = fillCatalan 10 f [("+",(+)),("-",(-)),("*",(*)),("/",(/))]

w10Puzzle :: [Double] -> [String]
w10Puzzle f = concat . map s10Puzzle $ permutations f

{-
sNPuzzle ::  Double -> [Double] -> [String]
sNPuzzle n f = fillCatalan n f [("+",(+)),("-",(-)),("*",(*)),("/",(/))]

wNPuzzle ::  Double -> [Double] -> [String]
wNPuzzle n f = concat . map (sNPuzzle n) $ permutations f

sNPuzzle2 ::  Double -> [Double] -> [String]
sNPuzzle2 n f = concat . map (sNPuzzle n) $ negaCombi f
-}
negaCombi :: [Double] -> [[Double]]
negaCombi = foldr (\x y -> (++) <$> [[x],[-x]] <*> y) [[]] 


comb :: [a] -> Int -> [[a]]
comb _ 0 = [[]] 
comb [] _ = []  
comb (x:xs) n = let ys = comb xs $ pred n
  in (map (x:) ys) ++ comb xs n

hPro :: [a] -> Int -> [[a]]
hPro xs r = let
  n = pred $ length xs
  m = n + r
  c ys = (\x y-> pred $ x-y) <$> ZipList(ys ++ [succ m]) <*> ZipList(0:ys)
  fromNums ys = concat . getZipList $ (\x y-> replicate y x) <$> ZipList xs <*> c ys
  in map fromNums $ comb [1..m] n


{-
gs = map (\(sf,f) (sx,x) (sy,y) -> (inPrint sx sf sy , f x y)) 

prePrint :: String -> String -> String -> String
prePrint o x y = o ++ "(" ++ x ++ "," ++ y ++ ")"
inPrint :: String -> String -> String -> String
inPrint x o y = "(" ++ x ++ o ++ y ++ ")"

type FormulaType = String
type Formula = [FormulaType]
assocF :: FormulaType -> FormulaType -> FormulaType
assocF x y= "(" ++ x ++ "," ++ y ++ ")"

catalan :: Formula -> Formula
catalan (a:[]) = [a]
catalan f =  foldr (\x y -> let 
    (i,j) = splitAt x f
    (ci,cj) = (catalan i,catalan j)
    in (assocF <$> ci <*> cj)  ++ y) [] [n,pred n..1]
  where 
    n = pred $ length f

type FormulaType = Int
assocF :: FormulaType -> FormulaType -> FormulaType
assocF = (+)

assocFList :: [FormulaType -> FormulaType -> FormulaType]
assocFList = [(+), (-), (*)]
catalan :: Formula -> Formula
catalan (a:[]) = [a]
catalan f =  foldr (\x y -> let 
    (i,j) = splitAt x f
    (ci,cj) = (catalan i,catalan j)
    in (assocFList <*> ci <*> cj)  ++ y) [] [n,pred n..1]
  where 
    n = pred $ length f
-}

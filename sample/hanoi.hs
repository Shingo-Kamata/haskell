import Control.Monad.State

--ハノイの塔を解くプログラム
--円盤の枚数->(最初の柱，作業用の柱，ゴールの柱)
hanoi ::  Int -> (String, String, String) -> String
--Basis：最初の柱に1枚しかない場合は，直接ゴールの柱に移動
hanoi 1 (from, work, goal) = "Move disk " ++ from ++ "->" ++ goal ++ ": "
--Inducition step:2枚以上柱にある場合
hanoi n' (from, work, goal) 
       --error
      | n <= 0 = error "Illegal disk number(need more than one disk)"
       {- n-1枚をhanoiを用いて作業の柱に移動⇒1枚をhanoiを用いて
        ゴールの柱に移動⇒またn-1枚を今度はゴールの柱に移動-}
      | n > 0  = (hanoi n (from, goal, work)
                 ++ (hanoi 1 (from, work, goal))
                 ++ (hanoi n (work, from, goal)))
      where n = n' - 1 

-- type Hoge = State [Int] Int
-- type Huga = (Hoge, Hoge, Hoge)
-- move :: Huga -> Huga
-- move (a, b, c) = (d, e, c)
--   where (_, x:xs) = runState a 
--         (_, ys) = runState b 
--         d = state $ \zs -> (x, xs)
--         e = state $ \zs -> ((), x:ys)

data TName = Start | Work | Goal deriving(Eq, Ord, Show)
data Tower = Tower TName [Int]
type Towers = (Tower, Tower, Tower) 

instance Show Tower where
  show (Tower a xs) = "Tower " ++ (show a) ++ ": " ++ (show xs)

-- instance Ord Tower where
--   compare (Tower a _) (Tower b _) = compare a b

hoge :: Towers -> String
hoge (a, b, c) = (show a) ++ n ++ (show b) ++ n ++ show(show c) ++ n
  where n = "\n"

move :: State Towers ()
move = do 
  (Tower a (x:xs), b, Tower c ys) <- get
  put (Tower a xs, b , Tower c (x:ys)) 
  return ()

hanoiSub :: Int -> State Towers ()
hanoiSub 1 = move
hanoiSub n = do
  (a,b,c) <- get
  put(a,c,b)
  hanoiSub (n-1) 
  (a,c,b) <- get
  put(a,b,c)
  hanoiSub 1
  (a,b,c) <- get
  put(b,a,c)
  hanoiSub (n-1)
  return ()

hanoi2 :: Int -> (() , Towers)
hanoi2 n = runState (hanoiSub n) (a, b, c)
  where
  a = Tower Start [1,2 .. n]
  b = Tower Work [4]
  c = Tower Goal [4]

-- move :: Towers -> Towers
-- move (Tower a xs, b, Tower c cs) =  (Tower a $ init xs, b, Tower c (cs ++ [last xs])) 


-- hanoiSub :: [Int]-> (String, String, String) -> String
-- hanoiSub [] _ = []
-- hanoiSub (x:xs) (from, work, goal) = (hanoiSub xs (from, goal, work))
--   ++ ("Move " ++ (show x) ++ ": " ++ from ++ " -> "  ++ goal) ++ "\n"
--   ++ (hanoiSub xs (work, from, goal)) 

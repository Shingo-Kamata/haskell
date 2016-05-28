# Haskell 基本のまとめ
## GHCi でのコマンド
## 型の話
## 構文
# 演習
# 基本編
```haskell
quicksort :: (Ord a) => [a] -> [a]  
quicksort [] = []  
quicksort (x:xs) =   
    let smallerSorted = quicksort [a | a <- xs, a <= x]  
        biggerSorted = quicksort [a | a <- xs, a > x]  
    in  smallerSorted ++ [x] ++ biggerSorted  
```

# 型初級編

# 構文基本編 

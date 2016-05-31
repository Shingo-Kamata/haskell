## 執筆途中．以下の内容には，不正確な情報や，謝った情報が含まれている可能性があります．

# Haskell を学ぶ意義

- ### 純粋な関数型言語の特徴を知ることができる
	- 副作用が(殆ど)ない
	- 何をするか(命令型)ではなく，何であるかを伝える
- ### (比較的)新しい言語を学ぶことで，技術的なトレンドを知ることができる
	- 型推論
	- 型クラス
	- range

- ### 学術(アカデミー)に近い言語なので，プログラミングの基礎を学べる
	- 型理論
	- ラムダ計算
	- プログラム意味論
	- 圏論
	- 形式手法(は，若干こじつけかも(^o^;) )

- ### その他
	- 強い静的型付け言語の特徴を知ることができる
	- 遅延評価型の言語の特徴も知ることができる
	- 再帰的な考え方がみにつく

### 上記の特徴は，Haskell だけではなく，他の言語や，ソフトウェア科学(開発)一般において応用することが可能な，汎用的な知識と成る．

# 基本的な規則
- 型名：先頭大文字(例 Integer, String 等や，Eq，Ord　等の型クラスも)
- 変数名：上記規則があるため，先頭は小文字から．
- 関数名：関数名も先頭は小文字から
	-  アポストロフィ「’」を関数につけることで,少し変更したverの関数であることや，※正格評価版の関数をあらわす．
- 括弧のあり方について
- Haskell における変数

## GHCi でのコマンド
- :t(:type) 型を調べる
	- :set t について
- :i(:information) 詳細を調べる
- :itについて
 
## List について
## 型の話
List は，型を引数として取る型(多相型)である．これは，タプルも同じ．

# 基本的な表現
- -(マイナス)表現の注意
- if - else 
- 列挙表現
- 論理演算

# 型初級編
- ## 多相型
	- ### 多相関数 
		- #### Javaとの比較
		```java
		import java.util.ArrayList;
		import java.util.Arrays;
		
		public class QuickSort {
		    static public <T extends Comparable<? super T>> ArrayList<T>
		            quicksort(ArrayList<T> list) {
		        if (list.isEmpty()) {
		            return list;
		        }
		        if (list.size() == 1) {
		            return list;
		        }
		        T pivot = list.remove(0);
		        ArrayList<T> smallerList = new ArrayList<>();
		        ArrayList<T> biggerList = new ArrayList<>();
		        for (T x : list) {
		            if (x.compareTo(pivot) < 0) {
		                smallerList.add(x);
		            } else {
		                biggerList.add(x);
		            }
		        }
		        ArrayList<T> ansList = quicksort(smallerList);
		        ansList.add(pivot);
		        ansList.addAll(quicksort(biggerList));
		        return ansList;
		    }
		
		    public static void main(String args[]) {
		        /*ソーティングのテスト*/
		        Integer array[] = {10, 2, 5, 3, 1, 6, 7, 4, 2, 3, 4, 8, 9};
		        ArrayList<Integer> list;
		        list = new ArrayList<>(Arrays.asList(array));
		        System.out.println(QuickSort.quicksort(list));
		        /* Ans
		         * [1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 8, 9, 10]
		         */
		        
		        /*型が多層的であることのテスト*/
		        String array2[] = {"R", "Y", "Z", "M", "N", "G", "A", "D",};
		        ArrayList<String> list2;
		        list2 = new ArrayList<>(Arrays.asList(array2));
		        System.out.println(QuickSort.quicksort(list2));
		        /* Ans
		         * [A, D, G, M, N, R, Y, Z]
		         */
		    }
		}
		```
		```haskell
		quicksort :: (Ord a) => [a] -> [a]  
		quicksort [] = []  
		quicksort (x:xs) =   
		    let smallerSorted = quicksort [a | a <- xs, a <= x]  
		        biggerSorted = quicksort [a | a <- xs, a > x]  
		    in  smallerSorted ++ [x] ++ biggerSorted  
		```

- 型クラス
- 型シグネチャ

# 構文基本編 
- 結合規則
	- 関数適用(左結合)
	- 右結合の例
- 演算の優先度
- 中置記法
- エスケープシーケンス
- ガード

# 演習
- ## chapter1
	- ### πは定数piとして，prelude で定義されているが，ネイピア数 e を定義せよ．

- ## chapter2
	- ### list型，あるいは，タプル型に属する型が可算個ある(つまり，自然数と一対一対応がとれる)ことを証明せよ．
	- ### 多相関数の例を挙げよ．また，それが多相的であることのメリットを述べよ

- ## chapter3

- ## chapter4

- ## chapter5


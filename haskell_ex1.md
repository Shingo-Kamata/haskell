## 執筆途中．以下の内容には，不正確な情報や，謝った情報が含まれている可能性があります．

# Haskell を学ぶ意義

- ### 純粋な関数型言語の特徴を知ることができる
	- 副作用が(殆ど)ない
	- 何をするか(命令型)ではなく，何であるかを伝える
- ### (比較的)新しい言語を学ぶことで，技術的なトレンドを知ることができる
	- 型推論
	- 型クラス
	- 列挙表現(range)

- ### 学術(アカデミー)に近い言語なので，プログラミングの基礎を学べる
	- 型理論
	- ラムダ計算
	- プログラム意味論
	- 圏論
	- 形式手法(は，若干こじつけかも(^o^;) )

- ### その他
	- -(マイナス)の扱いめんどくさい．
	- 強い静的型付け言語の特徴を知ることができる
	- 遅延評価型の言語の特徴も知ることができる
	- 再帰的な考え方がみにつく

### 上記の特徴は，Haskell だけではなく，他の言語や，ソフトウェア科学(開発)一般において応用することが可能な，汎用的な知識と成る．

# 基本的な規則
- 型名：先頭大文字(例 Integer, String 等や，Eq，Ord　等の型クラスも)
- 変数名：上記規則があるため，先頭は小文字から．(あ，でも，型名が先頭大文字なのは，
下記の形変数が小文字(一文字)だからかもしれないので，変数名が小文字なことに関して因果関係はないかも)
- 型変数：先頭小文字(基本，「a」などの様に，小文字一文字)
- 関数名：関数名も先頭は小文字から
	-  アポストロフィ「’」を関数につけることで,少し変更したverの関数であることや，※正格評価版の関数をあらわす．
- 括弧のあり方について：基本的に，Haskell の関数適用には括弧を必要としないし，単純な適用ならば，括弧をつけないのが
作法だと思われる(そっちのが，λ計算の適用」(application)っぽいし．でも，やっぱり括弧があったほうがわかりやすくなったり
する場合もあるし，それ以外にも「$」を使った関数適用や「.」による関数合成などで分かり易い構文(表現)にすることができるので，
臨機応変にそれらを用いるべき．

- Haskell における変数

## GHCi でのコマンド
- ### :t(:type) 型を調べる
	- :set t について
- ### :i(:info) 詳細を調べる
	:i と入力することで，関数や，演算子の基本的な情報を知ることができる．

	例1
	
	```
	Prelude> :i odd
	odd :: Integral a => a -> Bool 	-- Defined in ‘GHC.Real’
	```
	
	例2<br>
	※中置記法の演算子を調べるためには，括弧を補う必要がある...
	はずだが，つけなくても，自動的に補ってくれるっぽ．
	
	```
	Prelude> :info (+)
	class Num a where
	  (+) :: a -> a -> a
	  ...
	  	-- Defined in ‘GHC.Num’
	infixl 6 +
	```
	
	例2においては，演算子(中置換数)の型と定義場所だけではなく，
	「infixl 6 +」という，構文に関する情報も表示されている．
	このように，通常は左結合である関数適用についても，
	優先順位が設定されている場合があり，その場合は，結合則
	(括弧の対応)も変わってくる．また，infixlのlは左結合を表している．
	つまり，右結合の演算子もあり，例えば，
	
	例3
	```
	Prelude> :i ^
	(^) :: (Num a, Integral b) => a -> b -> a 	-- Defined in ‘GHC.Real’
	infixr 8 ^
	```
	上記の結合規則に関する問題を演習問題であげるので，挑戦してみて．
	
	若干 :i コマンドから話がそれてしまいましたが，:i コマンドには他にも，
	型クラスからインスタンスを調査するとか，その逆とかで非常に役に立ちます．
	型クラスのところでまた触れます．

- ### :it について
	it とは，ghciで用いられる特殊変数でなかなか便利です．itを用いると，
	直前で評価に「成功」した式の結果を参照できます．
	
	```
	Prelude> "My name is it."
	"My name is it."
	Prelude> it
	"My name is it."
	Prelude> it ++ "What's your name?"
	"My name is it.What's your name?"
	```
	さらに，評価に成功した式を参照するため，一種のセーフティーネットにもなる．
	
	```
	Prelude> it ++ My name is Shingo
	
	<interactive>:4:7: Not in scope: data constructor ‘My’
	
	<interactive>:4:10: Not in scope: ‘name’
	
	<interactive>:4:15:
	    Not in scope: ‘is’
	    Perhaps you meant one of these:
	      ‘id’ (imported from Prelude), ‘it’ (line 3)
	
	<interactive>:4:18: Not in scope: data constructor ‘Shingo’
	Prelude> it
	"My name is it.What is your name?"	 
	```
	このように，itは，直前の式で「かつ，評価に成功した」ものを保存している．

## List について
List は，型を引数として取る型(多相型)である．これは，タプルも同じ．
List は，コレクション(特定の要素のあつまり←かなり怪しい表現😥)であり，
その要素は全て「同じ型」である必要がある．

## 型の話

# 基本的な表現
- ### - (マイナス)表現の注意<br>
負の数を表す意味で -3 なんかをghciに入力するときは注意
(-3) などのように，過去を補ってあげないと，Error はかれて悲しい．

- ### if else<br> 
Haskell において，if else 式は，命令形言語のif else と同じようで微妙に違う．
まず，(多くの)命令形言語においては，else を省略して，if (then) だけの式を
書いても問題ない．しかし，Haskell は else まで「必ず」セットで用いる必要がある．
命令形言語でif else は「文」であり，あくまで手続きを与えるためのものであるが，
Haskell においては「式」でなくてはならない．そのため．述語(分岐条件)が真でも
偽でも「同じ型」に評価されなくてはならない．

- ### 列挙表現(ragnge)<br>
こんな感じの
	```
	Prelude> [1..10]
	[1,2,3,4,5,6,7,8,9,10]
	Prelude> ['a'..'z']
	"abcdefghijklmnopqrstuvwxyz"
	```

	ナウめ？の言語では実装されているやつ．Listとかループ条件によくあるよね
	Haskell の range は，結構賢くていろいろしてくれるけど，落とし穴があったりする
	(特に，浮動小数点が絡んでくる場合)
	ただ，過信はできない．
	```
	Prelude> [10..1]
	[] 
	👆 [10,9,8,7,6,5,4,3,2,1] となってほしい
	Prelude> ['z'..'a']
	"" 
	👆 "zyxwvutsrqponmlkjihgfedcba" となってほしい 
	```
	
	```
	Prelude> [10,9..1]
	[10,9,8,7,6,5,4,3,2,1]
	Prelude> ['z','y'..'a']
	"zyxwvutsrqponmlkjihgfedcba"
	```

- ### 論理演算<br>
 論理演算は，基本的にはC言語の慣習を引き継いでいる．論理積は「&&」，論理和は「||」．真偽はそれぞれ，True，False である(先頭大文字)
等価は「==」であり，不等号は「>」「>=」「<」「<=」 などであるが，否定は「/=」であるので注意．(≠っぽいからみたい)

	```
	Prelude> True || False
	True
	Prelude> False || True
	True
	Prelude> True && True
	True
	Prelude> True && False
	False
	Prelude> 3 == 3
	True
	Prelude> 3 == 10
	False
	Prelude> 3 /= 3
	False
	Prelude> 3 /= 8
	True
	Prelude> 3 >= 2
	True
	Prelude> 2 >= 3
	False
	```
	また，型が異なるものの比較は，怒られちゃう

	```
	Prelude> 3 == True
	
	<interactive>:34:1:
	    No instance for (Num Bool) arising from the literal ‘3’
	    In the first argument of ‘(==)’, namely ‘3’
	    In the expression: 3 == True
	    In an equation for ‘it’: it = 3 == True
	Prelude> 3 /= True
	
	<interactive>:35:1:
	    No instance for (Num Bool) arising from the literal ‘3’
	    In the first argument of ‘(/=)’, namely ‘3’
	    In the expression: 3 /= True
	    In an equation for ‘it’: it = 3 /= True
	```

# 型初級編
- ## 多相型
	- ### 多相関数 
		- #### Javaとの比較

		Java での多相的なクイックソート(オリジナルなので，糞コードの可能性も否めないが)
		``` java
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
		```

		Haskell での多相的なクイックソート(コチラはすごいH本から引用．だから，多分良いコード)
		``` haskell
		quicksort :: (Ord a) => [a] -> [a]  
		quicksort [] = []  
		quicksort (x:xs) =   
		    let smallerSorted = quicksort [a | a <- xs, a <= x]  
		        biggerSorted = quicksort [a | a <- xs, a > x]  
		    in  smallerSorted ++ [x] ++ biggerSorted  
		```

		Java での多相クイックソートのコードが(私が書いたため)残念である可能性はあるにせよ，
		Haskell の方が楽に書けることが分かる．

- 型クラス
- 型シグネチャ

# 構文基本編 
- 結合規則
	- 関数適用(左結合)
		関数適用は，通常は左結合である．
	- 右結合の例
	- 演算の優先度
- 中置記法
- エスケープシーケンス
- ガード

# 演習
- ## chapter1
	- ### πは定数piとして，prelude で定義されているが，ネイピア数 e を定義せよ．
	- ### 「:i +」「:i -」「:i \*」「:i ^」の結果を確認せよ．また，「 3 - 1 + 4 \* 2 \* 3 ^ 2 」の結果を考察し，上記結果となる理由を :i の結果から考察せよ
- ## chapter2
	- ### list型，あるいは，タプル型に属する型が(理論上は)可算無限個存在する(つまり，自然数と一対一対応がとれる)ことを証明せよ．
	- ### 多相関数の例を挙げよ．また，それが多相的であることのメリットを述べよ

- ## chapter3

- ## chapter4

- ## chapter5


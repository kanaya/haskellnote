// Typst
#import "@preview/in-dexter:0.7.2": *
#import "@preview/codelst:2.0.2": sourcecode

#set text(lang:"ja")
#set math.equation(numbering: "(1)")

#set page(
  paper: "a4",
  header: align(right, context document.title),
  numbering: "1",
)

#set par(justify: true, first-line-indent: 1em)

#set heading(numbering: "1.1")

#set document(title: [Haskell Notes])

#set text(font: ("Times", "Toppan Bunkyu Mincho"))

#let heading_font(body) = {
    set text(font: ("Helvetica", "Toppan Bunkyu Midashi Gothic"), navy)
    body
}
#show heading: heading_font

#let highlight_font(body) = {
  set text(font: ("Helvetica", "Toppan Bunkyu Gothic"))
  body
}
#show highlight: highlight_font

#let tk = [ #emoji.ast.box *TK* ]
#let keyword(x) = [#highlight[#x]]

#import "haskell.typ"

#title[Haskell Notes]

#outline()
#pagebreak()

= Haskellについて

本書はプログラミング言語Haskellの入門書である．それと同時に，本書はプログラミング言語を用いた代数構造の入門書でもある．プログラミングと代数構造の間には密接な関係があるが，とくに#keyword[関数型プログラミング]を実践する時にはその関係を意識する必要が出てくる．本書はその両者を同時に解説することを試みる．

これからのプログラマにとってHaskellを無視することはできない．Haskellの「欠点をあげつらうことも，攻撃することもできるが，無視することだけはできない」のだ．それはHaskellがプログラミングの本質に深く関わっているからである．

Haskellというプログラミング言語を知ろうとすると，従来のプログラミング言語の知識が邪魔をする．モダンで，人気があって，Haskellから影響を受けた言語，たとえばRubyやSwiftの知識さえ，Haskellを学ぶ障害になり得る．ではどのようにしてHaskellの深みに到達すればいいのだろうか．

その答えは，一見遠回りに見えるが，一度抽象数学の高みに登ることである．

と言っても，あわてる必要はない．

近代的なプログラミング言語を知っていれば，すでにある程度抽象数学に足を踏み入れているからである．そこで，本書では近代的なプログラマを対象に，プログラミング言語を登山口に抽象数学の山を登り，その高みからHaskellという森を見下ろすことにする．

ところで，プログラムのソースコードは現代でもASCII文字セットの範囲で書くことが標準的である．Unicodeを利用したり，まして文字にカラーを指定したり，書体や装飾を指定することは一般的ではない．たとえば変数 `a` のことを $a$ と書いたり $bold(a)$ と書いたり $tilde(a)$ と書いたりして区別することはない．

Haskellプログラマもまた，多くの異なる概念を同じ貧弱な文字セットで表現しなければならない．これは，はじめてHaskellコードを読むときに大きな問題になりえる．たとえばHaskellでは `[a]` という表記をよく扱う．この `[a]` は `a` という変数1要素からなるリストのこともあるし，`a` 型という仮の型から作ったリスト型の場合もあるが，字面からでは判断できない．もし変数はイタリック体，型はボールド体と決まっていれば，それぞれ $[a]$ および $[haskell.typeparameter(a)]$ と区別できたところである．

本書は，異なる性質のものには異なる書体を割り当てるようにしている．ただし，どの表現もいつでもHaskellに翻訳できるように配慮している．実際，本書執筆の最大の困難点は，数学的に妥当で，かつHaskellの記法とも矛盾しない記法を見つけることであった．

= 変数・関数・型

== 変数

変数 $x$ に値 $1$ を代入するには次のようにする．

$ x = 1 $<binding>

#haskell.block[Haskellでは
#sourcecode[```haskell
x = 1
```]
と書く．]

変数という呼び名に反して，変数の値は一度代入したら変えられない．そこで変数に値を代入するとは呼ばずに，変数に値を#keyword[束縛]するという． @binding の右辺のように数式にハードコードされた値を#keyword[リテラル]と呼ぶ．

リテラルや変数には#keyword[型]がある．型は数学者の#keyword[集合]と似た意味で，整数全体の集合 $ZZ$ に相当する#keyword[整数型]や，実数全体の集合 $RR$ に相当する#keyword[浮動小数点型]がある．整数と整数型，実数と浮動小数点型は異なるため，整数型を $haskell.Int$ で，浮動小数点型を $haskell.Double$ で表すことにする．

#haskell.block[Haskellでは $haskell.Int$ および $haskell.Double$ をそれぞれ `Int` および `Double` と書く．]

数学者は変数 $x$ が整数であることを $x in ZZ$ と書くが，本書では $x::haskell.Int$ と書く．これは記号 $in$ を別の用途に用いるためである．

#haskell.block[Haskellでは $x::haskell.Int$ を
#sourcecode[```Haskell
x :: Int
```]
と書く．]

本書では変数名を原則1文字として，イタリック体で表し $w,x,y,z$ のような $n$ 以降のアルファベットを使う．

変数の値がいつでも変化しないことを#keyword[参照透過性]と呼ぶ．プログラマが変数の値を変化させたい，つまり#keyword[破壊的代入]を行いたい理由はユーザ入力，ループ，例外，内部状態の変化，大域ジャンプ，継続を扱いたいからであろう．しかし，後に見るようにループ，例外，内部状態の変化，大域ジャンプ，継続に変数の破壊的代入は必要ない．ユーザ入力に関しても章を改めて取り上げる．参照透過性を強くサポートするプログラミング言語をを#keyword[関数型プログラミング言語]と呼ぶ．

== 変数の型

#tk

$ x :: haskell.Int $

$ x = 1 $

$ x :: haskell.Int = 1 $

== 関数

整数 $x$ に $1$ を足す#keyword[関数] $f$ は次のように定義できる．
$ f x = x+1 $
ここに $x$ は関数 $f$ の#keyword[引数]である．引数は括弧でくるまない．

#haskell.block[Haskell では $f x = x+1$ を
#sourcecode[```haskell
f x = x + 1
```]
と書く．]

本書では関数名を原則1文字として，イタリック体で表し，$f,g,h$ のようにアルファベットの $f$ 以降の文字を使う．ただし有名な関数についてはローマン体で表し，文字数も2文字以上とする．たとえば $sin$ などの三角関数や指数関数がそれにあたる．

変数 $x$ に関数 $f$ を#keyword[適用]する場合は次のように書く．ここでも引数を括弧でくるまない．
$ z = f x $

#haskell.block[Haskell では $z = f x$ を
#sourcecode[```haskell
z = f x
```]
と書く．]

関数 $f$ が引数をふたつ取る場合は，次のように書く．
$ z = f x y $

#haskell.block[Haskell では $z = f x y$ を
#sourcecode[```haskell
z = f x y
```]
と書く．]

なお $f x y$ は $(f x)y$ と解釈される．前半の $(f x)$ は1引数の関数とみなせる．2引数関数を連続した1引数関数の適用とみなす考え方を，関数の#keyword[カリー化]と呼ぶ．


== 有名な関数

#tk

== 関数の型

#tk

== 関数合成

変数 $x$ に関数 $f$ と関数 $g$ を連続して適用したい場合
$ z = g(f x)$
とするところであるが，事前に関数 $f$ と関数 $g$ を#keyword[合成]しておきたいことがある．

関数の合成は次のように書く．
$ k = g haskell.compose f $
関数の連続適用 $g(f x)$ と合成関数の適用 $(g haskell.compose f)x$ は同じ結果を返す．

#haskell.block[Haskell では $k = g haskell.compose f$ を
#sourcecode[```haskell
k = g . f
```]
と書く．]

関数合成演算子 $.$ は以下のように#keyword[左結合]する．
$ k &= h haskell.compose g haskell.compose f \
    &= (h haskell.compose g) haskell.compose f $

関数適用のための特別な演算子 $haskell.apply$ があると便利である．演算子 $haskell.apply$ は関数合成演算子よりも優先順位が低い．例を挙げる．
$ z &= h haskell.compose (g haskell.compose f) x \
    &= h haskell.apply g haskell.compose f x $

#haskell.block[Haskell では $z = h haskell.apply g haskell.compose f x$ を
#sourcecode[```haskell
z = h $ (g . f) x
```]
と書く．]


== IOサバイバルキット1

プログラムとは合成された関数である．多くのプログラミング言語では，プログラムそのものにmainという名前をつける．本書では「#keyword[IOモナド]」の章で述べる理由によって，main関数をサンセリフ体で $haskell.main$ と書く．

実用的なプログラムはユーザからの入力を受け取り，関数を適用し，ユーザへ出力する．Haskellではユーザからの1行の入力を $haskell.getLine$ で受け取り，変数の値を $haskell.print$ で書き出せる．ここに $haskell.getLine$ と $haskell.print$ は関数（ファンクション）ではあるが，特別に「#keyword[アクション]」とも呼ぶ．関数 $haskell.main$もアクションである．

引数 $x$ の2乗を求める関数 $f$ は次のように定義できる．
$
  f :: haskell.Double -> haskell.Double\
  f x = x times x
$<square>

#haskell.block[Haskell では @square を
#sourcecode[```haskell
f :: Double -> Double
f x = x * x
```]
と書く．]

ユーザからの入力に関数 $f$ を適用してユーザへ出力するプログラムをHaskellで書くと次のようになる．
$ haskell.main = haskell.print haskell.compose f haskell.compose haskell.read haskell.bind haskell.getLine $<first-main>
ここに関数 $haskell.read$ は#keyword[文字列]であるユーザ入力を数に変換する関数である．また演算子 $haskell.bind$ は新たな関数合成演算子で，アクションとアクションを合成するための特別な演算子である．詳細は「#keyword[モナド]」の章で述べる．

#haskell.block[Haskell では @first-main を
#sourcecode[```haskell
main = print . f . read =<< getLine
```]
と書く．]



= Test Part

Function application. $ z = f x $

#sourcecode[```haskell
z = f x
```]

List map. $ haskell.list(z) = f haskell.map haskell.list(x) $

#sourcecode[```Haskell
zs = f `map` xs
```]

Functor map. $ haskell.ctxt(z) = f haskell.fmap haskell.ctxt(x) $

#sourcecode[```haskell
zm = f <$> xm
```]

Applicative map. $ haskell.ctxt(z) = haskell.ctxt(f) haskell.amap haskell.ctxt(x) $

#sourcecode[```Haskell
zm = fm <*> xm
```]

Apllicative map 2. $ haskell.ctxt(z) = haskell.ctxt(g) haskell.amap haskell.ctxt(x) haskell.amap haskell.ctxt(y) $

#sourcecode[```haskell
zm = gm <*> xm <*> ym
```]

Applicative map 2 (another version). $ haskell.ctxt(z) = g haskell.fmap haskell.ctxt(x) haskell.amap haskell.ctxt(y) $

#sourcecode[```haskell
zm = g <$> xm <*> ym
```]

Monadic function application. $ haskell.ctxt(z) = haskell.monadic(f) x $

#sourcecode[```Haskell
zm = f x
```]

Bind. $ haskell.ctxt(z) = haskell.monadic(f) haskell.bind haskell.ctxt(x) $

#sourcecode[```Haskell
zm = f =<< xm
```]

Double bind. $ haskell.ctxt(z) = haskell.monadic(g) haskell.bind haskell.monadic(f) haskell.bind haskell.ctxt(x) $

#sourcecode[```haskell
zm = g =<< f =<< xm
```]

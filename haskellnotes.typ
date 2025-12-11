// Typst
#import "@preview/in-dexter:0.7.2": *
#import "@preview/codelst:2.0.2": sourcecode

#set text(lang:"ja")
#set math.equation(numbering: "(1)")

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

#set page(
  paper: "a4",
  header: align(right, context document.title),
  numbering: "1",
)
#set par(justify: true,
  first-line-indent: 1em)
#set heading(numbering: "1.1")

#import "haskell.typ"

#title[Haskell Notes]

#outline()
#pagebreak()

= Haskellについて

本書はプログラミング言語Haskellの入門書である．それと同時に，本書はプログラミング言語を用いた代数構造の入門書でもある．プログラミングと代数構造の間には密接な関係があるが，とくに #highlight[関数型プログラミング] を実践する時にはその関係を意識する必要が出てくる．本書はその両者を同時に解説することを試みる．

これからのプログラマにとってHaskellを無視することはできない．Haskellの「欠点をあげつらうことも，攻撃することもできるが，無視することだけはできない」のだ．それはHaskellがプログラミングの本質に深く関わっているからである．

Haskellというプログラミング言語を知ろうとすると，従来のプログラミング言語の知識が邪魔をする．モダンで，人気があって，Haskellから影響を受けた言語，たとえばRubyやSwiftの知識さえ，Haskellを学ぶ障害になり得る．ではどのようにしてHaskellの深みに到達すればいいのだろうか．

その答えは，一見遠回りに見えるが，一度抽象数学の高みに登ることである．

と言っても，あわてる必要はない．

近代的なプログラミング言語を知っていれば，すでにある程度抽象数学に足を踏み入れているからである．そこで，本書では近代的なプログラマを対象に，プログラミング言語を登山口に抽象数学の山を登り，その高みからHaskellという森を見下ろすことにする．

ところで，プログラムのソースコードは現代でもASCII文字セットの範囲で書くことが標準的である．Unicodeを利用したり，まして文字にカラーを指定したり，書体や装飾を指定することは一般的ではない．たとえば変数 `a` のことを $a$ と書いたり $bold(a)$ と書いたり $tilde(a)$ と書いたりして区別することはない．

Haskellプログラマもまた，多くの異なる概念を同じ貧弱な文字セットで表現しなければならない．これは，はじめてHaskellコードを読むときに大きな問題になりえる．たとえばHaskellでは `[a]` という表記をよく扱う．この `[a]` は `a` という変数1要素からなるリストのこともあるし，`a` 型という仮の型から作ったリスト型の場合もあるが，字面からでは判断できない．もし変数はイタリック体，型はボールド体と決まっていれば，それぞれ$[haskell.parameter(a)]$および$[haskell.typeparameter(a)]$と区別できたところである．

本書は，異なる性質のものには異なる書体を割り当てるようにしている．ただし，どの表現もいつでもHaskellに翻訳できるように配慮している．実際，本書執筆の最大の困難点は，数学的に妥当で，かつHaskellの記法とも矛盾しない記法を見つけることであった．

= 変数・関数・型

== 変数

変数$x$に値$1$を代入するには次のようにする．

$ x = 1 $<binding>

#haskell.block[Haskellでは
#sourcecode[```haskell
x = 1
```]
と書く．]

変数という呼び名に反して，変数の値は一度代入したら変えられない．そこで変数に値を代入するとは呼ばずに，変数に値を #highlight[束縛] するという． @binding の右辺のように数式にハードコードされた値を #highlight[リテラル] と呼ぶ．

リテラルや変数には #highlight[型] がある．型は数学者の #highlight[集合] と似た意味で，整数全体の集合 $ZZ$ に相当する #highlight[整数型] や，実数全体の集合 $RR$ に相当する #highlight[浮動小数点型] がある．整数と整数型，実数と浮動小数点型は異なるため，整数型を $haskell.int$ で，浮動小数点型を $haskell.double$ で表すことにする．

#haskell.block[Haskellでは $haskell.int$ および $haskell.double$ をそれぞれ `Int` および `Double` と書く．]

数学者は変数 $x$ が整数であることを $x in ZZ$ と書くが，本書では $x::haskell.int$ と書く．これは記号 $in$ を別の用途に用いるためである．

#haskell.block[Haskellでは $x::haskell.int$ を
#sourcecode[```Haskell
x :: Int
```]
と書く．]

本書では変数名を原則1文字として，イタリック体で表し $w,x,y,z$ のような $n$ 以降のアルファベットを使う．

変数の値がいつでも変化しないことを #highlight[参照透過性] と呼ぶ．プログラマが変数の値を変化させたい，つまり #highlight[破壊的代入] を行いたい理由はユーザ入力，ループ，例外，内部状態の変化，大域ジャンプ，継続を扱いたいからであろう．しかし，後に見るようにループ，例外，内部状態の変化，大域ジャンプ，継続に変数の破壊的代入は必要ない．ユーザ入力に関しても章を改めて取り上げる．参照透過性を強くサポートするプログラミング言語をを #highlight[関数型プログラミング言語] と呼ぶ．

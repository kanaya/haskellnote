// Typst
#import "@preview/in-dexter:0.7.2": *

#set text(lang:"ja")

#set document(title: [Haskell Notes])

#set text(font: ("Times", "Toppan Bunkyu Mincho"))
#let heading_font(body) = {
    set text(font: ("Helvetica", "Toppan Bunkyu Midashi Gothic"), navy)
    body
}
#show heading: heading_font

#set page(
  paper: "a4",
  header: align(right, context document.title),
  numbering: "1",
)
#set par(justify: true,
  first-line-indent: 1em)
#set heading(numbering: "1.1")

#let haskellparameter(x) = { x }
#let haskelltypeparameter(x) = { math.bold(x) }

#title[Haskell Notes]

#outline()
#pagebreak()

#let haskellint = math.bb("Z")

= Testです

$ x :: haskellint\
 x = 1 $

$ f :: haskellint -> haskellint\
f x = x + 1 $

= Haskellについて

本書はプログラミング言語Haskellの入門書である．それと同時に，本書はプログラミング言語を用いた代数構造の入門書でもある．プログラミングと代数構造の間には密接な関係があるが，とくに #highlight[関数型プログラミング] を実践する時にはその関係を意識する必要が出てくる．本書はその両者を同時に解説することを試みる．

これからのプログラマにとってHaskellを無視することはできない．Haskellの「欠点をあげつらうことも，攻撃することもできるが，無視することだけはできない」のだ．それはHaskellがプログラミングの本質に深く関わっているからである．

Haskellというプログラミング言語を知ろうとすると，従来のプログラミング言語の知識が邪魔をする．モダンで，人気があって，Haskellから影響を受けた言語，たとえばRubyやSwiftの知識さえ，Haskellを学ぶ障害になり得る．ではどのようにしてHaskellの深みに到達すればいいのだろうか．

その答えは，一見遠回りに見えるが，一度抽象数学の高みに登ることである．

と言っても，あわてる必要はない．

近代的なプログラミング言語を知っていれば，すでにある程度抽象数学に足を踏み入れているからである．そこで，本書では近代的なプログラマを対象に，プログラミング言語を登山口に抽象数学の山を登り，その高みからHaskellという森を見下ろすことにする．

ところで，プログラムのソースコードは現代でもASCII文字セットの範囲で書くことが標準的である．Unicodeを利用したり，まして文字にカラーを指定したり，書体や装飾を指定することは一般的ではない．たとえば変数 `a` のことを $a$ と書いたり $bold(a)$ と書いたり $tilde(a)$ と書いたりして区別することはない．

Haskellプログラマもまた，多くの異なる概念を同じ貧弱な文字セットで表現しなければならない．これは，はじめてHaskellコードを読むときに大きな問題になりえる．たとえばHaskellでは `[a]` という表記をよく扱う．この `[a]` は `a` という変数1要素からなるリストのこともあるし，`a` 型という仮の型から作ったリスト型の場合もあるが，字面からでは判断できない．もし変数はイタリック体，型はボールド体と決まっていれば，それぞれ$[haskellparameter(a)]$および$[haskelltypeparameter(a)]$と区別できたところである．

本書は，異なる性質のものには異なる書体を割り当てるようにしている．ただし，どの表現もいつでもHaskellに翻訳できるように配慮している．実際，本書執筆の最大の困難点は，数学的に妥当で，かつHaskellの記法とも矛盾しない記法を見つけることであった．

#pagebreak()


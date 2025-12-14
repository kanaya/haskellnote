#let block(x) = { 
  // set text(gray)
  set text(font: ("Helvetica", "Toppan Bunkyu Gothic"), size: 10pt)
  $penta.filled$
  h(1em)
  x}

#let constant(x) = x
#let parameter(x) = x
#let longfunction(x) = x
#let typeparameter(x) = math.bold(x)

#let typename(x) = math.bold(x)

#let list(x) = $x_"s"$
#let ctxt(x) = $x_*$
#let monadic(x) = $x^dagger$

#let int = typename("Int")
#let double = typename("Double")

#let map = math.star.op
#let fmap = math.ast.op
#let amap = math.ast.op.o
#let bind = math.class("binary", math.suit.heart.stroked)


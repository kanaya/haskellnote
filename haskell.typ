#let block(x) = { 
  set text(gray)
  $penta.filled$
  // $bold(lambda)$
  h(1em)
  x}

#let parameter(x) = { x }
#let typeparameter(x) = { math.bold(x) }

#let list(x) = { 
  let xx = x
  $xx_"s"$
}
#let ctxt(x) = { 
  let xx = x
  $xx_*$ 
}
#let monadic(x) = {
  let xx = x
  $xx^dagger$
}

#let typename(x) = { math.bold(x) }

#let int = { typename("Int") }
#let double = { typename("Double") }

#let map = { math.star.op }
#let fmap = { math.ast.op }
#let amap = { math.ast.op.o }
#let bind = { math.class("binary", math.suit.heart.stroked) }
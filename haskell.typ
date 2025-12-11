#let block(x) = { 
  set text(gray)
  $penta.filled$
  // $bold(lambda)$
  h(1em)
  x}

#let parameter(x) = { x }
#let typeparameter(x) = { math.bold(x) }

#let typename(x) = { math.bold(x) }

#let int = { typename("Int") }
#let double = { typename("Double") }

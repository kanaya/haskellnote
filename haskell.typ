// Typst
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
#set par(justify: true)
#set heading(numbering: "1.1")

#title[Haskell Notes]

#outline()
#pagebreak()

= テストです Test

テストです． Test

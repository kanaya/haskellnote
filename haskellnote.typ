// Typst
#set text(lang:"ja", font: ("Times", "Toppan Bunkyu Mincho"))
#let heading_font(body) = {
    set text(font: ("Helvetica", "Toppan Bunkyu Midashi Gothic"))
    body
}
#show heading: heading_font

= テストです Test

テストです． Test

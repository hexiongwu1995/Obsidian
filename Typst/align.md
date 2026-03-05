

## align 


### Parameters

```
align( alignment, content, ) -> content
```


`alignment`  [alignment](https://typst.app/docs/reference/layout/alignment/)   Positional  Settable

The [alignment](https://typst.app/docs/reference/layout/alignment/ "alignment") along both axes.

```typst
// #set page(width:10cm, height: 10cm)
#set text(lang: "ar")

مثال
#align(
  right,
  rect(inset: 12pt)[ركن]
)
```


To center something vertically, use horizon alignment:

```typst
// #set rect(height: 20em)
#set align(horizon)

Vertically centered, \
the stage had entered, \
a new paragraph.
```







## Preamble



```
// Default Preamble
#set page(margin: 0pt, width: auto, height: auto)
#show raw: set text(size: 1.25em)
#set text(size: fontsize)
#import "@preview/mannot:0.3.1": *
#import "@preview/quick-maths:0.2.1": shorthands
#show: shorthands.with(
  ($+-$, sym.plus.minus),
  ($|-$, math.tack),
)
```



```
//inline-math preamble
#set page( width: auto, height: auto, margin: (x:5pt, y:5pt))
#show math.equation: set text(font: "Fira Math")
#math.equation([$ {CODE} $], block:false, numbering:none, number-align:end, supplement:none)
```



```
//display math preamble
#set page( width: auto, height: auto, margin: (x: 10pt, y: 5pt))
#show math.equation: set text(font: "Fira Math")
#math.equation([$ {CODE} $], block:true, numbering:none, number-align:end, supplement:none)
```



```
// typst preamble
#set align(center)
#set page( width: WIDTH, height: auto, margin: 5pt,)
#set par(justify:true, leading: 1em)
#set text(font: ("Arial", "Segoe UI Emoji", "KaiTi"), size: 1em)
#show math.equation: set text(font: "Fira Math")
#rect( width: 100%, height: auto, stroke: 1pt+ luma(50%), radius:5pt, inset:5pt, outset:2pt, fill: none)[#set align(left); {CODE}]
```



```
// typ preamble
#set align(center)
#set page( width: WIDTH, height: auto, margin: 5pt, fill:none)
#set par(justify:true, leading: 1em, linebreaks:"optimized")
#set text(font: ("Arial", "Segoe UI Emoji", "KaiTi"), size: 1em)
#show math.equation: set text(font: "Fira Math")
{CODE}
```



```
//grid preamble used for displaying the source code and the rendered image by the source code simultaneously. using a `if` statement to detect the windows platform or the android platform via WIDTH.

#if WIDTH>400pt [
// windows: WIDTH == 650pt 
#set align(center)
#set page( width: WIDTH, height: auto, margin: (x: 1em, y: 1em),)
#set par(leading: 1em)
#set text(font: ("Cascadia Code","Arial", "Segoe UI Emoji", "KaiTi"), size: 1.2em, weight: "medium" )

#rect(width:100%, height:auto, stroke:1pt+luma(50%), radius:1em, inset:0pt, fill:none, grid(columns:(1fr,2fr), rows: auto, align:(horizon+center,horizon+left), grid.vline(x:1, stroke:1pt+luma(50%)), stroke:none, inset:2em, {import "@preview/cetz:0.4.2" ; cetz.canvas({ import cetz.draw: * ; {CODE} })}, {```typm {CODE} ```}, ) )] else [

// android: WIDTH == 270pt 
#set align(center)
#set page( width: WIDTH, height: auto, margin: (x: 1em, y: 1em),)
#set par(leading: 0.8em)
#set text(font: ("Cascadia Code","Arial", "Segoe UI Emoji", "KaiTi"), size: 0.8em, weight:"medium")

#rect(width:100%, height:auto, stroke:1pt+luma(50%),radius:1em, inset:0pt, fill:none, grid( columns:(1fr,), rows: auto, align:(horizon+center,horizon+left), grid.hline(y:1, stroke:1pt+luma(50%)), stroke:none, inset:1em, {import "@preview/cetz:0.4.2" ; cetz.canvas({ import cetz.draw: * ; {CODE} })}, {```typm {CODE} ```}, ) ) ]
```


```
// typm preamble used for syntax highlighting. Using a `if` statement to detect the windows platform or the android platform via WIDTH.

#if WIDTH>400pt [
// windows: WIDTH == 650pt 
#set align(left)
#set page( width: WIDTH, height: auto, margin: 1em,)
#set par(justify:true, leading: 1em)
#set text(font: ("Cascadia Code","Arial", "Segoe UI Emoji", "KaiTi"), size: 1.3em) 
#show math.equation: set text(font: "Fira Math")
#rect( width: 100%, height: auto, stroke: 1pt+ luma(50%), radius:10pt, inset:10pt, outset:5pt, fill: none)[```typm {CODE} ```] ] else [

// android: WIDTH == 270pt 
#set align(left)
#set page( width: WIDTH, height: auto, margin: 2pt,)
#set par(justify:true, leading: 0.8em)
#set text(font: ("Cascadia Code","Arial", "Segoe UI Emoji", "KaiTi"), size: 0.8em)
#show math.equation: set text(font: "Fira Math")
#rect( width: 100%, height: auto, stroke: 1pt+ luma(50%), radius:5pt, inset:5pt, outset:2pt, fill: none)[```typm {CODE} ```]
]
```




```typst
#if WIDTH>300pt [WIDTH>300pt] else [WIDTH<=300pt] \
#WIDTH
```




# Typst  Library

```typst
#set text(size: 2em)
#emoji.sun #emoji.tree #emoji.star #emoji.spinach #emoji.spider #emoji.spiderweb #emoji.snail #emoji.rainbow #emoji.policeofficer #emoji.leaf #emoji.leaf.clover #emoji.leaf.herb #emoji.apple #emoji.frog #emoji.corn #emoji.face #emoji.plant #emoji.planet #emoji.snowflake #emoji.snowman 
```

## Foundations

Foundational types and functions.
Here, you'll find documentation for basic data types like [integers](https://typst.app/docs/reference/foundations/int/) and [strings](https://typst.app/docs/reference/foundations/str/) as well as details about core computational functions. 

### Definitions

- [`arguments`](https://typst.app/docs/reference/foundations/arguments/)Captured arguments to a function.
- [`array`](https://typst.app/docs/reference/foundations/array/)A sequence of values.
- [`assert`](https://typst.app/docs/reference/foundations/assert/)Ensures that a condition is fulfilled.
- [`auto`](https://typst.app/docs/reference/foundations/auto/)A value that indicates a smart default.
- [`bool`](https://typst.app/docs/reference/foundations/bool/)A type with two states.
- [`bytes`](https://typst.app/docs/reference/foundations/bytes/)A sequence of bytes.
- [`calc`](https://typst.app/docs/reference/foundations/calc/)Module for calculations and processing of numeric values.
- [`content`](https://typst.app/docs/reference/foundations/content/)A piece of document content.
- [`datetime`](https://typst.app/docs/reference/foundations/datetime/)Represents a date, a time, or a combination of both.
- [`decimal`](https://typst.app/docs/reference/foundations/decimal/)A fixed-point decimal number type.
- [`dictionary`](https://typst.app/docs/reference/foundations/dictionary/)A map from string keys to values.
- [`duration`](https://typst.app/docs/reference/foundations/duration/)Represents a positive or negative span of time.
- [`eval`](https://typst.app/docs/reference/foundations/eval/)Evaluates a string as Typst code.
- [`float`](https://typst.app/docs/reference/foundations/float/)A floating-point number.
- [`function`](https://typst.app/docs/reference/foundations/function/)A mapping from argument values to a return value.
- [`int`](https://typst.app/docs/reference/foundations/int/)A whole number.
- [`label`](https://typst.app/docs/reference/foundations/label/)A label for an element.
- [`module`](https://typst.app/docs/reference/foundations/module/)A collection of variables and functions that are commonly related to a single theme.
- [`none`](https://typst.app/docs/reference/foundations/none/)A value that indicates the absence of any other value.
- [`panic`](https://typst.app/docs/reference/foundations/panic/)Fails with an error.
- [`plugin`](https://typst.app/docs/reference/foundations/plugin/)Loads a WebAssembly module.
- [`regex`](https://typst.app/docs/reference/foundations/regex/)A regular expression.
- [`repr`](https://typst.app/docs/reference/foundations/repr/)Returns the string representation of a value.
- [`selector`](https://typst.app/docs/reference/foundations/selector/)A filter for selecting elements within the document.
- [`std`](https://typst.app/docs/reference/foundations/std/)A module that contains all globally accessible items.
- [`str`](https://typst.app/docs/reference/foundations/str/)A sequence of Unicode codepoints.
- [`symbol`](https://typst.app/docs/reference/foundations/symbol/)A Unicode symbol.
- [`sys`](https://typst.app/docs/reference/foundations/sys/)Module for system interactions.
- [`target`](https://typst.app/docs/reference/foundations/target/)Returns the current export target.
- [`type`](https://typst.app/docs/reference/foundations/type/)Describes a kind of value.
- [`version`](https://typst.app/docs/reference/foundations/version/)A version with an arbitrary number of components.


## Model

Document structuring.
Here, you can find functions to structure your document and interact with that structure. This includes section headings, figures, bibliography management, cross-referencing and more.

### Definitions

- [`bibliography`](https://typst.app/docs/reference/model/bibliography/)A bibliography / reference listing.
- [`cite`](https://typst.app/docs/reference/model/cite/)Cite a work from the bibliography.
- [`document`](https://typst.app/docs/reference/model/document/)The root element of a document and its metadata.
- [`emph`](https://typst.app/docs/reference/model/emph/)Emphasizes content by toggling italics.
- [`enum`](https://typst.app/docs/reference/model/enum/)A numbered list.
- [`figure`](https://typst.app/docs/reference/model/figure/)A figure with an optional caption. 
- [`footnote`](https://typst.app/docs/reference/model/footnote/)A footnote.
- [`heading`](https://typst.app/docs/reference/model/heading/)A section heading.
- [`link`](https://typst.app/docs/reference/model/link/)Links to a URL or a location in the document.
- [`list`](https://typst.app/docs/reference/model/list/)A bullet list.
- [`numbering`](https://typst.app/docs/reference/model/numbering/)Applies a numbering to a sequence of numbers. 
- [`outline`](https://typst.app/docs/reference/model/outline/)A table of contents, figures, or other elements.
- [`par`](https://typst.app/docs/reference/model/par/)A logical subdivison of textual content.
- [`parbreak`](https://typst.app/docs/reference/model/parbreak/)A paragraph break.
- [`quote`](https://typst.app/docs/reference/model/quote/)Displays a quote alongside an optional attribution.
- [`ref`](https://typst.app/docs/reference/model/ref/)A reference to a label or bibliography.
- [`strong`](https://typst.app/docs/reference/model/strong/)Strongly emphasizes content by increasing the font weight.
- [`table`](https://typst.app/docs/reference/model/table/)A table of items.
- [`terms`](https://typst.app/docs/reference/model/terms/)A list of terms and their descriptions.
- [`title`](https://typst.app/docs/reference/model/title/)A document title.


## Text

Text styling.
The [text function](https://typst.app/docs/reference/text/text/) is of particular interest.

### Definitions

- [`highlight`](https://typst.app/docs/reference/text/highlight/)Highlights text with a background color.
- [`linebreak`](https://typst.app/docs/reference/text/linebreak/)Inserts a line break.
- [`lorem`](https://typst.app/docs/reference/text/lorem/)Creates blind text.
- [`lower`](https://typst.app/docs/reference/text/lower/)Converts a string or content to lowercase.
- [`overline`](https://typst.app/docs/reference/text/overline/)Adds a line over text.
- [`raw`](https://typst.app/docs/reference/text/raw/)Raw text with optional syntax highlighting.
- [`smallcaps`](https://typst.app/docs/reference/text/smallcaps/)Displays text in small capitals.
- [`smartquote`](https://typst.app/docs/reference/text/smartquote/)A language-aware quote that reacts to its context.
- [`strike`](https://typst.app/docs/reference/text/strike/)Strikes through text.
- [`sub`](https://typst.app/docs/reference/text/sub/)Renders text in subscript.
- [`super`](https://typst.app/docs/reference/text/super/)Renders text in superscript.
- [`text`](https://typst.app/docs/reference/text/text/)Customizes the look and layout of text in a variety of ways.
- [`underline`](https://typst.app/docs/reference/text/underline/)Underlines text.
- [`upper`](https://typst.app/docs/reference/text/upper/)Converts a string or content to uppercase.


## Math
Typst has special [syntax](https://typst.app/docs/reference/syntax/#math) and library functions to typeset mathematical formulas. Math formulas can be displayed inline with text or as separate blocks. They will be typeset into their own block if they start and end with at least one space (e.g. `$ x^2 $`).  

### Sizes 
Forced size styles for expressions within formulas. 
These functions allow manual configuration of the size of equation elements to make them look as in a display/inline equation or as if used in a root or sub/superscripts.

 `display`
Forced display style in math. This is the normal size for block equations. 

```typst
$sum_i x_i/2 = display(sum_i x_i/2)$
```

```
math.display(content, cramped: bool, ) -> content
```

body:   content  Required  Positional
The content to size. 

cramped:  bool
Whether to impose a height restriction for exponents, like regular sub- and superscripts do.
Default: false 

`inline`
Forced inline (text) style in math. This is the normal size for inline equations. 

```typst
$sum_i x_i/2 = inline(sum_i x_i/2)$
```

```
// normal code block
math.inline( content, cramped: bool,) -> content
```

 `script`
Forced script style in math. 
This is the smaller size used in powers or sub- or superscripts.

```typst
$sum_i x_i/2 = script(sum_i x_i/2)$
```

```
math.script(content, cramped: bool,) -> content
```


 `sscript`
Forced second script style in math. 
This is the smallest size, used in second-level sub- and superscripts (script of the script).  

```typst
$sum_i x_i/2 = sscript(sum_i x_i/2)$
```

```
math.sscript( content, cramped: bool,) -> content
```

### Definitional equality symbol

The following is a Typst code snippet. I am unfamiliar with the syntax and unsure of its mathematical meaning. Please introduce relevant concepts and provide a detailed explanation. 

```typst
$cal(A) := { x in RR | x "is natural" }$ 
```
Here's a clear explanation of your Typst snippet, both in terms of Typst syntax and its mathematical meaning:

```
$cal(A) := { x in RR | x "is natural" }$ \
```

Typst syntax breakdown

| Part           | Meaning in Typst                                                        | Visual result (rendered math) |
| -------------- | ----------------------------------------------------------------------- | ----------------------------- |
| `cal(A)`       | Calligraphic letter A (𝒜)                                              | 𝒜                            |
| `:=`           | Typst renders this as the assignment / definitional equality symbol (≔) | ≔                             |
| `{ ... }`      | Set builder notation                                                    | { … }                         |
| `x in RR`      | `in` = ∈ , `RR` = blackboard bold ℝ (real numbers)                      | x ∈ ℝ                         |
| `\|`           | The "such that" bar (∣)                                                 | ∣                             |
| `"is natural"` | Regular text inside math mode (not italicized)                          | “is natural” (upright text)   |
| `\`            | Line break in Typst (forces new line after the equation)                | —                             |

So when rendered, this line approximately looks like:  𝒜 ≔ { x ∈ ℝ ∣ x is natural } 

This is not standard mathematical notation, but it's very easy to understand what the writer intended. In serious mathematical writing you almost never see the English phrase  "is natural" inside a set builder.

If you want to say "𝒜 is the set of natural numbers", the following are the most widely accepted styles:

```typst
#set text(size:1.2em) 

More idiomatic / conventional ways to write the same idea in Typst are:

// Style 1 – shortest & most common today
$cal(A) := NN$

// Style 2 – very clear
$cal(A) := { n in RR | n in NN }$

// Style 3 – very explicit (closest to your version)
$cal(A) := { x in RR | x "is a natural number" }$

// Style 4
$cal(A) := {1, 2, 3, dots}$

// Similar syntax


$cal(A) := { n in ZZ | n gt.eq 1 }$

Z means set of integer; gt.eq means greater than or equal to.

```

### Variables

In math, single letters are always displayed as is. Multiple letters, however, are interpreted as variables and functions. To display multiple letters verbatim, you can place them into quotes and to access single letter variables, you can use the [hash syntax](https://typst.app/docs/reference/scripting/#expressions).

```typst
#set text(size:1.2em)
$A = pi r^2$ \
$"area" = pi dot "radius"^2$ \
$a r e a = pi dot r a d i u s^2$ \
$cal(A) := { x in RR | x "is natural" }$ \
#let x = 5 
$#x < 17$
```


### Symbols 

Math mode makes a wide selection of [symbols](https://typst.app/docs/reference/symbols/sym/) like `pi`, `dot`, or `RR` available. Many mathematical symbols are available in different variants. You can select between different variants by applying [modifiers](https://typst.app/docs/reference/foundations/symbol/) to the symbol. Typst further recognizes a number of shorthand sequences like `=>` that approximate a symbol. When such a shorthand exists, the symbol's documentation lists it.

```typst
$x < y => x gt.eq.not y$
```

### Line Breaks

Formulas can also contain line breaks. Each line can contain one or multiple _alignment points_ (`&`) which are then aligned. 

```typst
$sum_(k=0)^n k &= 1 + ... + n \ &= (n(n+1)) / 2$ 
```

### Function calls

Math mode supports special function calls without the hash prefix. In these "math calls", the argument list works a little differently than in code:  

- Within them, Typst is still in "math mode". Thus, you can write math directly into them, but need to use hash syntax to pass code expressions (except for strings, which are available in the math syntax).
- They support positional and named arguments, as well as argument spreading.
- They don't support trailing content blocks.
- They provide additional syntax for 2-dimensional argument lists. The semicolon (`;`) merges preceding arguments separated by commas into an array argument. 

```
$display(frac(a^2, 2))$ \ 
$vec(1, 2, delim: "[")$ \ 
$mat(1, 2; 3, 4)$ \ 
$mat(..#range(1, 5).chunks(2))$ \
$display(lim_x = op("lim", limits: #true)_x)$ \
```

To write a verbatim comma or semicolon in a math call, escape it with a backslash. The colon on the other hand is only recognized in a special way if directly preceded by an identifier, so to display it verbatim in those cases, you can just insert a space before it. 

Functions calls preceded by a hash are normal code function calls and not affected by these rules.

### Alignment

When equations include multiple _alignment points_ (`&`), this creates blocks of alternatingly right- and left-aligned columns. In the example below, the expression `(3x + y) / 7` is right-aligned and `= 9` is left-aligned. The word "given" is also left-aligned because `&&` creates two alignment points in a row, alternating the alignment twice. `& &` and `&&` behave exactly the same way. Meanwhile, "multiply by 7" is right-aligned because just one `&` precedes it. Each alignment point simply alternates between right-aligned/left-aligned. 


```typst
*multiple alignment points* \ \ 
$(3x + y) / 7 &= 9 & "given" \ 
  3x + y &= 63 & "multiply by 7" \ 
  3x &= 63 - y & "subtract y" \ 
  x &= 21 - y/3 & "divide by 3"$ \ 
```


### Math fonts

You can set the math font by with a [show-set rule](https://typst.app/docs/reference/styling/#show-rules) as demonstrated below. Note that only special OpenType math fonts are suitable for typesetting maths.

```
#show math.equation: set text(font: "Fira Math")
$display(sum_(i in NN) 1 + i)$ 
```

### Math module

All math functions are part of the `math` [module](https://typst.app/docs/reference/scripting/#modules), which is available by default in equations. Outside of equations, they can be accessed with the `math.` prefix.

### Accessibility

To make math accessible, you must provide alternative descriptions of equations in natural language using the [`alt` parameter of `math.equation`](https://typst.app/docs/reference/math/equation/#parameters-alt). For more information, see the [Textual Representations section of the Accessibility Guide](https://typst.app/docs/guides/accessibility/#textual-representations).

```typst
#math.equation(
  alt: "d S equals delta q divided by T",
  block: true,
  $dif S = (delta q) / T$,
)
```


In the future, Typst will automatically make equations without alternative descriptions accessible in HTML and PDF 2.0 export.

### Definitions

- [`accent`](https://typst.app/docs/reference/math/accent/)Attaches an accent to a base.
- [attach](https://typst.app/docs/reference/math/attach/)Subscript, superscripts, and limits.
- [`binom`](https://typst.app/docs/reference/math/binom/)A binomial expression.
- [`cancel`](https://typst.app/docs/reference/math/cancel/)Displays a diagonal line over a part of an equation.
- [`cases`](https://typst.app/docs/reference/math/cases/)A case distinction.
- [`class`](https://typst.app/docs/reference/math/class/)Forced use of a certain math class.
- [`equation`](https://typst.app/docs/reference/math/equation/)A mathematical equation.
- [`frac`](https://typst.app/docs/reference/math/frac/)A mathematical fraction.
- [lr](https://typst.app/docs/reference/math/lr/)Delimiter matching.
- [`mat`](https://typst.app/docs/reference/math/mat/)A matrix.
- [`op`](https://typst.app/docs/reference/math/op/)A text operator in an equation.
- [`primes`](https://typst.app/docs/reference/math/primes/)Grouped primes.
- [roots](https://typst.app/docs/reference/math/roots/)Square and non-square roots.
- [sizes](https://typst.app/docs/reference/math/sizes/)Forced size styles for expressions within formulas.
- [`stretch`](https://typst.app/docs/reference/math/stretch/)Stretches a glyph.
- [styles](https://typst.app/docs/reference/math/styles/)Alternate letterforms within formulas.
- [underover](https://typst.app/docs/reference/math/underover/)Delimiters above or below parts of an equation.
- [variants](https://typst.app/docs/reference/math/variants/)Alternate typefaces within formulas.
- [`vec`](https://typst.app/docs/reference/math/vec/)A column vector.


## equation 
`Element` 

A mathematical equation. 
Can be displayed inline with text or as a separate block. An equation becomes block-level through the presence of whitespace after the opening dollar sign and whitespace before the closing dollar sign.

### Example


```typst
#set text(font: "Fira Math",size: 1.2em)

Let $a$, $b$, and $c$ be the side lengths of right-angled triangle. \
Then, we know that:
$a^2 + b^2 = c^2$

Prove by induction:
$sum_(k=1)^n k = (n(n+1)) / 2$
```

By default, block-level equations will not break across pages. This can be changed through `show math.equation: set block(breakable: true)`. 

Syntax

This function also has dedicated syntax: Write mathematical markup within dollar signs to create an equation. Starting and ending the equation with whitespace lifts it into a separate block that is centered horizontally. For more details about math syntax, see the [main math page](https://typst.app/docs/reference/math/). 

### Parameters

```
math.equation(
block: bool,
numbering: none str function,
number-align: alignment,
supplement: none auto content function,
alt: none str,
content,
) -> content
```

```typst
#math.equation(block:true, numbering:"(1)", number-align:start, supplement: [eq.], [$F_n = floor(1 / sqrt(5) phi.alt^n )$]) 

// #math.equation(block:true, numbering:"(1)", number-align:end, supplement: [eq.], [${CODE}$]) 
```



 `block`    [bool](https://typst.app/docs/reference/foundations/bool/)  Settable
Whether the equation is displayed as a separate block.
Default: `false`


 `numbering`    [none](https://typst.app/docs/reference/foundations/none/) or [str](https://typst.app/docs/reference/foundations/str/) or [function](https://typst.app/docs/reference/foundations/function/)  Settable

How to number block-level equations. Accepts a [numbering pattern or function](https://typst.app/docs/reference/model/numbering/) taking a single number.

```typst
#set math.equation(numbering: "(1)")

We define:
$display(phi.alt := (1 + sqrt(5)) / 2)$ <ratio>

With @ratio, we get:
$display(F_n = floor(1 / sqrt(5) phi.alt^n))$
```

Default: `none`


 `number-align`    [alignment](https://typst.app/docs/reference/layout/alignment/)  Settable
The alignment of the equation numbering.
By default, the alignment is `end + horizon`. For the horizontal component, you can use `right`, `left`, or `start` and `end` of the text direction; for the vertical component, you can use `top`, `horizon`, or `bottom`.

```typst
#set math.equation(numbering: "(1)", number-align: top+start)

We can calculate: \ \
$ E &= sqrt(m_0^2 + p^2) \
    &approx 125 "GeV" $
```

Default:  end + horizon



 `supplement`    [none](https://typst.app/docs/reference/foundations/none/) or [auto](https://typst.app/docs/reference/foundations/auto/) or [content](https://typst.app/docs/reference/foundations/content/) or [function](https://typst.app/docs/reference/foundations/function/)  Settable
A supplement for the equation.
For references to equations, this is added before the referenced number.
If a function is specified, it is passed the referenced equation and should return content. 

```typst
#set math.equation(numbering: "(1)", number-align:start, supplement: [Eq.])

We define:
$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

With @ratio, we get:
$ F_n = floor(1 / sqrt(5) phi.alt^n) $
```

Default: auto 

`alt`   [none](https://typst.app/docs/reference/foundations/none/) or [str](https://typst.app/docs/reference/foundations/str/)  Settable
An alternative description of the mathematical equation.
This should describe the full equation in natural language and will be made available to Assistive Technology. You can learn more in the [Textual Representations section of the Accessibility Guide](https://typst.app/docs/guides/accessibility/#textual-representations).

```typst

#math.equation(
  alt: "integral from 1 to infinity of a x squared plus b with respect to x",
  block: true,
  $ integral_1^oo a x^2 + b dif x $,
)
```

Default: none 

 `body`  [content](https://typst.app/docs/reference/foundations/content/)  Required  Positional
The contents of the equation.


## Symbols

These two modules give names to symbols and emoji to make them easy to insert with a normal keyboard. Alternatively, you can also always directly enter Unicode symbols into your text and formulas. In addition to the symbols listed below, math mode defines `dif` and `Dif`. These are not normal symbol values because they also affect spacing and font style.

You can define custom symbols with the constructor function of the [symbol](https://typst.app/docs/reference/foundations/symbol/) type.

### Definitions

- [`sym`](https://typst.app/docs/reference/symbols/sym/)These two modules give names to symbols and emoji to make them easy to insert with a normal keyboard.
- [`emoji`](https://typst.app/docs/reference/symbols/emoji/)These two modules give names to symbols and emoji to make them easy to insert with a normal keyboard.

### Shorthands

Shorthands are concise sequences of characters that evoke specific glyphs. Shorthands and other ways to produce symbols can be used interchangeably. You can use different sets of shorthands in math and markup mode. Some shorthands, like `~` for a non-breaking space produce non-printing symbols, which are indicated with gray placeholder text.

You can deactivate a shorthand's interpretation by escaping any of its characters. If you escape a single character in a shorthand, the remaining unescaped characters may form a different shorthand.


## Layout

Arranging elements on the page in different ways.

By combining layout functions, you can create complex and automatic layouts. 

### Definitions

- [`align`](https://typst.app/docs/reference/layout/align/)Aligns content horizontally and vertically.
- [`alignment`](https://typst.app/docs/reference/layout/alignment/)Where to align something along an axis.
- [`angle`](https://typst.app/docs/reference/layout/angle/)An angle describing a rotation.
- [`block`](https://typst.app/docs/reference/layout/block/)A block-level container.
- [`box`](https://typst.app/docs/reference/layout/box/)An inline-level container that sizes content.
- [`colbreak`](https://typst.app/docs/reference/layout/colbreak/)Forces a column break.
- [`columns`](https://typst.app/docs/reference/layout/columns/)Separates a region into multiple equally sized columns.
- [`direction`](https://typst.app/docs/reference/layout/direction/)The four directions into which content can be laid out.
- [`fraction`](https://typst.app/docs/reference/layout/fraction/)Defines how the remaining space in a layout is distributed.
- [`grid`](https://typst.app/docs/reference/layout/grid/)Arranges content in a grid.
- [`h`](https://typst.app/docs/reference/layout/h/)Inserts horizontal spacing into a paragraph.
- [`hide`](https://typst.app/docs/reference/layout/hide/)Hides content without affecting layout.
- [`layout`](https://typst.app/docs/reference/layout/layout/)Provides access to the current outer container's (or page's, if none) dimensions (width and height).
- [`length`](https://typst.app/docs/reference/layout/length/)A size or distance, possibly expressed with contextual units.
- [`measure`](https://typst.app/docs/reference/layout/measure/)Measures the layouted size of content.
- [`move`](https://typst.app/docs/reference/layout/move/)Moves content without affecting layout.
- [`pad`](https://typst.app/docs/reference/layout/pad/)Adds spacing around content.
- [`page`](https://typst.app/docs/reference/layout/page/)Layouts its child onto one or multiple pages.
- [`pagebreak`](https://typst.app/docs/reference/layout/pagebreak/)A manual page break.
- [`place`](https://typst.app/docs/reference/layout/place/)Places content relatively to its parent container.
- [`ratio`](https://typst.app/docs/reference/layout/ratio/)A ratio of a whole.
- [`relative`](https://typst.app/docs/reference/layout/relative/)A length in relation to some known length.
- [`repeat`](https://typst.app/docs/reference/layout/repeat/)Repeats content to the available space.
- [`rotate`](https://typst.app/docs/reference/layout/rotate/)Rotates content without affecting layout.
- [`scale`](https://typst.app/docs/reference/layout/scale/)Scales content without affecting layout.
- [`skew`](https://typst.app/docs/reference/layout/skew/)Skews content.
- [`stack`](https://typst.app/docs/reference/layout/stack/)Arranges content and spacing horizontally or vertically.
- [`v`](https://typst.app/docs/reference/layout/v/)Inserts vertical spacing into a flow of blocks.

## align  

`Element`

Aligns content horizontally and vertically.

### Example
Let's start with centering our content horizontally:

```typst
#set align(center)

Centered text, a sight to see \ 
In perfect balance, visually \ 
Not left nor right, it stands alone \ 
A work of art, a visual throne \ 
```

To center something vertically, use _horizon_ alignment:

```typst
#set align(right+top)

Vertically centered, \ 
the stage had entered, \ 
a new paragraph.
```

Combining alignments

You can combine two alignments with the `+` operator. Let's also only apply this to one piece of content by using the function form instead of a set rule:

```typst
Though left in the beginning ...

#align(left + bottom)[
  ... they were right in the end, \
  and with addition had gotten, \
  the paragraph to the bottom!
]
```

Nested alignment

You can use varying alignments for layout containers and the elements within them. This way, you can create intricate layouts:

```typst

#align(center, block[
  #set align(left)
  Though centered together \
  alone \
  we \
  are \
  left.
])

#import "@preview/cetz:0.4.2"
#align(left, block[
  #set align(left)
  #cetz.canvas({
  import cetz.draw:*
  // Draw a red triangle + a blue circle + some text
  stroke(red + 1.4pt)
  fill(blue.transparentize(80%))
  line((0,0), (4,0), (2,3), close: true)
  fill(none)
  stroke(blue + 2pt)
  circle((2,1), radius: 1.2)
  content((2,3.5), text(14pt, weight: "bold", fill: eastern)[Hello CeTZ!])
    })
])
```


```typst
#set math.equation(numbering: "(1)", number-align:end, supplement: [Eq.])

#align(left+bottom, block(width: 6cm)[ 
We define:$ display(phi.alt := (1 + sqrt(5)) / 2) $ <ratio> 
])
```


```typst
#set math.equation(numbering: "(1)", number-align:end, supplement: [Eq.])
#block(width:4cm)[We define:$ display(phi.alt := (1 + sqrt(5)) / 2) $ <ratio> ]
```


Alignment within the same line

The `align` function performs block-level alignment and thus always interrupts the current paragraph. To have different alignment for parts of the same line, you should use [fractional spacing](https://typst.app/docs/reference/layout/h/) instead:

```typst
Start #h(4fr) End
```

Parameters

```
align( alignment, content,) -> content
```

`alignment`  [alignment](https://typst.app/docs/reference/layout/alignment/)   Positional  Settable

The [alignment](https://typst.app/docs/reference/layout/alignment/ "alignment") along both axes.

```typst

#set text(lang: "zh")

角落
#align(
  start + horizon,
  rect(inset: 12pt)[角落]
)
```

Default: `start + top`  

 `body`   [content](https://typst.app/docs/reference/foundations/content/)   Required   Positional
The content to align.

## page 

Layouts its child onto one or multiple pages. 
Although this function is primarily used in set rules to affect page properties, it can also be used to explicitly render its argument onto a set of pages of its own.
Pages can be set to use `auto` as their width or height. In this case, the pages will grow to fit their content on the respective axis.
The [Guide for Page Setup](https://typst.app/docs/guides/page-setup/) explains how to use this and related functions to set up a document with many examples.

### Example

```
#set page("us-letter")
There you go, US friends!
```

Accessibility
The contents of the page's header, footer, foreground, and background are invisible to Assistive Technology (AT) like screen readers. Only the body of the page is read by AT. Do not include vital information not included elsewhere in the document in these areas.

### Parameters

```
page(
paper: str,
width: auto length,
height: auto length,
flipped: bool,
margin: auto relative dictionary,
binding: auto alignment,
columns: int,
fill: none auto color gradient tiling,
numbering: none str function,
supplement: none auto content,
number-align: alignment,
header: none auto content,
header-ascent: relative,
footer: none auto content,
footer-descent: relative,
background: none content,
foreground: none content,
body: content,
) -> content
```

```new
#set page(width: 20cm, height: 15cm, columns:2, fill:none,)
#set text(fill:luma(80%),size:1.5em)
#page[#lorem(100)]
```

### paper

A standard paper size to set width and height in Typst.
This is just a shorthand for setting `width` and `height` and, as such, cannot be retrieved in a context expression.

width
The width of the page.

```typst
#for i in range(3) {
  box(square(width: 1cm))
}
```

Default: `595.28pt`

`for-loop syntax`
The Typst code snippet above renders as expected. But I am confused by the syntax of "#for i in range(3) { box(square(width: 1cm)) }". Please provide a clear explanation for me.
 
The syntax `#for i in range(3) { box(square(width: 1cm)) }` looks a bit unusual if you're coming from languages like Python or JavaScript, but it's actually very clean and idiomatic Typst. Here’s a clear breakdown of what’s happening:

```
#for i in range(3) { box(square(width: 1cm)) }
```

Step-by-step explanation

1. `#` (hash / hash mark)  
   Everything that starts with `#` is code mode (scripting / programming) in Typst.  
   Without `#`, Typst would treat the text as markup / content mode.

2. `for … in …`  
   This is Typst’s for-loop syntax.  
   Pattern:  
```
#for <loop-variable> in <iterable> { ... }
```

3. `range(3)`  
   `range(n)` is a built-in function that creates an iterator of integers:  
   - `range(3)` → 0, 1, 2  
   - `range(1, 4)` → 1, 2, 3  
   - `range(0, 6, 2)` → 0, 2, 4  

So here it produces three values: 0, 1, 2.

4. `i`    This is just the loop variable name — you could also write `for x in range(3)` or `for item in range(3)`.  
   Importantly: you don’t actually use `i` inside the loop body in your example → that’s perfectly fine.

5. `{ … }` (code block)  
   The curly braces contain the body that gets executed for each value of the loop.  
   → Typst will run the content inside `{}` three times.

6. `box(square(width: 1cm))`  
   This is the content that gets produced on each iteration:

   - `square(width: 1cm)` → creates a square of side length 1cm  
   - `box(…)` → wraps it in a box (most importantly: makes sure it is placed as a block-level item and not merged with adjacent content) ???
   So each loop iteration produces one 1cm × 1cm black square.

7. Putting it together  
   Because the loop body produces content (not just calculations), Typst collects all the generated content and places it in sequence in the document flow.

```typ
#for i in range(3) { box(square(width: 1cm)) }
```

   is exactly equivalent to writing:

   ```typ
   #box(square(width: 1cm))
   #box(square(width: 1cm))
   #box(square(width: 1cm))
   ```

   → three 1 cm squares appear side by side (because your page is 3 cm wide and margin x = 0 cm).

Summary – most common patterns

| What you want                        | Typst idiom                                      |
|--------------------------------------|--------------------------------------------------|
| Repeat content n times               | `#for _ in range(n) { … }`                       |
| Repeat and use the counter           | `#for i in range(5) { [Item #(i+1)] }`          |
| Loop over array                      | `#for color in (red, blue, green) { … }`        |
| Just calculate something (no output) | `#for i in range(10) { /* nothing */ }`         |

So in short:

- `#` → enter code mode  
- `for i in range(3)` → repeat 3 times (i = 0,1,2)  
- `{ box(…) }` → produce this piece of content each time

Hope this clears up the confusion! Feel free to ask about other patterns (e.g. `#grid()`, `#locate()`, or loops with counters). 


`height`
The height of the page.
If this is set to `auto`, page breaks can only be triggered manually by inserting a [page break](https://typst.app/docs/reference/layout/pagebreak/) or by adding another non-empty page set rule. Most examples throughout this documentation use `auto` for the height of the page to dynamically grow and shrink to fit their content.
Default: `841.89pt`

flipped
Whether the page is flipped into landscape orientation. 

```typst
#set align(bottom + end)
#text(14pt)[*Sam H. Richards*] \
_Procurement Manager_

#set text(10pt)
17 Main Street \
New York, NY 10001 \
+1 555 555 5555
```

Default: `false`

`margin`

The page's margins. 

- `auto`: The margins are set automatically to 2.5/21 times the smaller dimension of the page. This results in 2.5 cm margins for an A4 page.
- A single length: The same margin on all sides.
- A dictionary: With a dictionary, the margins can be set individually. The dictionary can contain the following keys in order of precedence:
    - `top`: The top margin.
    - `right`: The right margin.
    - `bottom`: The bottom margin.
    - `left`: The left margin.
    - `inside`: The margin at the inner side of the page (where the [binding](https://typst.app/docs/reference/layout/page/#parameters-binding) is).
    - `outside`: The margin at the outer side of the page (opposite to the [binding](https://typst.app/docs/reference/layout/page/#parameters-binding)).
    - `x`: The horizontal margins.
    - `y`: The vertical margins.
    - `rest`: The margins on all sides except those for which the dictionary explicitly sets a size.

All keys are optional; omitted keys will use their previously set value, or the default margin if never set. In addition, the values for `left` and `right` are mutually exclusive with the values for `inside` and `outside`.

```typ
#set page( width: 3cm, height: 4cm, margin: (x: 8pt, y: 4pt),)

#rect( width: 100%, height: 100%, fill: aqua,)
```

Default: `auto`

binding
On which side the pages will be bound. 

- `auto`: Equivalent to `left` if the [text direction](https://typst.app/docs/reference/text/text/#parameters-dir) is left-to-right and `right` if it is right-to-left. 
- `left`: Bound on the left side.
- `right`: Bound on the right side.

This affects the meaning of the `inside` and `outside` options for margins.
Default: `auto`

columns
How many columns the page has. 
If you need to insert columns into a page or other container, you can also use the [`columns` function](https://typst.app/docs/reference/layout/columns/).

```typ
// #set page(columns: 2, height: 4.8cm)
#set page(fill: rgb("444352"))
#set text(fill: rgb("fdfdfd"))
Climate change is one of the most pressing issues of our time, with the potential to devastate
communities, ecosystems, and economies around the world. It's clear that we need to take urgent
action to reduce our carbon emissions and mitigate the impacts of a rapidly changing climate.
```

Default: `1`

`fill`
The page's background fill.
Setting this to something non-transparent instructs the printer to color the complete page. If you are considering larger production runs, it may be more environmentally friendly and cost-effective to source pre-dyed pages and not set this property. 
When set to `none`, the background becomes transparent. Note that PDF pages will still appear with a (usually white) background in viewers, but they are actually transparent. (If you print them, no color is used for the background.)
The default of `auto` results in `none` for PDF output, and `white` for PNG and SVG. 

```typ
#set page(fill: rgb("444352"))
#set text(fill: rgb("fdfdfd"))
*Dark mode enabled.*
```

Default: `auto`

numbering
How to number the pages. You can refer to the Page Setup Guide for [customizing page numbers](https://typst.app/docs/guides/page-setup/#page-numbers).
Accepts a [numbering pattern or function](https://typst.app/docs/reference/model/numbering/) taking one or two numbers:

1. The first number is the current page number.
2. The second number is the total number of pages. In a numbering pattern, the second number can be omitted. If a function is passed, it will receive one argument in the context of links or references, and two arguments when producing the visible page numbers.

These are logical numbers controlled by the page counter, and may thus not match the physical numbers. Specifically, they are the [current](https://typst.app/docs/reference/introspection/counter/#definitions-get) and the [final](https://typst.app/docs/reference/introspection/counter/#definitions-final) value of `counter(page)`. See the [`counter`](https://typst.app/docs/reference/introspection/counter/#page-counter) documentation for more details.

If an explicit [`footer`](https://typst.app/docs/reference/layout/page/#parameters-footer) (or [`header`](https://typst.app/docs/reference/layout/page/#parameters-header) for [top-aligned](https://typst.app/docs/reference/layout/page/#parameters-number-align) numbering) is given, the numbering is ignored.

```typ
#set page( height: 100pt, margin: (top: 16pt, bottom: 24pt), numbering: "1 / 1",)
#lorem(48)
```
Default: `none`

`supplement`
A supplement for the pages.
For page references, this is added before the page number.

```typ
#set page(numbering: "1/1", supplement: [page.])

= Introduction <intro>
We are on #ref(<intro>, form: "page")!
```

Default: `auto`

`number-align`
The alignment of the page numbering.
If the vertical component is `top`, the numbering is placed into the header and if it is `bottom`, it is placed in the footer. Horizon alignment is forbidden. If an explicit matching `header` or `footer` is given, the numbering is ignored.

```typ
#set page( margin: (top: 16pt, bottom: 24pt), numbering: "1", number-align: right,)
#lorem(30)
```
Default: `center + bottom`

`header`
The page's header. Fills the top margin of each page. 
- `Content`: Shows the content as the header. 
- `auto`: Shows the page number if a [`numbering`](https://typst.app/docs/reference/layout/page/#parameters-numbering) is set and [`number-align`](https://typst.app/docs/reference/layout/page/#parameters-number-align) is `top`. 
- `none`: Suppresses the header. 

```typ
#set par(justify: true)
#set page( 
  margin: (top: 32pt, bottom: 20pt),
  header: [
    #set text(8pt) 
    #smallcaps[Typst Academy] 
    #h(1fr) _Exercise Sheet 3_ 
  ],
)
#lorem(49)
```
Default: `auto`

header-ascent
The amount the header is raised into the top margin.
Default: `30% + 0pt`

`footer`
The page's footer. Fills the bottom margin of each page.

- Content: Shows the content as the footer.
- `auto`: Shows the page number if a [`numbering`](https://typst.app/docs/reference/layout/page/#parameters-numbering) is set and [`number-align`](https://typst.app/docs/reference/layout/page/#parameters-number-align) is `bottom`.
- `none`: Suppresses the footer.

For just a page number, the `numbering` property typically suffices. If you want to create a custom footer but still display the page number, you can directly access the [page counter](https://typst.app/docs/reference/introspection/counter/).

```typ
#set par(justify: true)
#set page(
  height: 100pt,
  margin: 20pt,
  footer: context [
    #set align(right)
    #set text(8pt)
    #counter(page).display(
      "1 of I",
      both: true,
    )
  ]
)

#lorem(48)
```
Default: `auto`

footer-descent
The amount the footer is lowered into the bottom margin.
Default: `30% + 0pt`

`background`
Content in the page's background.
This content will be placed behind the page's body. It can be used to place a background image or a watermark.

```typ
#set page(background: rotate(24deg, text(18pt, fill: rgb("FFCBC4"))[*CONFIDENTIAL*]))

= Typst's secret plans
In the year 2023, we plan to take over the world (of typesetting). \
#lorem(150)
```

Default: `none`

`foreground`
Content in the page's foreground. 
This content will overlay the page's body. 

```typ
#set page(foreground: text(24pt)[🤓])

Reviewer 2 has marked our paper "Weak Reject" because they did not understand our approach... \ 
#lorem(50)
```

Default: `none`

`body`
The contents of the page(s).
Multiple pages will be created if the content does not fit on a single page. A new page with the page properties prior to the function invocation will be created after the body has been typeset. 
Default: `[]`

## Visualize

Drawing and data visualization.

If you want to create more advanced drawings or plots, also have a look at the [CeTZ](https://github.com/johannes-wolf/cetz) package as well as more specialized [packages](https://typst.app/universe/) for your use case.

### Accessibility

All shapes and paths drawn by Typst are automatically marked as [artifacts](https://typst.app/docs/reference/pdf/artifact/) to make them invisible to Assistive Technology (AT) during PDF export. However, their contents (if any) remain accessible.

If you are using the functions in this model to create an illustration with semantic meaning, make it accessible by wrapping it in a [`figure`](https://typst.app/docs/reference/model/figure/ "`figure`") function call. Use its [`alt` parameter](https://typst.app/docs/reference/model/figure/#parameters-alt) to provide an [alternative description](https://typst.app/docs/guides/accessibility/#textual-representations).

### Definitions

- [`circle`](https://typst.app/docs/reference/visualize/circle/)A circle with optional content.
- [`color`](https://typst.app/docs/reference/visualize/color/)A color in a specific color space.
- [`curve`](https://typst.app/docs/reference/visualize/curve/)A curve consisting of movements, lines, and Bézier segments.
- [`ellipse`](https://typst.app/docs/reference/visualize/ellipse/)An ellipse with optional content.
- [`gradient`](https://typst.app/docs/reference/visualize/gradient/)A color gradient.
- [`image`](https://typst.app/docs/reference/visualize/image/)A raster or vector graphic.
- [`line`](https://typst.app/docs/reference/visualize/line/)A line from one point to another.
- [`path`](https://typst.app/docs/reference/visualize/path/)A path through a list of points, connected by Bézier curves.
- [`polygon`](https://typst.app/docs/reference/visualize/polygon/)A closed polygon.
- [`rect`](https://typst.app/docs/reference/visualize/rect/)A rectangle with optional content.
- [`square`](https://typst.app/docs/reference/visualize/square/)A square with optional content.
- [`stroke`](https://typst.app/docs/reference/visualize/stroke/)Defines how to draw a line.
- [`tiling`](https://typst.app/docs/reference/visualize/tiling/)A repeating tiling fill.


## Introspection

Interactions between document parts.

This category is home to Typst's introspection capabilities: With the `counter` function, you can access and manipulate page, section, figure, and equation counters or create custom ones. Meanwhile, the `query` function lets you search for elements in the document to construct things like a list of figures or headers which show the current chapter title.

Most of the functions are _contextual._ It is recommended to read the chapter on [context](https://typst.app/docs/reference/context/ "context") before continuing here.

### Definitions

- [`counter`](https://typst.app/docs/reference/introspection/counter/)Counts through pages, elements, and more.
- [`here`](https://typst.app/docs/reference/introspection/here/)Provides the current location in the document.
- [`locate`](https://typst.app/docs/reference/introspection/locate/)Determines the location of an element in the document.
- [`location`](https://typst.app/docs/reference/introspection/location/)Identifies an element in the document.
- [`metadata`](https://typst.app/docs/reference/introspection/metadata/)Exposes a value to the query system without producing visible content.
- [`query`](https://typst.app/docs/reference/introspection/query/)Finds elements in the document.
- [`state`](https://typst.app/docs/reference/introspection/state/)Manages stateful parts of your document.



## Data Loading

Data loading from external files.

These functions help you with loading and embedding data, for example from the results of an experiment.

### Encoding

Some of the functions are also capable of encoding, e.g. [`cbor.encode`](https://typst.app/docs/reference/data-loading/cbor/#definitions-encode "`cbor.encode`"). They facilitate passing structured data to [plugins](https://typst.app/docs/reference/foundations/plugin/).

However, each data format has its own native types. Therefore, for an arbitrary Typst value, the encode-to-decode roundtrip might be lossy. In general, numbers, strings, and [arrays](https://typst.app/docs/reference/foundations/array/) or [dictionaries](https://typst.app/docs/reference/foundations/dictionary/) composed of them can be reliably converted, while other types may fall back to strings via [`repr`](https://typst.app/docs/reference/foundations/repr/ "`repr`"), which is [for debugging purposes only](https://typst.app/docs/reference/foundations/repr/#debugging-only). Please refer to the page of each data format for details.

### Definitions

- [`cbor`](https://typst.app/docs/reference/data-loading/cbor/)Reads structured data from a CBOR file.
- [`csv`](https://typst.app/docs/reference/data-loading/csv/)Reads structured data from a CSV file.
- [`json`](https://typst.app/docs/reference/data-loading/json/)Reads structured data from a JSON file.
- [`read`](https://typst.app/docs/reference/data-loading/read/)Reads plain text or data from a file.
- [`toml`](https://typst.app/docs/reference/data-loading/toml/)Reads structured data from a TOML file.
- [`xml`](https://typst.app/docs/reference/data-loading/xml/)Reads structured data from an XML file.
- [`yaml`](https://typst.app/docs/reference/data-loading/yaml/)Reads structured data from a YAML file.


## SVG

Instead of creating a PDF, Typst can also directly render pages to scalable vector graphics (SVGs), which are the preferred format for embedding vector graphics in web pages. Like PDF files, SVGs display your document exactly how you have laid it out in Typst. Likewise, they share the benefit of not being bound to a specific resolution. Hence, you can print or view SVG files on any device without incurring a loss of quality. (Note that font printing quality may be better with a PDF.) In contrast to a PDF, an SVG cannot contain multiple pages. When exporting a multi-page document, Typst will emit multiple SVGs.

SVGs can represent text in two ways: By embedding the text itself and rendering it with the fonts available on the viewer's computer or by embedding the shapes of each glyph in the font used to create the document. To ensure that the SVG file looks the same across all devices it is viewed on, Typst chooses the latter method. This means that the text in the SVG cannot be extracted automatically, for example by copy/paste or a screen reader. If you need the text to be accessible, export a PDF or HTML file instead.

SVGs can have transparent backgrounds. By default, Typst will output an SVG with an opaque white background. You can make the background transparent using `#set page(fill: none)`. Learn more on the [`page` function's reference page](https://typst.app/docs/reference/layout/page/#parameters-fill).

### Exporting as SVG

#### Command Line

Pass `--format svg` to the `compile` or `watch` subcommand or provide an output file name that ends with `.svg`.

If your document has more than one page, Typst will create multiple image files. The output file name must then be a template string containing at least one of

- `{p}`, which will be replaced by the page number
- `{0p}`, which will be replaced by the zero-padded page number (so that all numbers have the same length)
- `{t}`, which will be replaced by the total number of pages

When exporting to SVG, you have the following configuration options:

- Which pages to export by specifying `--pages` followed by a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.

#### Web App

Click "File" > "Export as" > "SVG" or click the downwards-facing arrow next to the quick download button and select "Export as SVG". When exporting to SVG, you have the following configuration options:

- Which pages to export. Valid options are "All pages", "Current page", and "Custom ranges". Custom ranges are a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.



## PNG

Instead of creating a PDF, Typst can also directly render pages to PNG raster graphics. PNGs are losslessly compressed images that can contain one page at a time. When exporting a multi-page document, Typst will emit multiple PNGs. PNGs are a good choice when you want to use Typst's output in an image editing software or when you can use none of Typst's other export formats.

In contrast to Typst's other export formats, PNGs are bound to a specific resolution. When exporting to PNG, you can configure the resolution as pixels per inch (PPI). If the medium you view the PNG on has a finer resolution than the PNG you exported, you will notice a loss of quality. Typst calculates the resolution of your PNGs based on each page's physical dimensions and the PPI. If you need guidance for choosing a PPI value, consider the following:

- A value of 300 or 600 is typical for desktop printing.
- Professional prints of detailed graphics can go up to 1200 PPI.
- If your document is only viewed at a distance, e.g. a poster, you may choose a smaller value than 300.
- If your document is viewed on screens, a typical PPI value for a smartphone is 400-500.

Because PNGs only contain a pixel raster, the text within cannot be extracted automatically (without OCR), for example by copy/paste or a screen reader. If you need the text to be accessible, export a PDF or HTML file instead.

PNGs can have transparent backgrounds. By default, Typst will output a PNG with an opaque white background. You can make the background transparent using `#set page(fill: none)`. Learn more on the [`page` function's reference page](https://typst.app/docs/reference/layout/page/#parameters-fill).

### Exporting as PNG

#### Command Line

Pass `--format png` to the `compile` or `watch` subcommand or provide an output file name that ends with `.png`.

If your document has more than one page, Typst will create multiple image files. The output file name must then be a template string containing at least one of

- `{p}`, which will be replaced by the page number
- `{0p}`, which will be replaced by the zero-padded page number (so that all numbers have the same length)
- `{t}`, which will be replaced by the total number of pages

When exporting to PNG, you have the following configuration options:

- Which resolution to render at by specifying `--ppi` followed by a number of pixels per inch. The default is `144`.
    
- Which pages to export by specifying `--pages` followed by a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.
    

#### Web App

Click "File" > "Export as" > "PNG" or click the downwards-facing arrow next to the quick download button and select "Export as PNG". When exporting to PNG, you have the following configuration options:

- The resolution at which the pages should be rendered, as a number of pixels per inch. The default is `144`.
    
- Which pages to export. Valid options are "All pages", "Current page", and "Custom ranges". Custom ranges are a comma-separated list of numbers or dash-separated number ranges. Ranges can be half-open. Example: `2,3,7-9,11-`.




## Guides

Welcome to the Guides section! Here, you'll find helpful material for specific user groups or use cases. Please see the list below for the available guides. Feel free to propose other topics for guides!

### List of Guides

- [Guide for LaTeX Users](https://typst.app/docs/guides/for-latex-users/)
- [Page Setup Guide](https://typst.app/docs/guides/page-setup/)
- [Table Guide](https://typst.app/docs/guides/tables/)
- [Accessibility Guide](https://typst.app/docs/guides/accessibility/)


## Changelog

Learn what has changed in the latest Typst releases and move your documents forward. This section documents all changes to Typst since its initial public release.

### Versions

- [Typst 0.14.2](https://typst.app/docs/changelog/0.14.2/)
- [Typst 0.14.1](https://typst.app/docs/changelog/0.14.1/)
- [Typst 0.14.0](https://typst.app/docs/changelog/0.14.0/)
- [Typst 0.13.1](https://typst.app/docs/changelog/0.13.1/)
- [Typst 0.13.0](https://typst.app/docs/changelog/0.13.0/)
- [Typst 0.12.0](https://typst.app/docs/changelog/0.12.0/)
- [Typst 0.11.1](https://typst.app/docs/changelog/0.11.1/)
- [Typst 0.11.0](https://typst.app/docs/changelog/0.11.0/)
- [Typst 0.10.0](https://typst.app/docs/changelog/0.10.0/)
- [Typst 0.9.0](https://typst.app/docs/changelog/0.9.0/)
- [Typst 0.8.0](https://typst.app/docs/changelog/0.8.0/)
- [Typst 0.7.0](https://typst.app/docs/changelog/0.7.0/)
- [Typst 0.6.0](https://typst.app/docs/changelog/0.6.0/)
- [Typst 0.5.0](https://typst.app/docs/changelog/0.5.0/)
- [Typst 0.4.0](https://typst.app/docs/changelog/0.4.0/)
- [Typst 0.3.0](https://typst.app/docs/changelog/0.3.0/)
- [Typst 0.2.0](https://typst.app/docs/changelog/0.2.0/)
- [Typst 0.1.0](https://typst.app/docs/changelog/0.1.0/)
- [Earlier](https://typst.app/docs/changelog/earlier/)


## Web App

_Please note that this section is still under construction and may be incomplete._

The Typst web app is a collaborative environment made to work on Typst projects. It features an editor with live-preview and real-time synchronization with your co-authors. You can upload images and other files to load and display them in your document.

It also offers various settings to work with others, from sharing a specific project using a link, to creating a team to collaborate on a set of related projects. You can refer to our documentation on [user accounts, projects and teams](https://typst.app/docs/web-app/concepts) for more details about what the Typst web app is capable of and how you can use it to best match your workflow.

Many features of the web app are free, only an account is required. Certain more advanced features can be unlocked with a [Typst Pro subscription](https://typst.app/pricing). It's also possible to get a license to host the web app [on-premises](https://typst.app/pricing) using your company's infrastructure.


## Roadmap

This page lists planned features for the Typst language, compiler, library and web app. Since priorities and development realities change, this roadmap is not set in stone. Features that are listed here will not necessarily be implemented and features that will be implemented might be missing here. Moreover, this roadmap only lists larger, more fundamental features and bugs.

Are you missing something on the roadmap? Typst relies on your feedback as a user to plan for and prioritize new features. Get started by filing a new issue on [GitHub](https://github.com/typst/typst/issues) or discuss your feature request with the [community](https://typst.app/docs/community).

### Language and Compiler

- **Styling**
    
    - Support for revoking style rules
    - Ancestry selectors (e.g., within)
    - ~~Fix show rule recursion crashes~~
    - ~~Fix show-set issues~~
- **Scripting**
    
    - Function for debug logging
    - Fix issues with paths being strings
    - Custom types (that work with set and show rules)
    - Type hints
    - Function hoisting (if feasible)
    - ~~Data loading functions~~
    - ~~Support for compiler warnings~~
    - ~~Types as first-class values~~
    - ~~More fields and methods on primitives~~
    - ~~WebAssembly plugins~~
    - ~~Get values of set rules~~
    - ~~Replace locate, etc. with unified context system~~
    - ~~Allow expressions as dictionary keys~~
    - ~~Package management~~
- **Model**
    
    - Fix issues with numbering patterns
    - Better support for custom referenceable things
    - Enum continuation
    - ~~Richer built-in outline customization~~
    - ~~Support a path or bytes in places that currently only support paths, superseding `.decode` scoped functions~~ (not yet released)
    - ~~Bibliography and citation customization via CSL (Citation Style Language)~~
    - ~~Relative counters, e.g. for figure numbering per section~~
- **Text**
    
    - Font fallback warnings
    - Bold, italic, and smallcaps synthesis
    - Variable fonts support
    - Ruby and Warichu
    - Kashida justification
    - ~~Support for basic CJK text layout rules~~
    - ~~Fix SVG font fallback~~
    - ~~Themes for raw text and more/custom syntaxes~~
- **Math**
    
    - Fix attachment parsing priorities
    - Fix syntactic quirks
    - Fix font handling
    - Provide more primitives
    - Improve equation numbering
    - Big fractions
    - ~~Fix single letter strings~~
- **Layout**
    
    - Fix issues with list (in particular baselines & alignment)
    - Balanced columns
    - Support for side-floats and other "collision" layouts
    - Drop caps
    - End notes, maybe margin notes
    - Page adjustment from within flow
    - Chained layout regions
    - Better support for more canvas-like layouts
    - Grid-based typesetting
    - Maybe unified layout primitives across normal content and math
    - ~~Character-level justification~~
    - ~~Improve widow & orphan prevention~~
    - ~~Expand floating layout (e.g. over two columns)~~
    - ~~Support for "sticky" blocks that stay with the next one~~
    - ~~Fix footnote issues~~ (not all released yet)
    - ~~Footnotes~~
    - ~~Basic floating layout~~
    - ~~Row span and column span in table~~
    - ~~Per-cell table stroke customization~~
- **Visualize**
    
    - Arrows
    - Color management
    - ~~PDFs as images~~
    - ~~Better path drawing~~
    - ~~More configurable strokes~~
    - ~~Gradients~~
    - ~~Patterns~~
- **Introspection**
    
    - Better diagnostics for non-convergence
    - Support for freezing content, so that e.g. numbers in it remain the same if it appears multiple times
- **Export**
    
    - HTML export (in progress)
    - PDF/UA-2 support
    - PDF/X support
    - EPUB export
    - ~~Tagged PDF for Accessibility~~
    - ~~PDF/A support~~
    - ~~PNG export~~
    - ~~SVG export~~
    - ~~Support for transparency in PDF~~
    - ~~Fix issues with SVGs in PDF~~
    - ~~Fix emoji export in PDF~~
    - ~~Selectable text in SVGs in PDF~~
    - ~~Better font subsetting for smaller PDFs~~
- **CLI**
    
    - Support for downloading fonts on-demand automatically
    - ~~`typst query` for querying document elements~~
    - ~~`typst init` for creating a project from a template~~
    - ~~`typst update` for self-updating the CLI~~
- **Tooling**
    
    - Autoformatter
    - Documentation generator and doc comments
    - Linter
- **Performance**
    
    - Reduce memory usage
    - ~~Optimize runtime of optimal paragraph layout~~
    - ~~Parallelize layout engine~~
- **Development**
    
    - Benchmarking
    - Better contributor documentation

### Web App

- **Editing**
    
    - Smarter & more action buttons
    - Inline documentation
    - Preview autocomplete entry
    - Color Picker
    - Symbol picker
    - Basic, built-in image editor (cropping, etc.)
    - GUI inspector for editing function calls
    - Cursor in preview
    - ~~Hover tooltips for debugging~~
    - ~~Scroll to cursor position in preview~~
    - ~~Folders in projects~~
    - ~~Outline panel~~
    - ~~More export options~~
    - ~~Preview in a separate window~~
    - ~~Sync literature with Zotero and Mendely~~
    - ~~Paste modal~~
    - ~~Improve panel~~
- **Writing**
    
    - Word count
    - Structure view
    - Text completion by LLM
    - ~~Spell check~~
- **Collaboration**
    
    - Change tracking
    - Version history
    - ~~Chat-like comments~~
    - ~~Git integration~~
- **Project management**
    
    - ~~Drag-and-drop for projects~~~
    - ~~Folders for projects~~
    - ~~LaTeX, Word, Markdown import~~
    - ~~Thumbnails for projects~~
- **Settings**
    
    - Keyboard shortcuts configuration
    - Better project settings
    - Avatar Cropping
    - ~~System Theme setting~~
- **Other**
    
    - Mobile improvements
    - Two-Factor Authentication
    - Advanced search in projects
    - Offline PWA
    - ~~Private packages in teams~~
    - ~~LDAP Single sign-on~~
    - ~~Compiler version picker~~
    - ~~Presentation mode~~
    - ~~Support for On-Premises deployment~~
    - ~~Typst Universe~~



## Community

Hey and welcome to the Community page! We're so glad you're here. Typst is developed by an early-stage startup and it is still early days, but it would be pointless without people like you who are interested in it.

We would love to not only hear from you but to also provide spaces where you can discuss any topic around Typst, typesetting, writing, the sciences, and typography with other likeminded people.

**Our [Forum](https://forum.typst.app/) is the best place to get answers for questions on Typst and to show off your creations.** If you would like to chat with the community and shape the future development of Typst, we would like to also invite you to our [Discord server](https://discord.gg/2uDybryKPe). We coordinate our open-source work there, but you can also iterate on Typst projects and discuss off-topic things with the community members. Both the Forum and the Discord server are open for everyone. Of course, you are also very welcome to connect with us on social media ([Mastodon](https://mastodon.social/@typst), [Bluesky](https://bsky.app/profile/typst.app), [Instagram](https://instagram.com/typstapp/), [LinkedIn](https://linkedin.com/company/typst), and [GitHub](https://github.com/typst)).

### What to share?

For our community, we want to foster versatility and inclusivity. You are welcome to post about any topic that you think would interest other community members, but if you need a little inspiration, here are a few ideas:

- Share and discuss your thoughts and ideas for new features or improvements you'd like to see in Typst
- Showcase documents you've created with Typst, or share any unique or creative ways you've used the platform
- Share importable files or templates that you use to style your documents
- Alert us of bugs you encounter while using Typst

### Following the development

Typst is still under very active development and breaking changes can occur at any point. The compiler is developed in the open on [GitHub](https://github.com/typst/typst).

We will update the members of our Discord server and our social media followers when new features become available. We'll also update you on the development progress of large features.

### How to support Typst

If you want to support Typst, there are multiple ways to do that! You can [contribute to the code](https://github.com/typst/typst) or [translate the strings in Typst](https://github.com/search?q=repo%3Atypst%2Ftypst+impl+LocalName+for&type=code) to your native language if it's not supported yet. You can also help us by [subscribing to the paid tier of our web app](https://typst.app/pricing) or [sponsoring our open-source efforts!](https://github.com/sponsors/typst) Multiple recurring sponsorship tiers are available and all of them come with a set of goodies. No matter how you contribute, thank you for your support!

### Community Rules

We want to make our community a safe and inclusive space for everyone. Therefore, we will not tolerate any sexual harassment, sexism, political attacks, derogatory language or personal insults, racism, doxing, and other inappropriate behaviour. We pledge to remove members that are in violation of these rules. [Contact us](https://typst.app/contact/) if you think another community member acted inappropriately towards you. All complaints will be reviewed and investigated promptly and fairly.

In addition, our [privacy policy](https://typst.app/privacy/) applies on all community spaces operated by us, such as the Discord server. Please also note that the terms of service and privacy policies of the respective services apply.

### See you soon!

Thanks again for learning more about Typst. We would be delighted to meet you on our [Discord server](https://discord.gg/2uDybryKPe)!






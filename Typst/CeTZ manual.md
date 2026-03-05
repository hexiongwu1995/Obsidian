
# CeTZ Manual

## 1 Overview

CeTZ, ein Typst Zeichenpaket, is a drawing package for Typst. Its API is similar to Processing but with relative coordinates and anchors from TikZ. You also won't have to worry about accidentally drawing over other content as the canvas will automatically resize. And remember: up is positive!  

## 2 Getting Started

### 2.1 Usage

This is the minimal starting point in a `.typ` file: 

```typm
#import "@preview/cetz:0.4.2" ; 
#cetz.canvas({ import cetz.draw: * ; }) ;
```

Note that draw functions are imported inside the scope of the canvas block. This is recommended as some draw functions override Typst's functions such as `line`.  

### 2.2 Examples

From this point on only the code inside the canvas block will be shown in examples unless specified otherwise.  

```grid
// Draw a circle 
circle((0, 0)) ; 
// Draw a line
line((1,-1), (2,1)) ;
```

## 3 Basics

The following chapters are about the basic and core concepts of CeTZ. They are recommended reading for basic usage.

### 3.1 Custom Types

Many CeTZ functions expect data in certain formats which we will call types. Note that these are actually made up of Typst primitives.

- **coordinate** A position on the canvas specified by any coordinate system. See Coordinate Systems.
- **number** Any of `float`, `int` or `length` 
- **style** Represents options passed to draw functions that affect how elements are drawn. They are normally taken in the form of named arguments to the draw functions or sometimes can be a dictionary for a single argument.

### 3.2 The Canvas

The `canvas` function is what handles all of the logic and processing in order to produce drawings. It's usually called with a code block `{ ... }` as argument. The content of the curly braces is the body of the canvas. Import all the draw functions you need at the top of the body: 

```typm
#cetz.canvas({
  import cetz.draw: *
})
```

You can now call the draw functions within the body and they'll produce some graphics! Typst will evaluate the code block and pass the result to the canvas function for rendering.

The canvas does not have typical width and height parameters. Instead its size will grow and shrink to fit the drawn graphic.

By default 1 coordinate unit is 1 cm, this can be changed by setting the `length:` parameter.

### 3.3 Styling

You can style draw elements by passing the relevant named arguments to their draw functions. All elements that draw something have stroke and fill styling unless said otherwise.

- **fill** `color` or `none` (default: `none`) — How to fill the drawn element.
- **stroke** `none` or `auto` or `length` or `color` or `dictionary` or `stroke` (default: `black`) — How to stroke the border or the path of the draw element. See Typst's line documentation for more details.  


## 4 API

### 4.1 Canvas


```typm
canvas(
  length: length,
  x: number vector,
  y: number vector,
  z: number vector,
  baseline: none number coordinate,
  debug: bool,
  background: none color,
  stroke: none stroke,
  padding: none number array dictionary,
  body none array element
) → content
```

Sets up a canvas for drawing on. 

**Parameters**

- **length** `length` — Used to specify what 1 coordinate unit is. Note that ratios are no longer supported! You can wrap the canvas into a `layout(ly => canvas(length: ly.width * <ratio>, ...))`. 
- **baseline** `none number coordinate` — Specifies the coordinate to use as the baseline. Setting this the canvas behaves like a box element instead of a block.
- **body** `none array element` — A code block in which functions from the draw module have been called. 
- **background** `none color` — A color to be used for the background of the canvas.
- **stroke** `none stroke` — Stroke style to apply to the canvas top-level element (box or block). 
- **padding** `none number array dictionary` — How much padding to add to the canvas. `none` applies no padding. A number applies padding to all sides equally. A dictionary applies padding following Typst's pad function: https://typst.app/docs/reference/layout/pad/. An array follows CSS like padding: `(y, x)`, `(top, x, bottom)` or `(top, right, bottom, left)`.
- **x** `number vector` — Sets up the x vector of the coordinate system to `(x, 0, 0)` or to the given vector.
- **y** `number vector` — Sets up the y vector of the coordinate system to `(0, y, 0)` or to the given vector.
- **z** `number vector` — Sets up the z vector of the coordinate system to `(0, 0, z)` or to the given vector.
- **debug** `bool` — Shows the bounding boxes of each element when `true`.  



```typ
#set page(width:WIDTH, height:auto)
#set align(left)

#let cetz-code= ```typst 
import "@preview/cetz:0.4.2": canvas, draw, vector, palette

canvas(length: 3cm, stroke: 1pt+luma(20%), background: gray.transparentize(99%),
{
  import draw: * ;

  // Axis style
  let axis-style = ( mark: (end: "straight"), stroke: 1.1pt + black )

  // Draw axes
  line((0,0,0), (1,0,0), ..axis-style, name: "x") ;
  line((0,0,0), (0,1,0), ..axis-style, name: "y") ;
  line((0,0,0), (0,0,1), ..axis-style, name: "z") ;
  
  // Labels
  content("x.end", $x$, padding: 0.4em, anchor: "west")
  content("y.end", $y$, padding: 0.4em, anchor: "south")
  content("z.end", $z$, padding: 0.4em, anchor: "north-east")

  // Optional: origin label and small origin dot
  circle((0,0,0), radius: 0.02, fill: black)
  content((0,0,0), [O], padding: (0.5em, 0em, 0em), anchor: "north")
})
 ``` ;

#grid(columns:(1fr,), rows:auto, align:(horizon+center,horizon+left),stroke:(paint:luma(50%),thickness:1pt,dash:"solid"),inset:10pt,{eval(cetz-code.text,mode:"code")},{set align(left); set text(size:1.2em); "Assign a code block to a variable by using triple-backticks as delimiters.   "+"Display both the source code and the rendered image simultaneously by using eval() and raw() function in a grid function."+raw(cetz-code.text,lang:"typm",block:true)})
```



```grid
// Axis style
  let axis-style = ( mark: (end: "straight"), stroke: 1.1pt + black );

  // Draw axes
  line((0,0,0), (3,0,0), ..axis-style, name: "x") ;
  line((0,0,0), (0,3,0), ..axis-style, name: "y") ;
  line((0,0,0), (0,0,3), ..axis-style, name: "z") ;

  // Labels
  content("x.end", $ x $, padding: 0.4em, anchor: "west")
  content("y.end", $ y $, padding: 0.4em, anchor: "south")
  content("z.end", $ z $, padding: 0.4em, anchor: "north-east")

  // Optional: origin label and small origin dot
  circle((0,0,0), radius: 0.07, fill: black)
  content((0,0,0), [O], padding: (0.45em, 0.45em, 0.6em), anchor: "north")
```


### 4.2 Shapes

#### circle

```typm
circle(
  ..points-style coordinate style,
  name: none str,
  anchor: none str
)
```

Draws a circle or ellipse. 

```grid
// let length=2cm ;
// Draw a circle with center (0, 0)
circle((0, 0),radius:1, name:"a simple circle",anchor: none) ;

// Draw two ellipses
circle((0, -2), radius: (1, 0.5), anchor:"center") ;
circle((0, -2), radius: (1, 0.5), anchor:"west") ;

// draw a circle with the left-side edge on (0,0)
set-style(circle:(stroke:orange, fill: gray.transparentize(90%) ))
circle((0, 0),radius:1, name:"a orange circle",anchor: "west") ;


```


```grid
// Draw a circle with its center at (2, 1), going through point (1, 1)
let (a, b) = ((2, 1), (1, 1)); 
circle(a, b); 

// Show both points
set-style(content: (frame: "circle", padding: 1pt, fill: luma(20%))); 
content(a, [A]); 
content(b, [B]); 
```

**Styling**

Root: `circle` 

**Anchors** 

Supports border and path anchors. The `"center"` anchor is the default.

**Parameters**

- **..points-style** `coordinate style` — The position to place the circle on. If given two coordinates, the distance between them is used as radius. If given a single coordinate, the radius can be set via the `radius` (style) argument.
- **name** `none str` 
- **anchor** `none str` 
- **radius** `number array` — A number that defines the size of the circle's radius. Can also be set to a tuple of two numbers to define the radii of an ellipse, the first number is the x radius and the second is the y radius.

---

#### circle-through

```typm
circle-through(
  a coordinate,
  b coordinate,
  c coordinate,
  name: none str,
  anchor: none str,
  ..style style
)
```

Draws a circle through three coordinates.

```grid
let (a, b, c) = ((0, 0), (2, -0.5), (1, 1))
// Draw a circle through 3 points
circle-through(a, b, c, name: "c")
// Show the points
set-style(content: (frame: "circle", padding: 1pt, fill: luma(20%)))
content(a, [A]); content(b, [B]); content(c, [C])
```

**Styling**

Root: `circle` 

`circle-through` has the same styling as `circle` except for `radius` as the circle's radius is calculated by the given coordinates.

**Anchors** 

Supports the same anchors as `circle` as well as: 

- **a** Coordinate a
- **b** Coordinate b
- **c** Coordinate c

**Parameters**

- **a** `coordinate` — Coordinate a.
- **b** `coordinate` — Coordinate b.
- **c** `coordinate` — Coordinate c.
- **name** `none str` 
- **anchor** `none str` 
- **..style** `style` 



```grid
  // Three points
  let (A, B, C) = ((0,0), (3, -1), (1, 2.5))

  // Optional: helper triangle to understand the points
  line(A, B, C, close: true, stroke: gray + 0.5pt)

  // Draw the circle through 3 points and give it a name
  circle-through(A, B, C, name: "circ")

  // ─────────────── Common ways to use anchors ───────────────

  // 1. Label the three defining points (most frequent use!)
  set-style(content: (frame: "circle", padding: 1pt, fill: gray.transparentize(90%)))
  content("circ.a", [A])
  content("circ.b", [B])
  content("circ.c", [C])

  // 2. Mark the center (very useful for radius labels, etc.)
  circle("circ.center", radius: 0.08, fill: red)
  
  // rel: (0, 0.1)  Relative offset (a vector) , to: "circ.center"  Base position (any coordinate).  
  content((rel:(0,0.1),to: "circ.center"), anchor: "south", padding: 1pt, align(top)[#text(7pt)[*Center*]])

  // 3. Place things on the circumference using angle anchors
  content("circ.45deg",   $45degree$)
  content("circ.180deg",  text(size:8pt)[$180degree$])

  // 4. Use percentage along the circle path
  content("circ.0%", text(fill:orange, size:8pt, weight:"regular")[Start])
  content("circ.75%", padding:1pt, align(center)[ #text( fill: orange, weight: "bold", size: 6pt)[75% \  position]])

  // 5. Use anchors as starting/ending points for other elements (very powerful)
  line("circ.a", "circ.c", stroke: (paint: blue, thickness:2pt, dash: "dashed"))
  circle("circ.b", radius: 0.4, stroke: green + 1.5pt)

```


---

#### arc

```typm
arc(
  position coordinate,
  start: auto angle,
  stop: auto angle,
  delta: auto angle,
  name: none str,
  anchor: none str,
  ..style style
)
```

Draws a circular segment.

```grid
circle((0,0),radius:0.1,fill:orange)
arc((0,0), start: 45deg, stop: 135deg)
arc((0,-0.5), start: 45deg, delta: 90deg, mode: "CLOSE")
arc((0,-1), stop: 135deg, delta: 90deg, mode: "PIE", name:"pie")


set-style( arc:(stroke:(paint:orange, thickness:0.5pt, dash:"dotted")) )
arc((0.707,-0.293), radius:2cm, start:45deg, stop:135deg, mode:"PIE")

```


Note that two of the three angle arguments (`start`, `stop` and `delta`) must be set. The current position `()` gets updated to the arc's end coordinate (anchor `arc-end`). 

**Styling** 

Root: `arc` 

**Anchors** 

Supports border and path anchors.

- **arc-start** The position at which the arc's curve starts, this is the default.
- **arc-end** The position of the arc's curve end.
- **arc-center** The midpoint of the arc's curve.
- **center** The center of the arc, this position changes depending on if the arc is closed or not.
- **chord-center** Center of chord of the arc drawn between the start and end point.
- **origin** The origin of the arc's circle. 

**Parameters** 

- **position** `coordinate` — Position to place the arc at.
- **start** `auto angle` — The angle at which the arc should start. Remember that `0deg` points directly towards the right and `90deg` points up.
- **stop** `auto angle` — The angle at which the arc should stop.
- **delta** `auto angle` — The change in angle away start or stop. 
- **name** `none str`
- **anchor** `none str`
- **..style** `style`
- **radius** `number array` — The radius of the arc. An elliptical arc can be created by passing a tuple of numbers where the first element is the x radius and the second element is the y radius.
- **mode** `str` — The options are: `"OPEN"` no additional lines are drawn so just the arc is shown; `"CLOSE"` a line is drawn from the start to the end of the arc creating a circular segment; `"PIE"` lines are drawn from the start and end of the arc to the origin creating a circular sector. 
- **update-position** `bool` — Update the current canvas position to the arc's end point (anchor `"arc-end"`). This overrides the default of `true`, that allows chaining of (arc) elements. 

```grid
arc((0,-1), stop: 135deg, delta: 90deg, mode: "PIE", name:"pie")
arc("pie.origin", radius:2cm, start:0deg, stop:180deg, anchor:"origin")
```



```grid
arc((0,-1), stop: 135deg, delta: 90deg, mode: "PIE", name:"pie")
arc("pie.arc-end", radius:1cm, start:135deg, stop:180deg, anchor:"start")

set-style(arc:(stroke:(thickness:2pt, paint:orange, dash:"dotted")))
// calc.pi/4 is a type of float and must multiply by 1rad to convert the float into an angle type.
arc("pie.arc-start", radius:1cm, start: calc.pi/4 * 1rad, stop: -(calc.pi/2) *1rad, anchor:"start")
```



---

#### arc-through

```typm
arc-through(
  a coordinate,
  b coordinate,
  c coordinate,
  name: none str,
  ..style style
)
```

Draws an arc that passes through three points a, b and c.  Note that all three points must not lie on a straight line, otherwise the function fails. 

```grid
let (a, b, c) = ((0, 1), (2, 2), (2, 0))
// Draw an arc through 3 points
arc-through(a, b, c)
// Show the points
set-style(content: (frame: "circle", padding: 1pt, fill: luma(20%)))
content(a, [A]); content(b, [B]); content(c, [C])
```

**Styling**

Root: `arc` 

Uses the same styling as `arc`.

**Anchors**

For anchors see `arc`.

**Parameters** 

- **a** `coordinate` — Start position of the arc. 
- **b** `coordinate` — Position the arc passes through. 
- **c** `coordinate` — End position of the arc. 
- **name** `none str` 
- **..style** `style` 

---

#### mark


```typm
mark(
  from coordinate,
  to coordinate angle,
  ..style str style
)
```

Draws a single mark pointing towards a target coordinate.

```grid
// Show a grid
grid((-1, -1), (1, 1), stroke: gray)
// Draw a mark with its tip at (0, 0) pointing to (1, 0)
mark((0, 0), (1, 0), symbol: ")>", scale: 4)
```

```grid
// Show a grid
grid((-1, -1), (1, 1), stroke: gray)
// Draw a mark with its center at (0, 0) pointing to (1, 1)
mark((0, 0), (1, 1), symbol: ">>", anchor: "center", scale: 5)
```

Note: To place a mark centered at the first coordinate (`from`) use the marks `anchor: "center"` style.

**Styling**

Root: `mark`

You can directly use the styling from mark styling.

**Parameters**

- **from** `coordinate` — The position to place the mark.
- **to** `coordinate angle` — The position or angle the mark should point towards.
- **..style** `str style` — If the third positional argument is of type string, it is treated as mark name (e.g. `">"`) and overrules style keys such as `mark.symbol` or `mark.end`.

---

#### line

```typm
line(
  ..pts-style coordinate style,
  close: bool,
  name: none str
)
```

Draws a line, more than two points can be given to create a line-strip.

```grid
// Draw a line between two points
line((0, 0), (1.5, 1))
// Draw a line between more than two points
line((0, 0), (1, 0.5), (2, -0.5), (3, 0))
```

```grid
// Draw a polygon using `close: true`
line((0, 0), (0, 1), (1, 2), (2, 1), (2,0), close: true)
```

If the first or last coordinates are given as the name of an element, that has a `"default"` anchor, the intersection of that element's border and a line from the first or last two coordinates given is used as coordinate. This is useful to span a line between the borders of two elements.

```grid
circle((1,2), radius: .5, name: "a")
rect((2,1), (rel: (1,1)), name: "b")
line("a", "b")
```

**Styling**

Root: `line`

Supports mark styling.

**Anchors**

Supports path anchors.

- **centroid** The centroid anchor is calculated for closed non self-intersecting polygons if all vertices share the same z value.

**Parameters**

- **..pts-style** `coordinate style` — Positional two or more coordinates to draw lines between. Accepts style key-value pairs.
- **close** `bool` — If `true`, the line-strip gets closed to form a polygon.
- **name** `none str`

---

#### polygon

```typm
polygon(
  origin coordinate,
  sides int,
  angle: angle,
  name: none str,
  anchor:,
  ..style
)
```

Draws a regular polygon.

```grid
set-style(polygon: (radius: 0.65))
polygon((0, 0), 3, angle: 90deg)
polygon((1.5,0), 5)
polygon((3, 0), 7)
```

**Styling**

Root: `polygon`

**Parameters**

- **origin** `coordinate` — Coordinate to draw the polygon at.
- **sides** `int` — Number of sides of the polygon (>= 3).
- **angle** `angle` — Angle to rotate the polygon around its origin.
- **name** `none str`
- **radius** `number` — Radius of the polygon.

---

#### n-star

```typm
n-star(
  origin coordinate,
  sides int,
  angle: angle,
  name: none str,
  anchor:,
  ..style
)
```

Draws a n-pointed star.

```grid
set-style(n-star: (radius: 0.65))
n-star((0, 0), 5)
// An 8-pointed star, rotated
n-star((1.5, 0), 8, angle: 11.25deg)
// A 6-pointed star showing its inner hexagon
n-star((3, 0), 6, show-inner: true)
```

**Styling**

Root: `nstar`

**Parameters**

- **origin** `coordinate` — Coordinate to draw the star's center at.
- **sides** `int` — Number of points of the star (>= 3).
- **angle** `angle` — Angle to rotate the star around its origin.
- **name** `none str` — An optional name to identify the shape.
- **radius** `number` — The radius of the star's outer points.
- **inner-radius** `number ratio` — The radius (if of type ratio, relative to the outer radius) of the star's inner points.
- **show-inner** `bool` — If `true`, also draws the inner polygon connecting the star's inner points.
- **fill** `color gradient` — The fill color for the star.
- **stroke** `color thickness ...` — The stroke for the star and the inner polygon.

---

#### grid

```typm
grid(
  from coordinate,
  to coordinate,
  name: none str,
  ..style style
)
```

Draws a grid between two coordinates.

```grid
// Draw a grid
grid((0,0), (2,2))
// Draw a smaller blue grid
grid((1,1), (2,2), stroke: blue, step: .25)
```

**Styling**

Root: `grid`

**Anchors**

Supports border anchors.

**Parameters**

- **from** `coordinate` — The top left of the grid.
- **to** `coordinate` — The bottom right of the grid.
- **name** `none str`
- **..style** `style`
- **step** `number array dictionary` — Distance between grid lines. A distance of 1 means to draw a grid line every 1 length units in x- and y-direction. If given a dictionary with `x` and `y` keys or a tuple, the step is set per axis.
- **shift** `number array dictionary` — Offset of the grid lines. Supports an array of the form `(x, y)` or a dictionary of the form `(x: <number>, y: <number>)`.
- **help-lines** `bool` — If `true`, force the stroke style to `gray + 0.2pt`.

---

#### content

```typm
content(
  ..args-style coordinate content style,
  angle: angle coordinate,
  anchor: none str,
  name: none str
)
```

Positions Typst content in the canvas. Note that the content itself is not transformed only its position is.

```grid
content((0,0), [Hello World!])
```

To put text on a line you can let the function calculate the angle between its position and a second coordinate by passing it to `angle:`:

```grid
line((0, 0), (3, 1), name: "line")
content(
  ("line.start", 50%, "line.end"),
  angle: "line.end",
  padding: .1,
  anchor: "south",
  [Text on a line]
)
```

```grid
// Place content in a rect between two coordinates
content(
  (0, 0),
  (2, 2),
  box(
    par(justify: false)[This is a long text.],
    stroke: 1pt,
    width: 100%,
    height: 100%,
    inset: 1em
  )
)
```

**Styling**

Root: `content`

**Anchors**

Supports border anchors, the default anchor is set to `center`.

- **mid** Content center, from baseline to top bounds
- **mid-east** Content center extended to the east
- **mid-west** Content center extended to the west
- **base** Horizontally centered baseline of the content
- **base-east** Baseline height extended to the east
- **base-west** Baseline height extended to the west
- **text** Position at the content start on the baseline of the content

**Parameters**

- **..args-style** `coordinate content style` — When one coordinate is given as a positional argument, the content will be placed at that position. When two coordinates are given as positional arguments, the content will be placed inside a rectangle between the two positions. All named arguments are styling and any additional positional arguments will panic.
- **angle** `angle coordinate` — Rotates the content by the given angle. A coordinate can be given to rotate the content by the angle between it and the first coordinate given in args. This effectively points the right hand side of the content towards the coordinate. This currently exists because Typst's rotate function does not change the width and height of content.
- **anchor** `none str`
- **name** `none str`
- **padding** `number dictionary` — Sets the spacing around content. Can be a single number to set padding on all sides or a dictionary to specify each side specifically. The dictionary follows Typst's pad function: https://typst.app/docs/reference/layout/pad/
- **frame** `str none` — Sets the frame style. Can be `none`, `"rect"` or `"circle"` and inherits the stroke and fill style.
- **auto-scale** `bool` — If `true`, apply current canvas scaling to the content. Defaults to `false`.
- **wrap** `function none` — A function to apply the content body to. Must return content. Example: `text.with(red)` to wrap every content element in a `text(red, <body>)` element.

---

#### rect

```typm
rect(
  a coordinate,
  b coordinate,
  name: none str,
  anchor: none str,
  ..style style
)
```

Draws a rectangle between two coordinates.

```grid
// Draw a rect from A(0, 0) to B(1, 1)
rect((0, 0), (1, 1))
// Show the points
set-style(content: (frame: "circle", padding: 1pt, fill: white))
content((0, 0), [A]); content((1, 1), [B])
```

```grid
rect((0,0), (rel: (1,1)), radius: 0)
rect((2,0), (rel: (1,1)), radius: 25%)
rect((4,0), (rel: (1,1)), radius: (north: 50%))
rect((6,0), (rel: (1,1)), radius: (north-east: 50%))
rect((8,0), (rel: (1,1)), radius: (south-west: 0, rest: 50%))
rect((10,0), (rel: (1,1)), radius: (rest: (20%, 50%)))
```

**Styling**

Root: `rect`

**Anchors**

Supports border and path anchors. Its default is the `"center"` anchor.

**Parameters**

- **a** `coordinate` — Coordinate of the bottom left corner of the rectangle.
- **b** `coordinate` — Coordinate of the top right corner of the rectangle. You can draw a rectangle with a specified width and height by using relative coordinates for this parameter `(rel: (width, height))`.
- **name** `none str`
- **anchor** `none str`
- **..style** `style`
- **radius** `number ratio dictionary` — The rectangle's corner radius. If set to a single number, that radius is applied to all four corners. If passed a dictionary you can set the radii per corner. The following keys support either a `number`, `ratio` or an `array` of `number` or `ratio` for specifying a different x- and y-radius: `north`, `east`, `south`, `west`, `north-west`, `north-east`, `south-west` and `south-east`. To set a default value for remaining corners, the `rest` key can be used. Ratio values are relative to the rectangle's width and height.

---

#### bezier

```
bezier(
  start coordinate,
  end coordinate,
  ..ctrl-style coordinate style,
  name: none str
)
```

Draws a quadratic or cubic bezier curve.

```grid
let (a, b, c) = ((0, 0), (2, 0), (1, 1))
bezier(a, b, c)
set-style(content: (frame: "circle", padding: 1pt, fill: white))
content(a, [A]); content(b, [B]); content(c, [C])
```

```grid
let (a, b, c, d) = ((0, 0), (2, 0), (.5, -1), (1.5, 1))
bezier(a, b, c, d)
set-style(content: (frame: "circle", padding: 1pt, fill: white))
content(a, [A]); content(b, [B]); content(c, [C]); content(d, [D])
```

**Styling**

Root: `bezier`

Supports marks.

**Anchors**

Supports path anchors.

- **ctrl-n** nth control point where n is an integer starting at 0.

**Parameters**

- **start** `coordinate` — Start position.
- **end** `coordinate` — End position (last coordinate).
- **name** `none str`
- **..ctrl-style** `coordinate style` — The first two positional arguments are taken as cubic bezier control points, where the first is the start control point and the second is the end control point. One control point can be given for a quadratic bezier curve instead. Named arguments are for styling.

---

#### bezier-through

```typm
bezier-through(
  start coordinate,
  pass-through coordinate,
  end coordinate,
  name: none str,
  ..style style
)
```

Draws a cubic bezier curve through a set of three points. See `bezier` for style and anchor details.

```grid
let (a, b, c) = ((0, 0), (1, 1), (2, -1))
bezier-through(a, b, c, name: "curve")
// Show the computed control points: 1 and 2
set-style(content: (frame: "circle", padding: 1pt, fill: white))
content(a, [A]); content(b, [B]); content(c, [C])
content("curve.ctrl-1", [2]); content("curve.ctrl-0", [1])
```

**Parameters**

- **start** `coordinate` — The position to start the curve.
- **pass-through** `coordinate` — The position to pass the curve through.
- **end** `coordinate` — The position to end the curve.
- **name** `none str`
- **..style** `style`

---

#### catmull

```typm
catmull(
  ..pts-style coordinate style,
  close: bool,
  name: none str
)
```

Draws a Catmull-Rom curve through a set of points.

```grid
catmull((0,0), (1,1), (2,-1), (3,0), tension: .4, stroke: blue)
catmull((0,0), (1,1), (2,-1), (3,0), tension: .5, stroke: red)
```

**Styling**

Root: `catmull`

Supports marks.

**Anchors**

Supports path anchors.

- **pt-n** The nth given position (0 indexed so `"pt-0"` is equal to `"start"`). 

**Parameters**

- **..pts-style** `coordinate style` — Positional arguments should be coordinates that the curve should pass through. Named arguments are for styling.
- **close** `bool` — Closes the curve with a straight line between the start and end of the curve.
- **name** `none str`
- **tension** `float` — How tight the curve should fit to the points. The higher the tension the less curvy the curve.

---

#### hobby

```typm
hobby(
  ..pts-style coordinate style,
  ta: auto array,
  tb: auto array,
  close: bool,
  name: none str
)
```

Draws a Hobby curve through a set of points.

```grid
hobby((0, 0), (1, 1), (2, -1), (3, 0), omega: 0, stroke: blue)
hobby((0, 0), (1, 1), (2, -1), (3, 0), omega: 1, stroke: red)
```

**Styling**

Root: `hobby`

Supports marks.

**Anchors**

Supports path anchors.

- **pt-n** The nth given position (0 indexed, so `"pt-0"` is equal to `"start"`).

**Parameters**

- **..pts-style** `coordinate style` — Positional arguments are the coordinates to use to draw the curve with, a minimum of two is required. Named arguments are for styling.
- **tb** `auto array` — Incoming tension at `pts.at(n+1)` from `pts.at(n)` to `pts.at(n+1)`. The number given must be one less than the number of points.
- **ta** `auto array` — Outgoing tension at `pts.at(n)` from `pts.at(n)` to `pts.at(n+1)`. The number given must be one less than the number of points.
- **close** `bool` — Closes the curve with a proper smooth curve between the start and end of the curve.
- **name** `none str`
- **omega** `array` — A tuple of floats that describe how curly the curve should be at each endpoint. When the curl is close to zero, the spline approaches a straight line near the endpoints. When the curl is close to one, it approaches a circular arc.

---

#### compound-path

```typm
compound-path(
  body elements,
  name: none str,
  ..style style
)
```

Create a new path with each element used as sub-paths. This can be used to create paths with holes.

Unlike `merge-path`, this function groups the shapes as sub-paths instead of concatenating them into a single continuous path.

```grid
compound-path({
  rect((-1, -1), (1, 1))
  circle((0, 0), radius: .5)
}, fill: blue, fill-rule: "even-odd")
```

**Anchors**

- **centroid** Centroid of the closed and non self-intersecting shape. Only exists if `close` is `true`. Supports path anchors and shapes where all vertices share the same z-value.

**Parameters**

- **body** `elements` — Elements with paths to be merged together.
- **name** `none str`
- **..style** `style`

---

#### merge-path

```typm
merge-path(
  body elements,
  join: bool,
  ignore-marks: bool,
  ignore-hidden: bool,
  close: bool,
  name: none str,
  ..style style
)
```

Merges two or more paths by concatenating their elements. Anchors and visual styling, such as stroke and fill, are not preserved. When an element's path does not start at the same position the previous element's path ended, a straight line is drawn between them so that the final path is continuous. You must then pay attention to the direction in which element paths are drawn.

```grid
merge-path(fill: white, {
  line((0, 0), (1, 0))
  bezier((), (0, 0), (1,1), (0,1))
})
```

Elements hidden via `hide` are ignored.

**Anchors**

- **centroid** Centroid of the closed and non self-intersecting shape. Only exists if `close` is `true`. Supports path anchors and shapes where all vertices share the same z-value.

**Parameters**

- **body** `elements` — Elements with paths to be merged together.
- **join** `bool` — Connect all sub-paths with a straight line.
- **close** `bool` — Close the path with a straight line from the start of the path to its end.
- **ignore-marks** `bool` — If `true`, remove marks from input elements.
- **ignore-hidden** `bool` — If `true`, ignore all hidden elements.
- **name** `none str`
- **..style** `style`

---

#### rect-around

```typm
rect-around(
  ..pts-style coordinates style
)
```

Draws an axis aligned bounding box around all given points/elements. Everything else (styling, anchors) is similar to the `rect` shape.

```grid
circle((1, 1), radius: 0.1, fill: blue, name: "c1")
circle((0, 1), radius: 0.1, fill: red, name: "c2")
rect((0, 2), (1, 2.5), name: "r1")
rect-around("c1", "c2", "r1", stroke: yellow, padding: 0.1)
```

**Styling**

The `padding` attribute can be used to control spacing. Other attributes are forwarded to the `rect` shape.

**Anchors**

The same as for the `rect` shape.

**Parameters**

- **..pts-style** `coordinates style` — Positional two or more coordinates/elements to calculate bounding box of. Accepts style key-value pairs.

---

#### svg-path

```typm
svg-path(
  name: none string,
  anchor: none coordinate,
  ..commands-style any
)
```

Create a new path from a SVG-like list of commands.

The following commands are supported (uppercase command names use absolute coordinates, lowercase use relative coordinates):

- `("l", coordinate)` line to coordinate
- `("h", number)` Horizontal line
- `("v", number)` Vertical line
- `("m", coordinate)` Move to coordinate
- `("c", ctrl-coordinate-a, ctrl-coordinate-b, coordinate)` Cubic bezier curve to coordinate with two control points a and b
- `("q", ctrl-coordinate, coordinate)` Quadratic bezier curve
- `("z",)` Close the current path
- `("anchor", "<anchor-name>", [coordinate=(0, 0)])` named anchor. If the anchor coordinate is unset, the default `(0, 0, 0)` is used. The anchor named `"default"` serves as origin for the `anchor:` argument.

```typm
svg-path(("h", 2),
  ("anchor", "here"),
  ("c", (0, 1), (0, 0), (-1, 0)),
  ("v", -0.5),
  ("h", -1),
  ("z",), name: "svg")
circle("svg.here", fill: white, radius: 0.1cm)
```

**Parameters**

- **name** `none string`
- **anchor** `none coordinate`
- **..commands-style** `any` — Path commands and style keys.

---

### 4.3 Styling

#### set-style

```typm
set-style(
  ..style style
)
```

Set current style.

**Parameters**

- **..style** `style` — Style key-value pairs.

---

#### fill

```typm
fill(
  fill paint
)
```

Set current fill style.

Shorthand for `set-style(fill: <fill>)`.

**Parameters**

- **fill** `paint` — Fill style.

---

#### stroke

```typm
stroke(
  stroke stroke
)
```

Set current stroke style.

Shorthand for `set-style(stroke: <fill>)`.

**Parameters**

- **stroke** `stroke` — Stroke style.

---

#### register-mark

```typm
register-mark(
  symbol str,
  body function,
  mnemonic: none str,
  tip: none number coordinate,
  base: none number coordinate,
  center: none number coordinate,
  reverse-tip: none number coordinate,
  reverse-base: none number coordinate,
  reverse-center: none number coordinate
)
```

Register a custom mark to the canvas.

The mark should contain both anchors called `tip` and `base` that are used to determine the mark's orientation. If unset both default to `(0, 0)`. An anchor named `center` is used as center of the mark, if present. Otherwise the mid between `tip` and `base` is used.

```grid
register-mark(":)", style => {
  circle((0,0), radius: .5, fill: yellow)
  arc((0,0), start: 180deg + 30deg, delta: 180deg - 60deg, anchor:
"origin", radius: .3)
  circle((-0.15, 0.15), radius: .1, fill: white)
  circle((-0.10, 0.10), radius: .025, fill: black)
  circle(( 0.15, 0.15), radius: .1, fill: white)
  circle(( 0.20, 0.10), radius: .025, fill: black)
  anchor("tip", ( 0.5, 0))
  anchor("base", (-0.5, 0))
})
line((0,0), (3,0), mark: (end: ":)"))
```

**Parameters**

- **symbol** `str` — Mark name.
- **mnemonic** `none str` — Mark short name.
- **body** `function` — Mark drawing callback, receiving the mark style as argument and returning elements. Format `(styles) => elements`.
- **tip** `none number coordinate` — Tip coordinate (if passed a number, the y component is 0).
- **base** `none number coordinate` — Base coordinate (see `tip`).
- **center** `none number coordinate` — Center coordinate (see `tip`).
- **reverse-tip** `none number coordinate` — Reversed tip coordinate (see `tip`).
- **reverse-base** `none number coordinate` — Reversed base coordinate (see `tip`).
- **reverse-center** `none number coordinate` — Reversed center coordinate (see `tip`).

---

### 4.4 Grouping

#### hide

```typm
hide(
  body element,
  bounds: bool
)
```

Hides an element.

Hidden elements are not drawn to the canvas, are ignored when calculating bounding boxes and discarded by `merge-path`. All other behaviours remain the same as a non-hidden element.

```grid
set-style(radius: .5)
intersections("i", {
  circle((0,0), name: "a")
  circle((1,2), name: "b")
  // Use a hidden line to find the border intersections
  hide(line("a.center", "b.center"))
})
line("i.0", "i.1")
```

**Parameters**

- **body** `element` — One or more elements to hide.
- **bounds** `bool` — If `true`, respect the bounding box of the hidden elements for resizing the canvas.

---

#### floating

```typm
floating(
  body element
)
```

Places an element without affecting bounding boxes.

Floating elements are drawn to the canvas but are ignored when calculating bounding boxes. All other behaviours remain the same.

```grid
group(name: "g", {
  content((1,0), [Normal])
  content((0,1), [Normal])
  floating(content((.5,1.5), [Floating]))
})
set-style(stroke: red)
rect("g.north-west", "g.south-east")
```

**Parameters**

- **body** `element` — One or more elements to place.

---

#### intersections

```typm
intersections(
  name str,
  ..elements elements str,
  samples: int,
  sort: none function,
  ignore-marks: bool
)
```

Calculates the intersections between multiple paths and creates one anchor per intersection point.

All resulting anchors will be named numerically, starting at 0. i.e., a call `intersections("a", ...)` will generate the anchors `"a.0"`, `"a.1"`, `"a.2"` to `"a.n"`, depending of the number of intersections.

```grid
intersections("i", {
  circle((0, 0))
  bezier((0,0), (3,0), (1,-1), (2,1))
  line((0,-1), (0,1))
  rect((1.5,-1),(2.5,1))
})
for-each-anchor("i", (name) => {
  circle("i." + name, radius: .1, fill: blue)
})
```

You can also use named elements:

```grid
circle((0,0), name: "a")
rect((0,0), (1,1), name: "b")
intersections("i", "a", "b")
for-each-anchor("i", (name) => {
  circle("i." + name, radius: .1, fill: blue)
})
```

You can calculate intersections with hidden elements by using `hide`.

CeTZ provides the following sorting functions:

- `sorting.points-by-distance(points, reference: (0, 0, 0))`
- `sorting.points-by-angle(points, reference: (0, 0, 0))`

**Parameters**

- **name** `str` — Name to prepend to the generated anchors. (Not to be confused with other `name` arguments that allow the use of anchor coordinates.)
- **..elements** `elements str` — Elements and/or element names to calculate intersections with. Elements referred to by name are (unlike elements passed) not drawn by the intersections function!
- **samples** `int` — Number of samples to use for non-linear path segments. A higher sample count can give more precise results but worse performance.
- **sort** `none function` — A function of the form `(context, array<vector>) -> array<vector>` that gets called with the list of intersection points.
- **ignore-marks** `bool` — If `true`, ignore mark shapes.

---

#### group

```
group(
  body elements function,
  name: none str,
  anchor: none str,
  ..style style
)
```

Groups one or more elements together. This element acts as a scope, all state changes such as transformations and styling only affect the elements in the group. Elements after the group are not affected by the changes inside the group.

```grid
// Create group
group({
  stroke(5pt)
  scale(.5); rotate(45deg)
  rect((-1,-1),(1,1))
})
rect((-1,-1),(1,1))
```

**Styling**

Root: `group`

**Anchors**

Supports border and path anchors of the axis aligned bounding box of all the child elements of the group.

You can add custom named anchors to the group by using the `anchor` element while in the scope of said group.

The default anchor is `"center"` but this can be overridden by using `anchor` to place a new anchor called `"default"`.

When using named elements within a group, you can access the element's anchors outside of the group by using the implicit anchor coordinate. e.g. `"a.b.north"`.

```grid
group(name: "a", {
  circle((), name: "b")
})
circle("a.b.south", radius: 0.2)
circle((name: "a", anchor: "b.north"), radius: 0.2)
```

**Parameters**

- **body** `elements function` — Elements to group together. A least one is required. A function that accepts `ctx` and returns elements is also accepted.
- **anchor** `none str` — Anchor to position the group and its children relative to. For translation the difference between the groups `"default"` anchor and the passed anchor is used.
- **name** `none str`
- **..style** `style`
- **padding** `none number array dictionary` — How much padding to add around the group's bounding box. `none` applies no padding. A number applies padding to all sides equally. A dictionary applies padding following Typst's pad function. An array follows CSS like padding: `(y, x)`, `(top, x, bottom)` or `(top, right, bottom, left)`.

---

#### scope

```typm
scope(
  body elements function
)
```

This element acts as a scope, all state changes such as transformations and styling only affect the elements in the scope. Elements after the scope are not affected by the changes inside the scope. In contrast to `group`, the scope element does not create a named element itself and "leaks" body elements and anchors to the outside.

**Parameters**

- **body** `elements function` — Elements to group together. A least one is required. A function that accepts `ctx` and returns elements is also accepted.

---

#### anchor

```typm
anchor(
  name str,
  position coordinate
)
```

Creates a new anchor for the current group. The new anchor will be accessible from inside the group by using just the anchor's name as a coordinate.

```grid
// Inside a group
group(name: "g", {
  circle((0,0))
  anchor("x", (.4, .1))
  circle("x", radius: .2)
})
circle("g.x", radius: .1)
// At the root scope
anchor("x", (1, 1))
// ...
circle("x", radius: .1)
```

**Parameters**

- **name** `str` — The name of the anchor.
- **position** `coordinate` — The position of the anchor.

---

#### copy-anchors

```typm
copy-anchors(
  element str,
  filter: auto array
)
```

Copies multiple anchors from one element into the current group. Panics when used outside of a group. Copied anchors will be accessible in the same way anchors created by the `anchor` element are.

**Parameters**

- **element** `str` — The name of the element to copy anchors from.
- **filter** `auto array` — When set to `auto` all anchors will be copied to the group. An array of anchor names can instead be given so only the anchors that are in the element and the list will be copied over.

---

#### set-ctx

```typm
set-ctx(
  callback function
)
```

An advanced element that allows you to modify the current canvas context. Note: The transformation matrix (`transform`) is rounded after calling the callback function and therefore might not be exactly the matrix specified. This is due to rounding errors and should not cause any problems.

```grid
// Setting a custom transformation matrix
set-ctx(ctx => {
  let mat = ((1, 0, .5, 0),
             (0, 1, 0, 0),
             (0, 0, 1, 0),
             (0, 0, 0, 1))
  ctx.transform = mat
  return ctx
})
circle((z: 0), fill: red)
circle((z: 1), fill: blue)
circle((z: 2), fill: green)
```

You can store shared context data under a key in the `ctx.shared-data` dictionary. The `ctx.shared-data` dictionary is not scoped by `group` or `scope` elements and can be used for canvas global state.

**Parameters**

- **callback** `function` — A function that accepts the context dictionary and only returns a new one.

---

#### get-ctx

```typm
get-ctx(
  callback function
)
```

An advanced element that allows you to read the current context through a callback and return elements based on it.

```grid
// Print the transformation matrix
get-ctx(ctx => {
  content((), [#repr(ctx.transform)])
})
```

**Parameters**

- **callback** `function` — A function that accepts the context and can return elements.

---

#### for-each-anchor

```typm
for-each-anchor(
  name str,
  callback function,
  exclude: array
)
```

Iterates through all named anchors of an element and calls a callback for each one.

```grid
// Label nodes anchors
rect((0, 0), (2,2), name: "my-rect")
for-each-anchor("my-rect", exclude: ("start", "mid", "end"), (name) => {
  content((), box(inset: 1pt, fill: white, text(8pt, [#name])),
angle: -30deg)
})
```

**Parameters**

- **name** `str` — The name of the element with the anchors to loop through.
- **callback** `function` — A function that takes the anchor name and can return elements.
- **exclude** `array` — An array of anchor names to not include in the loop.

---

#### on-layer

```typm
on-layer(
  layer float int,
  body elements function
)
```

Places elements on a specific layer.

A layer determines the position of an element in the draw queue. A lower layer is drawn before a higher layer.

Layers can be used to draw behind or in front of other elements, even if the other elements were created before or after. An example would be drawing a background behind a text, but using the text's calculated bounding box for positioning the background.

```grid
// Draw something behind text
set-style(stroke: none)
content((0, 0), [This is an example.], name: "text")
on-layer(-1, {
  circle("text.north-east", radius: .3, fill: red)
  circle("text.south", radius: .4, fill: green)
  circle("text.north-west", radius: .2, fill: blue)
})
```

**Parameters**

- **layer** `float int` — The layer to place the elements on. Elements placed without `on-layer` are always placed on layer 0.
- **body** `elements function` — Elements to draw on the layer specified. A function that accepts `ctx` and returns elements is also accepted.

---

### 4.5 Transformation

#### set-transform

```typm
set-transform(
  mat none matrix
)
```

Overwrites the transformation matrix.

**Parameters**

- **mat** `none matrix` — The $4 times 4$ transformation matrix to set. If `none` is passed, the transformation matrix is set to the identity matrix (`matrix.ident(4)`).

---

#### transform

```typm
transform(
  mat none matrix
)
```

Applies a $4 times 4$ transformation matrix to the current transformation.

Given the current transformation $C$ and the new transformation $T$, the function sets the new canvas' transformation $C'$ to $C' = C T$.

**Parameters**

- **mat** `none matrix` — The $4 times 4$ transformation matrix to set. If `none` is passed, the transformation matrix is set to the identity matrix (`matrix.ident(4)`).

---

#### rotate

```typm
rotate(
  ..angles angle,
  origin: none coordinate
)
```

Rotates the transformation matrix on the z-axis by a given angle or other axes when specified.

```grid
// Rotate on z-axis
rotate(z: 45deg)
rect((-1,-1), (1,1))
// Rotate on y-axis
rotate(y: 80deg)
circle((0,0))
```

**Parameters**

- **..angles** `angle` — A single angle as a positional argument to rotate on the z-axis by. Named arguments of `x`, `y` or `z` can be given to rotate on their respective axis. You can give named arguments of `yaw`, `pitch` or `roll`, too.
- **origin** `none coordinate` — Origin to rotate around, or `(0, 0, 0)` if set to `none`.

---

#### translate

```typm
translate(
  ..args vector float length,
  pre: bool
)
```

Translates the transformation matrix by the given vector or dictionary.

```grid
// Outer rect
rect((0, 0), (2, 2))
// Inner rect
translate(x: .5, y: .5)
rect((0, 0), (1, 1))
```

**Parameters**

- **..args** `vector float length` — A single vector or any combination of the named arguments `x`, `y` and `z` to translate by. A translation matrix with the given offsets gets multiplied with the current transformation depending on the value of `pre`.
- **pre** `bool` — Specify matrix multiplication order - `false`: `World = World * Translate` - `true`: `World = Translate * World`.

---

#### scale

```typm
scale(
  ..args float ratio,
  origin: none coordinate
)
```

Scales the transformation matrix by the given factor(s).

```grid
// Scale the y-axis
scale(y: 50%)
circle((0,0))
```

Note that content like text does not scale automatically. See `auto-scale` styling of `content` for that.

**Parameters**

- **..args** `float ratio` — A single value to scale the transformation matrix by or per axis scaling factors. Accepts a single `float` or `ratio` value or any combination of the named arguments `x`, `y` and `z` to set per axis scaling factors. A ratio of `100%` is the same as the value `1`.
- **origin** `none coordinate` — Origin to rotate around, or `(0, 0, 0)` if set to `none`.

---

#### set-origin

```typm
set-origin(
  origin coordinate
)
```

Sets the given position as the new origin $(0, 0, 0)$.

```grid
// Draw some rect
rect((0,0), (2,2), name: "r")
// Move (0, 0) to the top edge of "r"
set-origin("r.north")
circle((0, 0), radius: .1, fill: white)
```

**Parameters**

- **origin** `coordinate` — Coordinate to set as new origin $(0,0,0)$.

---

#### move-to

```typm
move-to(
  pt coordinate
)
```

Sets the previous coordinate.

The previous coordinate can be used via `()` (empty coordinate). It is also used as base for relative coordinates if not specified otherwise.

```grid
circle((), radius: .25)
move-to((1,0))
circle((), radius: .15)
```

**Parameters**

- **pt** `coordinate` — The coordinate to move to.

---

#### set-viewport

```typm
set-viewport(
  from coordinate,
  to coordinate,
  bounds: vector
)
```

Span viewport between two coordinates and set-up scaling and translation.

```grid
rect((0,0), (2,2))
set-viewport((0,0), (2,2), bounds: (10, 10))
circle((5,5))
```

**Parameters**

- **from** `coordinate` — Bottom left corner coordinate.
- **to** `coordinate` — Top right corner coordinate.
- **bounds** `vector` — Viewport bounds vector that describes the inner width, height and depth of the viewport.

---

### 4.6 Projection

#### ortho

```typm
ortho(
  x: angle,
  y: angle,
  z: angle,
  sorted: bool,
  cull-face: none str,
  reset-transform: bool,
  body element
)
```

Set-up an orthographic projection environment.

This is a transformation matrix that rotates elements around the x, the y and the z axis by the parameters given.

By default an isometric projection ($x approx 35.264°$, $y = 45°$) is set.

```grid
ortho({
  on-xz({
    rect((-1,-1), (1,1))
  })
})
```

**Parameters**

- **x** `angle` — X-axis rotation angle.
- **y** `angle` — Y-axis rotation angle.
- **z** `angle` — Z-axis rotation angle.
- **sorted** `bool` — Sort drawables by maximum distance (front to back).
- **cull-face** `none str` — Enable back-face culling if set to `"cw"` for clockwise or `"ccw"` for counter-clockwise. Polygons of the specified order will not get drawn.
- **reset-transform** `bool` — Ignore the current transformation matrix.
- **body** `element` — Elements to draw.

---

#### on-xy

```typm
on-xy(
  z: number,
  body element
)
```

Draw elements on the xy-plane with optional z offset.

All vertices of all elements will be changed in the following way: $(x, y, z_"argument")$, where $z_"argument"$ is the z-value given as argument.

```grid
ortho({
  on-xy({
    rect((-1, -1), (1, 1))
  })
})
```

**Parameters**

- **z** `number` — Z offset for all coordinates.
- **body** `element` — Elements to draw.

---

#### on-xz

```typm
on-xz(
  y: number,
  body element
)
```

Draw elements on the xz-plane with optional y offset.

All vertices of all elements will be changed in the following way: $(x, y_"argument", y)$, where $y_"argument"$ is the y-value given as argument.

```grid
ortho({
  on-xz({
    rect((-1, -1), (1, 1))
  })
})
```

**Parameters**

- **y** `number` — Y offset for all coordinates.
- **body** `element` — Elements to draw.

---

#### on-zy

```typm
on-zy(
  x: number,
  body element
)
```

Draw elements on the zy-plane with optional x offset.

All vertices of all elements will be changed in the following way: $(x_"argument", y, x)$, where $x_"argument"$ is the x-value given as argument.

```
ortho({
  on-zy({
    rect((-1, -1), (1, 1))
  })
})
```

**Parameters**

- **x** `number` — X offset for all coordinates.
- **body** `element` — Elements to draw.

---

### 4.7 Utility

#### assert-version

```typm
assert-version(
  min version,
  max: none version,
  hint: string
)
```

Assert that the cetz version of the canvas matches the given version (range).

**Parameters**

- **min** `version` — Minimum version (`current >= min`).
- **max** `none version` — First unsupported version (`current < max`).
- **hint** `string` — Name of the function/module this assert is called from.

---

#### register-coordinate-resolver

```typm
register-coordinate-resolver(
  resolver function
)
```

Push a custom coordinate resolve function to the list of coordinate resolvers. This resolver is scoped to the current context scope!

A coordinate resolver must be a function of the format `(context, coordinate) => coordinate`. And must always return a valid coordinate or panic, in case of an error.

If multiple resolvers are registered, coordinates get passed through all resolvers in reverse registering order. All coordinates get passed to cetz' default coordinate resolvers.

```grid
register-coordinate-resolver((ctx, c) => {
  if type(c) == dictionary and "log" in c {
    c = c.log.map(n => calc.log(n, base: 10))
  }
  return c
})
circle((log: (10, 1e-6)), radius: .25)
circle((log: (100, 1e-6)), radius: .25)
circle((log: (1000, 1e-6)), radius: .25)
```

**Parameters**

- **resolver** `function` — The resolver function, taking a context and a single coordinate and returning a single coordinate.

---

### 4.8 Libraries

#### Angle

##### angle

```typm
angle(
  origin coordinate,
  a coordinate,
  b coordinate,
  direction: string,
  label: none content function,
  name: none str,
  ..style style
)
```

Draw an angle counter-clock-wise between a and b through origin `origin`.

```grid
line((0, 0), (60deg, 2), name: "a")
line((0, 0), (330deg, 2), name: "b")
// Draw an angle between the two lines
cetz.angle.angle("a.start", "a.end", "b.end", label: $alpha$,
  mark: (end: ">"), radius: 1.5)
cetz.angle.angle("a.start", "b.end", "a.end", label: $beta$,
  radius: 50%, direction: "ccw")
```

**Styling**

Root: `angle`

**Anchors**

- **a** Point a
- **b** Point b
- **origin** Origin
- **label** Label center
- **start** Arc start
- **end** Arc end

**Parameters**

- **origin** `coordinate` — Angle origin.
- **a** `coordinate` — Coordinate of side a, containing an angle between origin and b.
- **b** `coordinate` — Coordinate of side b, containing an angle between origin and a.
- **direction** `string` — Direction of the angle. Accepts `"ccw"` (counter-clockwise), `"cw"` (clockwise), `"near"` (inner angle), `"far"` (outer angle), the first one being the default.
- **label** `none content function` — Draw a label at the angles `"label"` anchor. If label is a function, it gets the angle value passed as argument. The function must be of the format `angle => content`.
- **name** `none str` — Element name, used for querying anchors.
- **..style** `style` — Style key-value pairs.
- **radius** `number` — The radius of the angles arc. If of type `ratio`, it is relative to the smaller distance of either origin to a or origin to b.
- **label-radius** `number ratio` — The radius of the angles label origin. If of type `ratio`, it is relative to `radius`.

---

##### right-angle

```typm
right-angle(
  origin coordinate,
  a coordinate,
  b coordinate,
  label: none content,
  name: none str,
  ..style style
)
```

Draw a right angle between a and b through origin `origin`.

```grid
line((0,0), (1,2), name: "a")
line((0,0), (2,-1), name: "b")
// Draw an angle between the two lines
cetz.angle.right-angle(
  "a.start",
  "a.end",
  "b.end",
  radius: 1.5
)
```

**Styling**

Styling is the same as the `angle` function.

**Anchors**

Anchors are the same as the `angle` function.

**Parameters**

- **origin** `coordinate` — Angle origin.
- **a** `coordinate` — Coordinate of side a, containing an angle between origin and b.
- **b** `coordinate` — Coordinate of side b, containing an angle between origin and a.
- **label** `none content` — Draw a label at the angles `"label"` anchor.
- **name** `none str` — Element name, used for querying anchors.
- **..style** `style` — Style key-value pairs.

---

#### Tree

##### tree

```typm
tree(
  root array,
  draw-node: auto function,
  draw-edge: none auto function,
  direction: str,
  grow: float,
  spread: float,
  name: none str,
  node-layer: int,
  edge-layer: int,
  measure-content:,
  anchor: none string
)
```

Lays out and renders tree nodes.

For each node, the tree function creates an anchor of the format `"[<child-index>-]<child-index>"` (the root is `"0"`, its first child `"0-0"`, second `"0-1"` and so on) that can be used to query a node's position on the canvas.

```grid
import cetz.tree
set-style(content: (padding: .1))
tree.tree(([Root], ([A], [A.A], [A.B]), ([B], [B.A])))
```

**Parameters**

- **root** `array` — A nested array of content that describes the structure the tree should take. Example: `([root], [child 1], ([child 2], [grandchild 1]))`.
- **draw-node** `auto function` — The function to call to draw a node. The function will be passed the node to draw (a dictionary with a `content` key) and is expected to return elements `((node, parent-node) => elements)`. The node must be drawn at the `(0,0)` coordinate. If `auto` is given, just the node's value will be drawn as content.
- **draw-edge** `none auto function` — The function to call to draw an edge between two nodes. The function will be passed the name of the starting node, the name of the ending node, the start node, the end node, and is expected to return elements `((source-name, target-name, parent-node, child-node) => elements)`. If `auto` is given, a straight line will be drawn between nodes.
- **direction** `str` — A string describing the direction the tree should grow in (`"up"`, `"down"`, `"left"`, `"right"`).
- **grow** `float` — Depth grow factor.
- **spread** `float` — Sibling spread factor.
- **name** `none str` — The tree element's name.
- **node-layer** `int` — Layer to draw nodes on.
- **edge-layer** `int` — Layer to draw edges on.
- **anchor** `none string` — Name of the anchor to align the tree to. Use the root node anchor (`"0"`) to align the tree to the root node's position.

---

#### Decorations

##### Path

###### zigzag

```typm
zigzag(
  target drawable,
  name: none string,
  close: auto bool,
  ..style style
)
```

Draw a zig-zag or saw-tooth wave along a path.

The number of teeth can be controlled via the `segments` or `segment-length` style key, and the width via `amplitude`.

```grid
line((0,0), (2,1), stroke: gray)
cetz.decorations.zigzag(line((0,0), (2,1)), amplitude: .25, start: 10%, stop: 90%)
```

**Styling**

Root: `zigzag`

**Parameters**

- **target** `drawable` — Target path.
- **close** `auto bool` — Close the path.
- **name** `none string` — Element name.
- **..style** `style`
- **factor** `ratio` — Triangle mid between its start and end. Setting this to `0%` leads to a falling sawtooth shape, while `100%` results in a raising sawtooth.

---

###### coil

```typm
coil(
  target drawable,
  close: auto bool,
  name: none string,
  ..style style
)
```

Draw a stretched coil/loop spring along a path.

The number of windings can be controlled via the `segments` or `segment-length` style key, and the width via `amplitude`.

```grid
line((0,0), (2,1), stroke: gray)
cetz.decorations.coil(line((0,0), (2,1)), amplitude: .25, start: 10%, stop: 90%)
```

**Styling**

Root: `coil`

**Parameters**

- **target** `drawable` — Target path.
- **close** `auto bool` — Close the path.
- **name** `none string` — Element name.
- **..style** `style`
- **factor** `ratio` — Factor of how much the coil overextends its length to form a curl.

---

###### wave

```typm
wave(
  target drawable,
  close: auto bool,
  name: none string,
  ..style style
)
```

Draw a wave along a path using a catmull-rom curve.

The number of phases can be controlled via the `segments` or `segment-length` style key, and the width via `amplitude`.

```grid
line((0,0), (2,1), stroke: gray)
cetz.decorations.wave(line((0,0), (2,1)), amplitude: .25, start: 10%, stop: 90%)
```

**Styling**

Root: `wave`

- **tension** `(float) = 0.5` — Catmull-Rom curve tension, see Catmull.

**Parameters**

- **target** `drawable` — Target path.
- **close** `auto bool` — Close the path.
- **name** `none string` — Element name.
- **..style** `style`

---

###### square

```typm
square(
  target drawable,
  close: auto bool,
  name: none string,
  ..style style
)
```

Draw a square-wave along a path using a line-strip.

The number of phases can be controlled via the `segments` or `segment-length` style key, and the width via `amplitude`.

```grid
line((0,0), (2,1), stroke: gray)
cetz.decorations.square(line((0,0), (2,1)), amplitude: .25, start: 10%, stop: 90%)
```

**Styling**

Root: `square`

- **factor** `(ratio) = 50%` — Square-Wave midpoint.

**Parameters**

- **target** `drawable` — Target path.
- **close** `auto bool` — Close the path.
- **name** `none string` — Element name.
- **..style** `style`

---

##### Brace

###### brace

```typm
brace(
  start coordinate,
  end coordinate,
  ..style style,
  name: string none
)
```

Draw a curly brace between two points.

```grid
cetz.decorations.brace((0,1),(2,1))
cetz.decorations.brace((0,0),(2,0), outer-inset: 0)
```

**Styling**

Root: `brace`

Use the `fill` style for tapered braces and set `stroke` to `none`.

**Anchors**

- **start** Where the brace starts, same as the `start` parameter.
- **end** Where the brace ends, same as the `end` parameter.
- **spike** Point of the spike, halfway between start and end and shifted by `amplitude` towards the pointing direction.
- **content** Point to place content/text at, in front of the spike.
- **center** Center of the enclosing rectangle.

**Parameters**

- **start** `coordinate` — Start point.
- **end** `coordinate` — End point.
- **name** `string none` — Element name used for querying anchors.
- **..style** `style` — Style key-value pairs.
- **amplitude** `number` — Sets the height of the brace, from its baseline to its middle tip.
- **thickness** `number ratio` — Thickness of tapered braces (if ratio, relative to half the amplitude).
- **pointiness** `ratio` — Thickness of the mid-spike.
- **taper** `bool` — Draw a tapered brace.
- **outer-inset** `number ratio` — Inset of the outer curve points.
- **outer-curvyness** `ratio` — Curvyness of the outer curves.
- **inner-outset** `number ratio` — Inset of the inner tip curve points.
- **inner-curvyness** `ratio` — Curvyness of the inner tip curves.
- **outer-thickness** `number` — Thickness of the outer tips.
- **content-offset** `number` — Offset of the `"content"` anchor from the spike of the brace.
- **flip** `bool` — Mirror the brace along the line between start and end.

---

###### flat-brace

```typm
flat-brace(
  start coordinate,
  end coordinate,
  flip: bool,
  debug: bool,
  name: str none,
  ..style style
)
```

Draw a flat curly brace between two points.

```grid
cetz.decorations.flat-brace((0,1),(2,1))
cetz.decorations.flat-brace((0,0),(2,0),
  curves: .2,
  aspect: 25%)
cetz.decorations.flat-brace((0,-1),(2,-1),
  outer-curves: 0,
  aspect: 75%)
```

This mimics the braces from TikZ's `decorations.pathreplacing` library. In contrast to the `brace` function, these braces use straight line segments, resulting in better looks for long braces with a small amplitude.

**Styling**

Root: `flat-brace`

- **aspect** `(ratio) = 50%` — Determines the fraction of the total length where the spike will be placed.

**Anchors**

- **start** Where the brace starts, same as the `start` parameter.
- **end** Where the brace ends, same as the `end` parameter.
- **spike** Point of the spike's top.
- **content** Point to place content/text at, in front of the spike.
- **center** Center of the enclosing rectangle.

**Parameters**

- **start** `coordinate` — Start point.
- **end** `coordinate` — End point.
- **flip** `bool` — Flip the brace around.
- **name** `str none` — Element name for querying anchors.
- **debug** `bool`
- **..style** `style` — Style key-value pairs.
- **amplitude** `number` — Determines how much the brace rises above the base line.
- **curves** `number auto array` — Curviness factor of the brace, a factor of `0` means no curves.
- **outer-curves** `number auto array` — Curviness factor of the outer curves of the brace. A factor of `0` means no curves.

---

#### Palette

##### new

```typm
new(
  base: style,
  colors: none array,
  dash: none array
) → function
```

Create a new palette based on a base style.

```grid
let p = cetz.palette.new(colors: (red, blue, green))
for i in range(0, p("len")) {
  set-style(..p(i))
  circle((0,0), radius: .5)
  set-origin((1.1, 0))
}
```

The functions returned by this function have the following named arguments:

You can use a palette for stroking via: `red.with(stroke: true)`.

**Parameters**

- **fill** `bool` — If `true`, the returned fill color is one of the colors from the `colors` list, otherwise the base styles `fill` is used.
- **stroke** `bool` — If `true`, the returned stroke color is one of the colors from the `colors` list, otherwise the base styles stroke color is used.
- **base** `style` — Style dictionary to use as base style for the styles generated per color.
- **colors** `none array` — List of colors the returned palette should return styles with.
- **dash** `none array` — List of stroke dash patterns the returned palette should return styles with.



# CeTZ Documentation

CeTZ, ein Typst Zeichenpaket, is a drawing package for [Typst](https://typst.app/). Its API is similar to Processing but with relative coordinates and anchors from TikZ. You also won't have to worry about accidentally drawing over other content as the canvas will automatically resize. And remember: up is positive!  

> These docs are a work in progress! Please submit issues for parts that don't make sense or need improving. 

---


## Getting Started

### Usage

This is the minimal starting point in a `.typ` file: 

```typm
/* Import version 0.4.2 of the CeTZ package from the Typst preview (package) repository.  The "@preview/" prefix tells Typst to fetch the package from the official preview registry. You can also use a locally installed version like "@local/cetz:0.4.2" if you have it installed. */

#import "@preview/cetz:0.4.2"

/* Create a drawing canvas (the actual drawing area). Everything drawn inside this block becomes part of one vector graphic. CeTZ automatically calculates the bounding box → no manual sizing needed in most cases. */

#cetz.canvas({

/* Import all drawing commands (functions) from the cetz.draw module with `*` (wildcard import). This is the strongly recommended pattern in CeTZ. After this line you can write short names like: 
line((0,0), (2,1))        instead of  cetz.draw.line(...) 
circle((3,2), radius: 1)  instead of  cetz.draw.circle(...)   etc. */
  
  import cetz.draw: *
  
// From here you write your actual drawing commands.
})
```

Note that draw functions are imported inside the scope of the `canvas` block. This is recommended as some draw functions override Typst's functions such as `line`. 

### Examples

From this point on only the code inside the `canvas` block will be shown in examples unless specified otherwise. 

```grid
circle((0, 0)); 

circle((0, 0), radius:0.15); 

line((0, 0), (2, 2));
```

## Basics

The following chapters are about the basic and core concepts of CeTZ. They are recommended reading for basic usage.

---

### Custom Types

Many CeTZ functions expect data in certain formats which we will call types. Note that these are actually made up of Typst primitives. 

#### coordinate

A position on the canvas specified by any coordinate system. See [[CeTZ Documentation#Coordinate Systems|Coordinate Systems]]

#### number

Any of `float`, `int`, or `length`.

#### style

Represents options passed to draw functions that affect how elements are drawn. They are normally taken in the form of named arguments to the draw functions or sometimes can be a dictionary for a single argument. 

---

### The Canvas

The `canvas` function is what handles all of the logic and processing in order to produce drawings. It's usually called with a code block `{...}` as argument. The content of the curly braces is the *body* of the canvas. Import all the draw functions you need at the top of the body: 


```
#cetz.canvas({
  import cetz.draw: *

})
```

You can now call the draw functions within the body and they'll produce some graphics! Typst will evaluate the code block and pass the result to the `canvas` function for rendering.

The canvas does not have typical `width` and `height` parameters. Instead its size will grow and shrink to fit the drawn graphic. 

By default 1 coordinate unit is `1cm`, this can be changed by setting the `length` parameter. If a ratio is given, the length will be the size of the canvas' parent's width!

---

### Styling

You can style draw elements by passing the relevant named arguments to their draw functions. All elements that draw something have stroke and fill styling unless said otherwise.

#### fill:
`color` or `none` — Default: `none`

How to fill the drawn element.

#### stroke:
`none` or `auto` or `length` or `color` or `dictionary` or `stroke` — Default: `black`

How to stroke the border or the path of the draw element. See Typst's line documentation for more details.

#### fill-rule:
`string` — Default: `"non-zero"`

How to fill self-intersecting paths. Can be `"non-zero"` or `"even-odd"`. See Typst's path documentation for more details.

```grid
// Draws a red circle with a blue border
circle((0, 0), fill: red, stroke: blue) ;

// Draws a green line
line((0, 0), (1, 1), stroke: green) ;
```
Instead of having to specify the same styling for each time you want to draw an element, you can use the `set-style` function to change the style for all elements after it, like a Typst `set` rule. You can still pass styling to a draw function to override what has been set with `set-style`. You can also use the `fill` and `stroke` functions as a shorthand to set the fill and stroke respectively. 

```grid
// Draws an empty square with a black border
rect((-1, -1), (1, 1))

// Sets the global style to have a fill of red and a stroke of blue
set-style(stroke: blue, fill: red)
circle((0,0))
circle((-1,-1), radius:0.1)
// Draws a green line despite the global stroke being blue
line((), (1,1), stroke: green)
```
When using a dictionary for a style, it is important to note that they update each other instead of overriding the entire option like a non-dictionary value would. For example, if the stroke is set to `(paint: red, thickness: 5pt)` and you pass `(paint: blue)`, the stroke would become `(paint: blue, thickness: 5pt)`. 

```grid
// Sets the stroke to red with a thickness of 5pt
set-style(stroke: (paint: red, thickness: 5pt))

// Draws a line with the global stroke
line((0,0), (1,0))

// Draws a blue line with a thickness of 5pt because dictionaries update the style
line((0,0), (1,1), stroke: (paint: blue))

// Draws a yellow line with a thickness of 1pt because other values override the style
line((0,0), (0,1), stroke: yellow)
```
You can also specify styling for each type of element. Note that dictionary values will still update with its global value, the full hierarchy is `function > element type > global`. When the value of a style is `auto`, it will become exactly its parent style.

```grid
set-style(
  // Global fill and stroke
  fill: green,
  stroke: (thickness: 5pt),
  // Stroke and fill for only rectangles
  rect: (stroke: (dash: "dashed"), fill: blue),
)

rect((0,0), (1,1)) ;
circle((2.5, 0.5)) ;

rect((4, 0), (5, 1), stroke: (thickness: 1pt)) ;
```

---

### Coordinate Systems

A coordinate is a position on the canvas on which the picture is drawn. They take the form of dictionaries and the following subsections define the key-value pairs for each system. Some systems have a more implicit form as an array of values and CeTZ attempts to infer the system based on the element types. 

#### XYZ

Defines a point `x` units right, `y` units upward and `z` units away.

**x:** `number` — Default: `0`  
The number of units in the `x` direction.

**y:** `number` — Default: `0`  
The number of units in the `y` direction.

**z:** `number` — Default: `0`  
The number of units in the `z` direction.

The implicit form can be given as an array of two or three numbers, as in `(x, y)` or `(x, y, z)`. 

```grid
line((0,0), (x: 1)); 
line((0,0), (y: 1)); 
line((0,0), (z: 1)) ;

// Implicit form
line((2, 0), (3, 0)) ;
line((2, 0), (2, 1, 0)) ;
line((2, 0), (2, 0, 1)) ;
```

#### Previous

Use this to reference the position of the previous coordinate passed to a draw function. It takes the form of an empty array `()` and the previous position initially will be `(0, 0, 0)`. This will never reference the position of a coordinate used to define another coordinate. 

```grid
line((),(1,0))
```

```grid
line((0,0), (1, 1)) ;

// Draws a circle at (1,1)
circle(()) ;
```

#### Relative

Places the given coordinate relative to the previous coordinate. Or in other words, for the given coordinate, the previous coordinate will be used as the origin. Another coordinate can be given to act as the previous coordinate instead.

**rel:** `coordinate`  
The coordinate to place relative to the previous coordinate.

**update:** `bool` — Default: `true`  
When false, the previous position will not be updated.

**to:** `coordinate` — Default: `()`  
The coordinate to treat as the previous coordinate. 

In the example below, the red circle is placed one unit to the right of the blue circle. If the blue circle was to be moved to a different position, the red circle would move with the blue circle to stay one unit to the right.

```grid
circle((0, 0), stroke: blue) ;

circle((rel: (1, 0)), stroke: red) ;
```

#### Polar

Defines a point that is `radius` distance away from the origin at the given angle. 

**angle:** `angle`  
The angle of the coordinate. A value of `0deg` is to the right, a value of `90deg` is upward. 

**radius:** `number` or `array`  
The distance from the origin. An array of numbers can be given, in the form `(x, y)`, to define the `x` and `y` radii of an ellipse instead of a circle. 

```grid
grid((-3,-3),(3,3), help-lines:true)
circle((0,0), radius:0.1, fill:orange, stroke:none)

line((1, 0), (angle: 45deg, radius: 2* calc.sqrt(2))) ;
```

The implicit form is an array of the angle then the radius `(angle, radius)` or `(angle, (x, y))`. 


```grid
line((0,0),
(rel:(30deg,1), update:false),
(rel:(60deg,1), update:false),
(rel:(90deg,1), update:false),
(rel:(120deg,1), update:false),
(rel:(150deg,1), update:false),
(rel:(180deg,1), update:false),
(rel:(210deg,1), update:false),
(rel:(240deg,1), update:false),
(rel:(270deg,1), update:false),
(rel:(300deg,1), update:false),
(rel:(330deg,1), update:false),
(rel:(360deg,1), update:false),
(rel:(390deg,1), update:false), 
fill:orange.transparentize(95%))
```


```grid
line((0,0), 
(rel:(0deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(30deg, 2*calc.sin(15deg) ) ,update:true),
(rel:(60deg, 2*calc.sin(15deg) ) ,update:true),
(rel:(90deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(120deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(150deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(180deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(210deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(240deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(270deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(300deg, 2*calc.sin(15deg) ) ,update:true), 
(rel:(330deg, 2*calc.sin(15deg) ) ,update:true), )
```

```grid
line((0,0), 
(rel:(0deg, 0.6), update:true), 
(rel:(30deg, 0.6), update:true), 
(rel:(60deg, 0.6), update:true), 
(rel:(90deg, 0.6), update:true), 
(rel:(120deg, 0.6), update:true), 
(rel:(150deg, 0.6), update:true), 
(rel:(180deg, 0.6), update:true), 
(rel:(210deg, 0.6), update:true), 
(rel:(240deg, 0.6), update:true), 
(rel:(270deg, 0.6), update:true), 
(rel:(300deg, 0.6), update:true), 
(rel:(330deg, 0.6), update:true), )
```


```grid
line(
  (0, 0),
  (30deg, 1),
  (60deg, 1),
  (90deg, 1),
  (120deg, 1),
  (150deg, 1),
  (180deg, 1)
)
```

#### Barycentric

In the barycentric coordinate system a point is expressed as the linear combination of multiple vectors. The idea is that you specify vectors $v_1, v_2, ..., v_n$ and numbers $alpha_1, alpha_2, ..., alpha_n$. Then the barycentric coordinate specified by these vectors and numbers is: $display((alpha_1 v_1 + alpha_2 v_2 + dots.c + alpha_n v_n) / (alpha_1 + alpha_2 + dots.c + alpha_n))$ 




**bary:** `dictionary`  
A dictionary where the key is a named element and the value is a `float`. The `center` anchor of the named element is used as$v$and the value is used as $alpha$. 

```grid
circle((90deg, 3), radius: 0, name: "content")
circle((210deg, 3), radius: 0, name: "structure")
circle((-30deg, 3), radius: 0, name: "form")

for (c, a) in ( ("content", "south"), ("structure", "north"), ("form", "north")
) { content(c, align(center, text(size:8pt)[#c \  oriented]), padding: 1pt, anchor: a) }

stroke(gray + 1.2pt)
line("content", "structure", "form", close: true)

for (c, s, f, cont) in (
  (0.5, 0.1, 1, "PostScript"),
  (1, 0, 0.4, "DVI"),
  (0.5, 0.5, 1, "PDF"),
  (0, 0.25, 1, "CSS"),
  (0.5, 1, 0, "XML"),
  (0.5, 1, 0.4, "HTML"),
  (1, 0.2, 0.8, "LaTeX"),
  (1, 0.6, 0.8, "TeX"),
  (0.8, 0.8, 1, "Word"),
  (1, 0.05, 0.05, "ASCII")
) {
  content(
    (bary: ( content: c, structure: s, form: f )),
    text(size:8pt)[#cont],
    fill: rgb(50, 50, 255, 100),
    stroke: none,
    frame: "circle"
  )
}
```

#### Anchor

Defines a point relative to a named element using anchors, see [Anchors](#anchors). 

**name:** `str`  
The name of the element that you wish to use to specify a coordinate.

**anchor:** `str` or `angle` or `number` or `ratio` or `none` — Default: `none`  
The anchor of the element. Strings are named anchors, angles are border anchors and numbers and ratios are path anchors. If not given, the default anchor will be used, on most elements this is `center` but it can be different or not exist at all!

```grid 
circle((0,0), radius:2, name: "circle")

// Anchor at 30 degree
content((name: "circle", anchor: 30deg), box(fill: white, $sscript(30 degree)$))

// Anchor at 30% of the path length
content((name: "circle", anchor: 30%), box(fill: white, $sscript(30%)$))

// Anchor at 3.14 of the path
content((name: "circle", anchor:2*3.14), box(fill: white, $sscript(p =2* 3.14)$), anchor:"center")
```

You can also use implicit syntax of a dot separated string in the form `"name.anchor"` for all anchors. 

```grid
line((0, 0), (4, 3), name: "line")

circle("line.4", name: "circle")

rect("line.start", "circle.east")
```

When using named elements within a group, you can access the element's anchors outside of the group by using the implicit anchor coordinate, e.g. `"a.b.north"`.

```grid
circle((), radius:0.05, fill:teal, stroke:none)

group(name: "a", {circle((0,0), radius:1, name: "b")} )

circle("a.b.south", radius: 0.1)

circle((name: "a", anchor: "b.north"), radius: 0.2)
```

#### Tangent

This system allows you to compute the point that lies tangent to a shape. In detail, consider an element and a point. Now draw a straight line from the point so that it "touches" the element (more formally, so that it is *tangent* to this element). The point where the line touches the shape is the point referred to by this coordinate system. 

**element:** `str`  
The name of the element on whose border the tangent should lie.

**point:** `coordinate`  
The point through which the tangent should go. 

**solution:** `int`  
Which solution should be used if there are more than one.  

A special algorithm is needed in order to compute the tangent for a given shape. Currently it does this by fitting an ellipse to the given center, north and east anchors (see Anchors), so only circles and ellipses will work correctly.  

```grid
grid((0,0), (3,2), help-lines: true)

circle((3,2), name: "a", radius: 2pt)
circle((1,1), name: "c", radius: 0.75)
content("c", $ c $, anchor: "north-east", padding: .1)

line(
  "a.center",   // The starting point or element

  (element: "c", point: "a", solution: 1),  // The tangent coordinate

  "c",  // The center of the circle

  (element: "c", point: "a", solution: 2),  // The other tangent coordinate
  
  "a",
  stroke: red
)
```


```grid
grid((-2,-2), (2,2), help-lines:true)
circle((0,1), radius:0.6, name:"circle", stroke:black)

circle((0,-1), radius:2pt, name:"point")

line(
"point.center", 
(element:"circle", point:"point.center", solution:1),
"circle.center",
(element:"circle", point:"point.center", solution:2),
"point.center",
stroke:red
 )
```

#### Perpendicular

Can be used to find the intersection of a vertical line going through a point $p$ and a horizontal line going through some other point $q$. 

**horizontal:** `coordinate`  
The coordinate through which the horizontal line passes. 

**vertical:** `coordinate`  
The coordinate through which the vertical line passes.  

You can use the implicit syntax of `(horizontal, "|-", vertical)` or `(vertical, "-|", horizontal)`.  



```grid
grid((-3,-3),(3,3), help-lines:true) 
circle((0,0), radius:0.1, fill:orange, stroke:none)
line((-3,1),(1,-2), name:"linea")

/* Symbol "-|" means to extract the y-component of the preceding coordinate and the x-component of the succeeding coordinate as the new coordinate: (x,y). x=x-component, y=y-component. */
line((2,2.5),((),"-|", "linea.start")) 

line((2,2.5),((),"|-", "linea.end")) 
```


```grid
grid((-3,-3),(3,3), help-lines:true) 
circle((-2,1), radius:0.8, name:"circ")
circle((2,-2), radius:0.1, name:"poi")

line("poi.center", (element:"circ", point:"poi.center", solution:1), name:"linea")

line("poi.center", (element:"circ", point:"poi.center", solution:2), name:"lineb")

line((1,2),((),"|-", "lineb.end"))

line((1,2),((),"-|", "lineb.start"))

```


```grid
grid((-2,-2),(2,2), help-lines:true)

line((-2,0), (1,0), name:"horizontal")
line((1,-2), (1,2), name:"vertical")
line((horizontal:"vertical.end",vertical:"horizontal.end"),(2,-1)) 

/* Symbol "-|" means to extract the y-component of the preceding coordinate and the x-component of the succeeding coordinate as the new coordinate: (x,y). x=x-component, y=y-component. */

line(("horizontal.end","-|","vertical.end"),(0,-1))

line(("horizontal.end","|-","vertical.end"),(0,-1))

```


```grid
circle((0,0), radius:0.05, fill:orange, stroke:none)
circle((rel:(30deg,1), update:false), radius:0.05, fill:orange, stroke:none)
circle((rel:(75deg,1), update:false), radius:0.05, fill:orange, stroke:none)

set-style(content: (padding: 0.05))
content((30deg, 1), $p_1$, name: "p1")
content((75deg, 1), $p_2$, name: "p2")

line((-0.2, 0), (1.2, 0), name: "xline")
content("xline.end", $q_1$, anchor: "west")

line((2, -0.2), (2, 1.2), name: "yline")
content("yline.end", $q_2$, anchor: "south")

line("p1.south-east", (horizontal: (), vertical: "xline.end"), stroke:red)

line("p2.south-east", ((), "|-", "xline.end"), stroke:orange)

line("p1.south-east", (vertical: (), horizontal: "yline.end"), stroke:blue)

line("p2.south-east", ((), "-|", "yline.end"), stroke:teal)
```


#### Interpolation

Use this to linearly interpolate between two coordinates `a` and `b` with a given distance `number`. If `number` is a number the position will be at the absolute distance away from `a` towards `b`, a ratio can be given instead to be the relative distance between `a` and `b`. An angle can also be given for the general meaning: "First consider the line from `a` to `b`. Then rotate this line by `angle` around point `a`. Then the two endpoints of this line will be `a` and some point `c`. Use the point `c` for the subsequent computation." 

**a:** `coordinate`  
The coordinate to interpolate from. 

**b:** `coordinate`  
The coordinate to interpolate to. 

**number:** `ratio` or `number`  
The distance between `a` and `b`. A ratio will be the relative distance between the two points, a number will be the absolute distance between the two points. 

**angle:** `angle` — Default: `0deg`  
Angle between $arrow(A B)$ and $arrow(A P)$, where $P$ is the resulting coordinate. This can be used to get the *normal* for a tangent between two points. 

Can be used implicitly as an array in the form `(a, number, b)` or `(a, number, angle, b)`. 

```grid
grid((-3,-3), (3,3), help-lines: true)

line((-2,-2), (2,2), name: "a")
for i in (0%, 20%, 50%, 80%, 100%, 125%) {
  content(("a.start", i, "a.end"),
  box(fill: white, inset: 1pt, [#i])) }

line((-2,-3), (3,2), name: "b")
for i in (0, 1, 3, 5.5) {
  content(("b.start", i, "b.end"),
  box(fill: white, inset: 1pt, text(red, [#i])))}
```

You can also get the normal for a tangent line between two points `a` and `b` using `(a: (), b: a, number: .5, angle: 90deg)`. 

```grid
let (a, b) = ((0,0), (3,2))
line(a, b)
// Get normal for tangent from a to () with distance .5, at a
circle(a, radius: .1, fill: black)
line((a, 1.5, b), (a: (), b: a, number: 1.2, angle: 90deg), stroke: red)
```



```grid
grid((0,0), (3,3), help-lines: true)
line((1,0), (3,2))
line((1,0), ((1, 0), 1.5, 20deg, (3,2))) 
fill(red) 
stroke(none) 
circle(((1, 0), 50%, 20deg, (3, 0)), radius: 2pt) 
```

```grid
grid((-3,-3), (3,3), help-lines:true) 
let n=3 
for i in range(0, n+1) {circle( ((-3,0), i, (3,0)), radius:2pt, fill:orange, stroke:none)}
```


```grid

grid((-3,-3), (3,3), help-lines: true)

fill(black)
stroke(none)
let n = 16
for i in range(0, n+1) {
  circle(((0,0), i / 8, i * 22.5deg, (1,0)), radius: 2pt)}
  
content((-3,4),[#text(size:10pt)[Parametric polar equation] #linebreak() $rho= t/8$ #linebreak() $theta= t* 22.5degree$ #linebreak() $t= 0, 1, 2, ..., 16$ #linebreak() $rho = 0.3183 * theta$ #linebreak() $theta in (0, 2 pi )$], anchor:"south-west")
```


```grid
grid((-3, -3), (3, 3), help-lines: true)
content((-3, 3.5), [Archimedean spiral #linebreak() $r = a theta$], anchor: "south-west")

// Archimedean spiral (r = 0.4 θ)
let a = 0.4
let max-theta = 2*calc.pi
let step = 0.1
let num-steps = calc.ceil(max-theta / step)

for i in range(0, int(num-steps) + 1) {
let theta = i * step
let r = a * theta
circle((theta * 1rad, r), fill: black, radius: 2pt, stroke: none)
}

```

Archimedean spiral

The Archimedean spiral, also known as Archimedes' spiral, is a plane curve formed by a point starting at the origin and moving away from it at a constant linear speed while the line from the origin to the point rotates at a constant angular speed around the origin, producing a spiral with successive turns separated by a fixed distance.  In polar coordinates, it is defined by the equation  $r = a theta$, where $r$ is the radial distance from the origin, $theta$ is the polar angle in radians, and $a$ is a positive constant determining the spacing between arms. This contrasts with logarithmic spirals, where the spacing increases exponentially, making the Archimedean spiral the locus of points where the radius grows linearly with the angle.

Key properties include: constant pitch, where the perpendicular distance between successive turns is $2 pi a$. Parametric equations in Cartesian coordinates: $x = a  theta cos theta$, $y = a theta sin theta$.  Arc length from $theta = 0$ to $theta$ is  $display(s(theta) = a/2[ theta sqrt(1 + theta^(2)) + ln(theta + sqrt(1 + theta^(2))) ])$ ,  Curvature: $kappa(theta) = frac(2 + theta^(2), a(1 + theta^(2))^(3 /2))$ decreases as $theta$ increases. 


#### Function

An array where the first element is a function and the rest are coordinates will cause the function to be called with the resolved coordinates. The resolved coordinates will be given as a vector that represents an xyz point in space. 

```grid
circle((0, 0), name: "c")
fill(red)
circle((v => cetz.vector.add(v, (0, -1)), "c.west"), radius: 0.3)
```


map() function 

Typst provides a very useful .map() method on arrays (and similar collection types).  It creates a new array where each element is transformed by the given function.  Here are some simple, progressively more practical examples:

```grid
let numbers = (1, 4, 7, -2, 9)

content((0,0),[#numbers.map(n => n * 2)], anchor:"west")

content((0,-2),[#numbers.map(calc.abs)], anchor:"west")

content((0,-4),[#numbers.map(n => n + 10)], anchor:"west")
```


```grid
let data = (12, 18, 5) 

let data-transform = data.map( n => str(n) + " kg" ) 

content((0,0), [#data-transform], anchor:"west") 
```

Define frange() function 
Neither CeTZ nor Typst provides a built-in range() function for floating-point numbers. Typst's native range() function strictly accepts integers for its start, end, and step arguments.  However, you can easily create a float-compatible range functions using the integer range() combined with the .map() method.  

Step-Based Float Range 
If you want to specify a continuous interval (e.g., step by 0.5), you can calculate the number of steps needed, generate an integer array, and map the float step over it. This behaves similarly to numpy.arange in Python. 

An Archimedean spiral generated by using frange function. 
```grid
let frange(start, end, interval:1.0)= { 
let num-steps=  calc.ceil( (end - start)/interval ); 
let arr =range(0, num-steps, step:1)
.map(i => start + i*interval)
arr.map(a => calc.round(a, digits:3))
}

// Archimedean spiral  r= 0.4 * theta 
grid((-3,-3),(3,3), help-lines:true)
let theta-array = frange(0, 2*calc.pi, interval:0.1) 

for theta in theta-array {
let r = 0.4 * theta; 
circle((theta*1rad, r), radius:2pt, fill:black, stroke:none)
}
content((-3,3.5), [Archimedean spiral #linebreak() $r = 0.4 theta$], anchor:"south-west")
```
An Archimedean spiral generated by using linspace function.
```grid
let linspace(start, end, num)= {
let step =  (end - start)/num ;
let arr = range(num).map(a => start + a * step )
arr 
} 

grid((-3,-3),(3,3), help-lines:true) 
let theta-array = linspace(0, 2*calc.pi, 60) 
for theta in theta-array {
let r = 0.4 * theta 
circle((theta*1rad, r), radius:2pt, fill:black, stroke:none) 
}
content((-3,3.5), [Archimedean spiral #linebreak() $r = 0.4 * theta$], anchor:"south-west")
```


#### Projection

You can project a point `pt` onto a line from `a` to `b` using the `(project: pt, onto: (a, b))` coordinate or the short form `(pt, "_|_", a, b)`. 

```grid
set-style(fill: black, radius: 0.1)
circle(name: "A", (0, 0), fill:orange, stroke:none)
circle(name: "B", (3, 1))
circle(name: "P", (1.9, -1.6))
line("A", "B")
line("P", (project: "P", onto: ("A", "B")))
```

---

### Anchors

You can refer to a position relative to a named element by using its anchors. Anchors come in several different variations but can all be used in two different ways. 

The first is by using the `anchor` argument on an element. When given, the element will be translated such that the given anchor will be where the given position is. This is supported by all elements that have an `anchor` argument.

The second is by using anchor coordinates. You must first give the element a name by passing a string to its `name` argument, you can then use its anchors to place other elements. Note this is only available for elements that have a `name` argument.

Note that all anchors are transformed along with the element.

#### Named Anchors

Named anchors are normally unique to the type of element, such as a bezier curve's control points. All elements also have a `"default"` named anchor; it always refers to another anchor on the element.

#### Border Anchors

A border anchor refers to a point on the element's border where a ray is cast from the element's center. They are given as angles where `0deg` is towards the right and `90deg` is up. Border anchors also specify named compass directions such as `"north"`, `"north-east"`, `"east"`, `"south-east"`, `"south"`, `"south-west"`, `"west"`, `"north-west"`. Border anchors also specify a `"center"` named anchor which is where the ray cast originates from.

#### Path Anchors

A path anchor refers to a point along the path of an element. They can be given as either a number for an absolute distance along the path, or a ratio for a relative distance along the path. Path anchors also specify three anchors: `"start"`, `"mid"`, and `"end"`.

---

### Marks

Marks are arrow tips that can be added to the end of path based elements that support the `mark` style key, or can be directly drawn by using the `mark` draw function. Marks are specified by giving their names (or shorthand) as strings and have several options to customise them. You can give an array of names to have multiple marks, and dictionaries can be used in the array for per mark styling.

```grid
let c = ((rel: (0, -1)), (rel: (2, 0), update: false)) 
// Coordinates to draw the line, it is not necessary to understand this for this example.

// No marks
line((), (rel: (1, 0), update: false))

// Draws a triangle mark at both ends of the line.
set-style(mark: (symbol: ">"))
line(..c)

// Overrides the end mark to be a diamond but the start is still a triangle.
set-style(mark: (end: "<>"))
line(..c)

// Draws two triangle marks at both ends but the first mark of end is still a diamond.
set-style(mark: (symbol: (">", ">")))
line(..c)

// Sets the stroke of first mark in the sequence to red but the end mark overrides it to be blue.
set-style(mark: (symbol: ((symbol: ">", stroke: red), ">"), end: (stroke: blue)))
line(..c)
```

#### symbol:
`none` or `str` or `array` or `dictionary` — Default: `none`

This option sets the mark to draw when using the `mark` draw function, or applies styling to both mark ends of path based elements. The mark's name or shorthand can be given. Multiple marks can be drawn by passing an array of names or shorthands. When `none`, no marks will be drawn. A style dictionary can be given instead of a `str` to override styling for that particular mark, just make sure to still give the mark name using the `symbol` key otherwise nothing will be drawn!

#### start:
`none` or `str` or `array` or `dictionary` — Default: `none`

This option sets the mark to draw at the start of a path based element. It will override all options of the `symbol` key and will not affect marks drawn using the `mark` draw function.

#### end:
`none` or `str` or `array` or `dictionary` — Default: `none`

Like `start` but for the mark at the end of a path.

#### length:
`number` — Default: `0.2cm`

The size of the mark in the direction it is pointing.

#### width:
`number` — Default: `0.15cm`

The size of the mark along the normal of its direction.

#### inset:
`number` — Default: `0.05cm`

It specifies a distance by which something inside the arrow tip is set inwards; for the stealth arrow tip it is the distance by which the back angle is moved inwards.

#### scale:
`float` — Default: `1`

A factor that is applied to the mark's length, width and inset.

#### sep:
`number` — Default: `0.1cm`

The distance between multiple marks along their path.

#### position-samples:
`int` — Default: `30`

Only applicable when marks are used on curves such as bezier and hobby. The maximum number of samples to use for calculating curve positions. A higher number gives better results but may slow down compilation.

#### pos:
`number` or `ratio` or `none` — Default: `none`

Overrides the mark's position along a path. A number will move it an absolute distance, while a ratio will be a distance relative to the length of the path. Note that this may be removed in the future in preference of a different method.

#### offset:
`number` or `ratio` or `none` — Default: `none`

Like `pos` but it advances the position of the mark instead of overriding it.

#### anchor:
`str` — Default: `tip`

Anchor to position the mark at. Can be one of `base`, `center` or `tip`.

#### slant:
`ratio` — Default: `0%`

How much to slant the mark relative to the axis of the arrow. `0%` means no slant; `100%` slants at 45 degrees.

#### harpoon:
`bool` — Default: `false`

When true only the top half of the mark is drawn.

#### flip:
`bool` — Default: `false`

When true the mark is flipped along its axis.

#### reverse:
`bool` — Default: `false`

Reverses the direction of the mark.

#### xy-up:
`vector` — Default: `(0, 0, 1)`

The direction which is "up" for use when drawing 2D marks.

#### z-up:
`vector` — Default: `(0, 1, 0)`

The direction which is "up" for use when drawing 3D marks.

#### shorten-to:
`int` or `auto` or `none` — Default: `auto`

Which mark to shorten the path to when multiple marks are given. `auto` will shorten to the last mark, `none` will shorten to the first mark (effectively disabling path shortening). An integer can be given to select the mark's index.

#### transform-shape:
`bool` — Default: `true`

When `false` marks will not be stretched/affected by the current transformation; marks will be placed after the path is transformed.

---

## Libraries

### Tree

The tree library allows the drawing of diagrams with simple tree layout algorithms.

#### Nodes

A tree node is an array consisting of the node's value at index 0 followed by its child nodes. For the default `draw-node` function, the value (the first item) of a node must be of type `content`.

Example of a list of nodes:

```grid
cetz.tree.tree(
  (
    [A],
    (
      [B],
      (
        [C],
        ([D],)
      )
    )
  ),
  direction: "right"
)
```

Example of a tree of nodes:

```grid
cetz.tree.tree(
  (
    [A],
    (
      [B],
      [C]
    ),
    (
      [D],
      [E]
    )
  ),
  direction: "right"
)
```

#### Drawing and Styling Tree Nodes

The `tree()` function takes an optional `draw-node:` and `draw-edge:` callback function that can be used to customise node and edge drawing.

The `draw-node` function must take the current node and its parent's node anchor as arguments and return one or more elements.

For drawing edges between nodes, the `draw-edge` function must take two node anchors and the target node as arguments and return one or more elements.

```grid
import cetz.tree
let data = ([\*], ([A], [A.A], [A.B]), ([B], [B.A]))
tree.tree(
  data,
  direction: "right",
  draw-node: (node, ..) => {
    circle((), radius: .35, fill: blue, stroke: none)
    content((), text(white, [#node.content]))
  },
  draw-edge: (from, to, ..) => {
    let (a, b) = (from + ".center", to + ".center")
    line((a, .4, b), (b, .4, a))
  }
)
```

For each node, the tree function creates an anchor of the format `"[<child-index>-]<child-index>"` (the root is `"0"`, its first child `"0-0"`, second `"0-1"` and so on) that can be used to query a node's position on the canvas.

```
import cetz.tree
set-style(content: (padding: .1))
tree.tree(([Root], ([A], [A.A], [A.B]), ([B], [B.A])))
```

---

## Tutorials

### A Picture for Karl's New Students

This tutorial is intended for new users of CeTZ. It does not give an exhaustive account of all the features of CeTZ, just of those you are likely to use right away. This tutorial also acts as a parallel to TikZ's tutorial *A Picture for Karl's Students*.

Karl is a math and chemistry high-school teacher. He used to create the graphics in his worksheets and exams using the TikZ package with LaTeX. While the results were acceptable, Karl, for his own reasons, has started using Typst instead. He looks through the provided packages in Typst: Universe and finds CeTZ, which is supposed to stand for "CeTZ, ein Typst Zeichenpaket" and appears appropriate.

#### Problem Statement

Karl wants to put a graphic on the next worksheet for his students. He is currently teaching his students about sine and cosine. He already has the graphic drawn with TikZ and would like to keep it as close to it as possible.

#### Setting up the Environment

In CeTZ, to draw a picture, two imports and a function call is all you need. Karl sets up his file as follows:

```
#set page(width: auto, height: auto)
#import "@preview/cetz:0.4.2"

We are working on
#cetz.canvas({
  import cetz.draw: *
  line((-1.5, 0), (1.5, 0))
  line((0, -1.5), (0, 1.5))
})
```

Admittedly, not quite the whole picture, yet, but we do have the axes established. Let's have a more detailed look at the code. First, the package `cetz` is imported. The `canvas` function in the `cetz` module is then called and a pair of curly braces are placed as the function's first (and only) positional argument. The braces create a scope or body, in which more functions can be called, but first must be imported from the `draw` module.

Inside the body there are two `line` functions. They are draw functions that draw straight lines between given positions. The first `line` function is given the parameters `(-1.5, 0), (1.5, 0)`, which refer to a point at position $(-1.5, 0)$ and $(1.5, 0)$. Here, the positions are specified within a special coordinate system in which, initially, one unit is 1cm.

Karl is quite pleased to note that the environment automatically reserves enough space to encompass the picture.

#### Line Construction

The basic building block of all pictures in CeTZ are draw functions. A draw function is a function that can be called inside the canvas body in order to create the graphic, such as `line`, `bezier`, `rect` and many more (not all draw functions *actually* draw something, like `set-style`, but still effect the outcome of the picture).

In order to draw a path of straight lines, the `line` draw function can be used. You specify the coordinates of the start position by passing an array with two numbers (a coordinate type) to the first parameter of `line`. The second coordinate must be given as the second parameter of the function otherwise it will panic. Subsequent coordinates can be passed to the function to draw additional lines between the previous and next coordinates.

```
line((-1.5, 0), (1.5, 0), (0, -1.5), (0, 1.5))
```

Note that the `canvas` function and import statements have been omitted from the code as they are boiler plate and don't always need to be shown.

#### Curve Construction

The next thing Karl wants to do is to draw the circle. For this, straight lines obviously will not do. Instead, we need some way to draw curves. For this, CeTZ provides several other draw functions, the most useful here would be the `bezier` function. As the name suggests, it can draw a bezier curve when a start and end coordinate is given, as well as one or two control points.

Here is an example (the control points have been added for clarity):

```grid
// start and end
circle((0, 0), radius: 2pt, fill: gray)
circle((2, 0), radius: 2pt, fill: gray)
// control points
circle((1, 1), radius: 2pt, fill: gray)
circle((2, 1), radius: 2pt, fill: gray)

bezier((0, 0), (2, 0), (1, 1), (2, 1))
```

So, Karl can now add the first half circle to the picture:

```grid
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))

bezier((-1, 0), (0, 1), (-1, 0.555), (-0.555, 1))
bezier((0, 1), (1, 0), (0.555, 1), (1, 0.555))
```

Karl is happy with the result, but finds specifying circles in this way to be extremely awkward. Fortunately, there is a much simpler way.

#### Circle Construction

In order to draw a circle, the `circle` draw function can be used:

```
circle((0, 0), radius: 10pt)
```

You can also draw an ellipse with this draw function by passing an array of two numbers to the `radius` argument:

```
circle((0, 0), radius: (20pt, 10pt))
```

So, returning to Karl's problem, he can write `circle((0, 0))` to draw the circle as, by default, the `radius` argument is `1`:

```
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))

circle((0, 0))
```

At this point, Karl is a bit alarmed that the circle is so small when he wants the final picture to be much bigger. He is pleased to learn that CeTZ has transformation draw functions and scaling everything by a factor of three is very easy.

#### Rectangle Construction

The next things we would like to have is the grid in the background. One might draw lots of rectangles using the `rect` draw function. Two coordinates should be passed as arguments, they specify the corners of the rectangle:

```grid
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))
circle((0, 0))

rect((0, 0), (0.5, 0.5))
rect((-0.5, -0.5), (-1, -1))
```

While this may be nice in other situations, this is not really leading anywhere with Karl's problem — it would require an awful lot of rectangles and there is the border that is not "closed". So, Karl is about to resort to simply drawing four vertical and four horizontal lines, when he learns that there is a `grid` draw function.

#### Grid Construction

The `grid` draw function adds a grid to the picture. It will add lines making up a grid that fills the rectangle specified by two coordinates passed to it.

For Karl, the following code could be used:

```
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))
circle((0, 0))

grid((-1.5, -1.5), (1.5, 1.5), step: 0.5)
```

Having another look at his desired picture, Karl notices that it would be nice for the grid to be more subdued. To subdue the grid, Karl adds more named arguments to the `grid` draw function: `gray` for the grid lines and a reduced line width of `0.2pt`. He also swaps the ordering of the commands so that the grid is drawn first and everything else on top.

```
grid((-1.5, -1.5), (1.5, 1.5), step: 0.5, stroke: gray + 0.2pt)
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))
circle((0, 0))
```

#### Adding a Touch of Style

Karl notices that the thickness of the circle and axes paths are much greater than the grid's thickness. He learns that CeTZ's default stroke thickness is actually `1pt` and not TikZ's `0.4pt`. We can use the `set-style` draw function to apply styling to all subsequent draw functions, similar to how Typst's `set` and `show` rules work:

```
set-style(stroke: 0.4pt)
grid((-1.5, -1.5), (1.5, 1.5), step: 0.5, stroke: gray + 0.2pt)
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))
circle((0, 0))
```

Karl now wants to add the sine and cosine lines. There are different ways of specifying coordinates. The easiest way is to say something like `(10pt, 2cm)`. Alternatively, you can leave out the units as in `(1, 2)`, which means "one times the unit length in the respective directions". In order to specify points in polar coordinates, use an array of the form `(30deg, 1cm)`, which means 1cm in direction 30 degree.

You can wrap a coordinate in a dictionary with the key `rel` as in `(rel: (0cm, 1cm))`. Such coordinates are interpreted differently: they mean "1cm upwards from the previous specified position, making this the new specified position". You can include the key and value `update: false` in the coordinate which means "do not change the previous position".

#### Scaling

For this, he can use the `scale` draw function at the start of the canvas body:

```grid
set-style(
  stroke: 0.4pt,
  grid: (
    stroke: gray + 0.2pt,
    step: 0.5
  )
)
scale(2)
grid((-1.5, -1.5), (1.5, 1.5))
line((-1.5, 0), (1.5, 0))
line((0, -1.5), (0, 1.5))
circle((0, 0))
arc((3mm, 0), start: 0deg, stop: 30deg, radius: 3mm)
```

As for circles, you can specify the radius as an array of two numbers to get an elliptical arc:

```
arc((0, 0), start: 0deg, stop: 315deg, radius: (1.75, 1))
```

#### Marks (Arrow Tips)

Karl now wants to add arrow tips to the ends of the axes. He uses the `mark` styling parameter:

```grid
set-style(
  stroke: 0.4pt,
  grid: (
    stroke: gray + 0.2pt,
    step: 0.5
  )
)
scale(3)
grid((-0.5, -0.5), (1.5, 1.5))
line((-0.5, 0), (1.5, 0), mark: (end: ">"))
line((0, -0.5), (0, 1.5), mark: (end: ">"))
arc((0, 0), start: 120deg, stop: -30deg, anchor: "origin")
arc(
  (3mm, 0), start: 0deg, stop: 30deg, radius: 3mm,
  mode: "PIE",
  fill: color.mix((green, 20%), white),
)
line((30deg, 1cm), (rel: (0, -0.5)), stroke: red + 1.2pt)
line((), (0, 0), stroke: blue + 1.2pt)
hide({
  line((1, 0), (1, 1), name: "upward line")
  line((0, 0), (30deg, 1.5cm), name: "sloped line")
})
intersections("x", "upward line", "sloped line")
line((1, 0), "x.0", stroke: orange + 1.2pt)
```

If Karl had used the value `(start: ">")` instead of `(end: ">")`, arrow tips would have been put at the beginning of the path. The value `(start: ">", end: ">")` or `(symbol: ">")` puts the marks at both ends of the path.

Karl notices that the marks are unnaturally large because the shape of marks are transformed by default. This can be resolved by setting the `transform-shape: false` styling parameter. He also wants the mark to be filled and to have a different shape: 

```grid
set-style(
  stroke: 0.4pt,
  grid: (
    stroke: gray + 0.2pt,
    step: 0.5
  ),
  mark: (
    transform-shape: false,
    fill: black
  )
)
scale(3)
grid((-1, -1), (1.5, 1.5))
line((-1, 0), (1.5, 0), mark: (end: "stealth"))
line((0, -1), (0, 1.5), mark: (end: "stealth"))
circle((0, 0))
arc(
  (3mm, 0), start: 0deg, stop: 30deg, radius: 3mm,
  mode: "PIE",
  fill: color.mix((green, 20%), white),
)
for x in (-1, -0.5, 1) {
  line((x, -1pt), (x, 1pt))
}
for y in (-1, -0.5, 0.5, 1) {
  line((-1pt, y), (1pt, y))
}
```

---

## Advanced

The Advanced section covers more complex topics for CeTZ. Refer to the API documentation for the full reference on draw functions, transformations, and internal utilities.

---

## API Reference

The CeTZ API documentation is available at [https://cetz-package.github.io/docs/api/overview](https://cetz-package.github.io/docs/api/overview) and covers: 

- **Draw Functions** — shapes (line, circle, rect, arc, bezier, catmull, hobby, etc.), styling (`set-style`, `fill`, `stroke`),  grouping (`group`, `scope`), transformations (`scale`, `rotate`, `translate`), content placement, utility functions  (intersections, hide, etc.), and 3D projection functions (`ortho`, `on-xy`, `on-xz`, `on-yz`). 
- **Libraries** — Tree layout (`cetz.tree`), Palette (`cetz.palette`). 
- **Internal** — Vector utilities, matrix operations, canvas internals. 

---

*Source: [https://cetz-package.github.io/docs/](https://cetz-package.github.io/docs/) — CeTZ Documentation (work in progress)*  
*GitHub: [https://github.com/cetz-package/cetz](https://github.com/cetz-package/cetz)* 





























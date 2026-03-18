// ============================================================
// Linear Algebra Visualized
// A self-contained Typst document with CeTZ 0.4.2 diagrams
// ============================================================

#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/xarrow:0.4.0": xarrow, xarrowSquiggly, xarrowTwoHead

// ── Global page & typography setup ──────────────────────────
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  header: align(right)[
    #text(size: 9pt, fill: luma(140))[Linear Algebra Visualized]
  ],
  numbering: "1/1",
)

#set text(font: "New Computer Modern", size: 11pt, lang: "en")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  v(1.2em)
  block(
      fill: rgb("#4169E1"),
//    fill: rgb("#1a1a2e"),
    radius: 4pt,
    inset: (x: 12pt, y: 8pt),
    width: 100%,
  )[
    #text(fill: white, size: 14pt, weight: "bold")[#it]
  ]
  v(0.5em)
}

#show heading.where(level: 2): it => {
  v(0.8em)
  text(fill: rgb("#16213e"), size: 12pt, weight: "bold")[#it]
  v(0.3em)
}

// Coloured callout box
#let note(body) = block(
  fill: rgb("#eef4fb"),
  stroke: (left: 3pt + rgb("#3a86ff")),
  inset: (left: 10pt, right: 10pt, top: 8pt, bottom: 8pt),
  radius: (right: 4pt),
  width: 100%,
  body,
)

// ── Title page ───────────────────────────────────────────────
#align(center)[
  #v(2cm)
  #text(size: 28pt, weight: "extrabold", fill: rgb("#1a1a2e"))[
    Linear Algebra Visualized
  ]
  #v(0.5cm)
  #text(size: 14pt, fill: luma(80))[
    Matrix Multiplication · Eigenvalues & Eigenvectors · SVD \ 
    Transformation Matrices · Quaternions · Projection Matrices
  ]
  #v(0.5cm)
//  #line(length: 60%, stroke: rgb("#3a86ff") + 2pt)
  #v(2cm)
]

#pagebreak()

// ============================================================
// 1. MATRIX MULTIPLICATION
// ============================================================
= Matrix Multiplication

== Mathematical Background

Matrix multiplication is a fundamental binary operation that combines two matrices to produce a third. For matrices $A in RR^(m times k)$ and $B in RR^(k times n)$, the product $C = A B in RR^(m times n)$ is defined entry-wise as

$ C_(i j) = sum_(r=1)^(k) A_(i r) B_(r j) $

The operation is associative and distributive over addition, but _not_ commutative in general: $A B eq.not B A$.

A powerful geometric interpretation is the _row-times-column_ dot product view: the $(i,j)$ entry of $C$ equals the dot product of the $i$-th row of $A$ with the $j$-th column of $B$.

#note[
  *Dimension check:* $A$ is $m times k$ and $B$ is $k times n$ — the inner dimensions must match. The result has shape $m times n$.
]

== Worked Example

Consider

$ A = mat(1, 2; 3, 4) quad B = mat(5, 6; 7, 8) $

Then

$ C = A B = mat(1 dot 5 + 2 dot 7, space 1 dot 6 + 2 dot 8; 3 dot 5 + 4 dot 7, space 3 dot 6 + 4 dot 8) = mat(19, 22; 43, 50) $

== Visualization: Row × Column Dot Product

The diagram below shows how the $(1,1)$ entry of $C$ is formed by dotting the first row of $A$ with the first column of $B$.

#align(center)[
#canvas({
  import draw: *

  let cell-w = 1.0
  let cell-h = 0.9

  // Helper: draw a 2×2 matrix grid
  let draw-matrix(origin, entries, highlight-row: none, highlight-col: none, label: "") = {
    let (ox, oy) = origin
    for row in range(2) {
      for col in range(2) {
        let x = ox + col * cell-w
        let y = oy - row * cell-h
        let idx = row * 2 + col
        let fill-col = white
        if highlight-row != none and highlight-col != none {
          if row == highlight-row { fill-col = rgb("#cce5ff") }
          if col == highlight-col and highlight-row == none { fill-col = rgb("#d4edda") }
        }
        if highlight-row == row { fill-col = rgb("#cce5ff") }
        if highlight-col == col { fill-col = rgb("#d4edda") }
        rect(
          (x, y),
          (x + cell-w, y - cell-h),
          fill: fill-col,
          stroke: luma(160),
        )
        content(
          (x + cell-w / 2, y - cell-h / 2),
          text(size: 11pt)[#entries.at(idx)],
        )
      }
    }
    // bracket lines
    line((ox - 0.15, oy), (ox - 0.15, oy - 2 * cell-h), stroke: black + 1.5pt)
    line((ox - 0.15, oy), (ox - 0.05, oy), stroke: black + 1.5pt)
    line((ox - 0.15, oy - 2*cell-h), (ox - 0.05, oy - 2*cell-h), stroke: black + 1.5pt)
    let right-x = ox + 2 * cell-w
    line((right-x + 0.15, oy), (right-x + 0.15, oy - 2 * cell-h), stroke: black + 1.5pt)
    line((right-x + 0.15, oy), (right-x + 0.05, oy), stroke: black + 1.5pt)
    line((right-x + 0.15, oy - 2*cell-h), (right-x + 0.05, oy - 2*cell-h), stroke: black + 1.5pt)
    if label != "" {
      content((ox + cell-w, oy + 0.4), text(weight: "bold", size: 12pt)[#label])
    }
  }

  // A  — highlight row 0
  draw-matrix((0, 0), ("1","2","3","4"), highlight-row: 0, label: "A")

  // ×
  content((2.4, -0.9*0.5), text(size: 18pt)[$times$])

  // B — highlight col 0
  draw-matrix((2.9, 0), ("5","6","7","8"), highlight-col: 0, label: "B")

  // =
  content((5.3, -0.9*0.5), text(size: 18pt)[$=$])

  // C — highlight (0,0)
  draw-matrix((5.8, 0), ("19","22","43","50"), highlight-row: 0, label: "C")

  // Highlight C(0,0)
  rect(
    (5.8, 0),
    (5.8 + cell-w, 0 - cell-h),
    fill: rgb("#ff6b6b").transparentize(30%),
    stroke: rgb("#ff6b6b") + 2pt,
  )

  // Annotation
  content((3.9, -2.4),
    text(size: 9pt, fill: luma(50))[
      Row 0 of A $dot$ Col 0 of B $=$ $1 times 5 + 2 times 7 = 19$
    ]
  )

  // Arrow from highlighted row/col to result
//  line((1.2, -0.45), (5.75, -0.45),
//    stroke: (paint: rgb("#ff6b6b"), dash: "dashed", thickness: 1pt),
//    mark: (end: ">"),  )
})
]

#v(0.5em)
The blue row and green column are multiplied element-wise and summed to produce the highlighted red cell.

// ============================================================
// 2. EIGENVALUES AND EIGENVECTORS
// ============================================================
= Eigenvalues and Eigenvectors

== Mathematical Background

Given a square matrix $A in RR^(n times n)$, a non-zero vector $bold(v) in RR^n$ is an *eigenvector* of $A$ if applying $A$ to $bold(v)$ merely scales it:

$ A bold(v) = lambda bold(v) $

The scalar $lambda$ is the corresponding *eigenvalue*. The eigenvectors reveal the _invariant directions_ of the linear map — directions that are only stretched or flipped, never rotated.

To find eigenvalues, we solve the *characteristic equation*

$ det(A - lambda I) = 0 $

For a $2 times 2$ matrix $A = mat(a, b; c, d)$, this gives

$ lambda^2 - (a + d) lambda + (a d - b c) = 0 $

i.e. $lambda^2 - "tr"(A) lambda + det(A) = 0$.

== Worked Example

Let $A = mat(3, 1; 0, 2)$.

*Step 1 — Characteristic polynomial:*

$ det mat(3 - lambda, 1; 0, 2 - lambda) = (3 - lambda)(2 - lambda) = 0 $

So $lambda_1 = 3$ and $lambda_2 = 2$.

*Step 2 — Eigenvectors for $lambda_1 = 3$:*

$(A - 3 I)bold(v) = 0 => mat(0,1;0,-1) bold(v) = 0 => bold(v)_1 = vec(1, 0)$

*Step 3 — Eigenvectors for $lambda_2 = 2$:*

$(A - 2 I)bold(v) = 0 => mat(1,1;0,0) bold(v) = 0 => bold(v)_2 = vec(-1, 1)$

== Visualization: Vectors Before and After Transformation

#align(center)[
#canvas({
  import draw: *

  let sc = 0.85  // scale factor

  // Grid
  for i in range(-3, 4) {
    line((i*sc, -3*sc), (i*sc, 3*sc), stroke: (paint: luma(220), thickness: 0.5pt))
    line((-3*sc, i*sc), (3*sc, i*sc), stroke: (paint: luma(220), thickness: 0.5pt))
  }

  // Axes
  line((-3*sc, 0), (3*sc, 0), mark: (end: ">"), stroke: luma(140) + 1pt)
  line((0, -3*sc), (0, 3*sc), mark: (end: ">"), stroke: luma(140) + 1pt)

  // Eigenvector 1:  v1=(1,0), Av1=3*(1,0) — shows scaling along x-axis
  // Original
  line((0,0), (1*sc, 0), mark: (end: ">"), stroke: rgb("#3a86ff") + 2pt)
  content((1*sc + 0.2, 0.2), text(size: 9pt, fill: rgb("#3a86ff"))[$bold(v)_1$])

  // Transformed (scaled by λ=3)
  line((0,0), (3*sc, 0), mark: (end: ">"), stroke: (paint: rgb("#3a86ff"), dash: "dashed", thickness: 2pt))
  content((3*sc + 0.1, 0.2), text(size: 9pt, fill: rgb("#3a86ff"))[$A bold(v)_1$])

  // Eigenvector 2: v2=(-1,1), Av2=2*(-1,1)
  line((0,0), (-1*sc, 1*sc), mark: (end: ">"), stroke: rgb("#ff6b6b") + 2pt)
  content((-1*sc - 0.4, 1*sc + 0.2), text(size: 9pt, fill: rgb("#ff6b6b"))[$bold(v)_2$])

  line((0,0), (-2*sc, 2*sc), mark: (end: ">"),
    stroke: (paint: rgb("#ff6b6b"), dash: "dashed", thickness: 2pt))
  content((-2*sc - 0.4, 2*sc + 0.2), text(size: 9pt, fill: rgb("#ff6b6b"))[$A bold(v)_2$])

  // Generic vector (1,1) — gets rotated, NOT an eigenvector
  line((0,0), (1*sc, 1*sc), mark: (end: ">"), stroke: rgb("#aaa") + 1.5pt)
  content((1*sc + 0.15, 1*sc + 0.15), text(size: 8pt, fill: luma(100))[$bold(u)$])

  // A*(1,1) = (4,2)
  line((0,0), (2.8*sc, 1.4*sc), mark: (end: ">"),
    stroke: (paint: rgb("#aaa"), dash: "dashed", thickness: 1.5pt))
  content((2.8*sc + 0.1, 1.4*sc + 0.1), text(size: 8pt, fill: luma(100))[$A bold(u)$])

  // Legend
  content((0, -3.3*sc),
    text(size: 9pt)[Solid = original · Dashed = transformed · #text(fill:rgb("#3a86ff"))[$lambda_1=3$] · #text(fill:rgb("#ff6b6b"))[$lambda_2=2$]])
})
]

Eigenvectors $bold(v)_1$ and $bold(v)_2$ stay on the same line through the origin after transformation; the generic vector $bold(u)$ changes direction.




#align(center)[
#canvas({
import draw:*

grid((-3,-3),(3,3),help-lines:true)
let A= ((3,1),(0,2))
let (v_1,v_2)=((1,0),(-1,1))
// let lambda_1 = matrix.mul-vec()
// let (lambda_1v_1, lambda_2v_2)=()

})
]

// ============================================================
// 3. SINGULAR VALUE DECOMPOSITION (SVD)
// ============================================================
= Singular Value Decomposition (SVD)

== Mathematical Background

The SVD is one of the most important factorizations in all of applied mathematics. Every real matrix $A in RR^(m times n)$ can be written as

$ A = U Sigma V^top $

where

- $U in RR^(m times m)$ is orthogonal ($U^top U = I$) — its columns are the *left singular vectors*,
- $V in RR^(n times n)$ is orthogonal ($V^top V = I$) — its columns are the *right singular vectors*,
- $Sigma in RR^(m times n)$ is pseudo-diagonal with non-negative entries $sigma_1 >= sigma_2 >= dots >= 0$ on the diagonal — the *singular values*.

The singular values are the square roots of the eigenvalues of $A^top A$ (or $A A^top$):

$ sigma_i = sqrt(lambda_i(A^top A)) $

The *rank* of $A$ equals the number of non-zero singular values.

=== Key Applications

- *Low-rank approximation:* Truncate to the top $k$ singular values: $A approx sum_(i=1)^k sigma_i bold(u)_i bold(v)_i^top$ (Eckart–Young theorem — this is the best rank-$k$ approximation in both Frobenius and spectral norms).
- *Pseudoinverse:* $A^+ = V Sigma^+ U^top$.
- *PCA:* The right singular vectors of the (centered) data matrix are the principal components.

== Geometric Interpretation

SVD decomposes a linear map into three steps:

$ bold(x) xarrow(V^top) "rotate" xarrow(Sigma) "scale axes" xarrow(U) "rotate again" A bold(x) $

== Visualization: The Unit Circle Under SVD Steps

We show how the unit circle $bold(x)$ is mapped to an ellipse $A bold(x)$, with intermediate steps.

#align(center)[
#canvas({
  import draw: *
  let pi = calc.pi

  // ── Step 0: unit circle (input space) ──
  let pts0 = range(0, 361, step: 5).map(i => {
    let t = i * pi / 180
    (calc.cos(t), calc.sin(t))
  })

  // ── Example A = U Σ Vt ──
  // Σ = diag(2.5, 0.8), U = rot(30°), V = rot(15°)
  // A x = U Σ Vt x
  let cos30 = calc.cos(30 * pi / 180)
  let sin30 = calc.sin(30 * pi / 180)
  let cos15 = calc.cos(15 * pi / 180)
  let sin15 = calc.sin(15 * pi / 180)

  // Vt x  (right-rotate by 15°)
  let vt(p) = {
    let (x, y) = p
    (cos15 * x + sin15 * y, -sin15 * x + cos15 * y)
  }
  // Σ (scale)
  let sigma(p) = {
    let (x, y) = p
    (2.5 * x, 0.8 * y)
  }
  // U (rotate by 30°)
  let u-rot(p) = {
    let (x, y) = p
    (cos30 * x - sin30 * y, sin30 * x + cos30 * y)
  }

  // Three coordinate systems side by side
  let offset-x = 3.8

  // ── Draw each panel ──
  for panel in range(0, 3) {
    let ox = panel * offset-x

    // light grid
    for i in (-3, -2, -1, 0, 1, 2, 3) {
      line((ox + i*0.8, -2.6), (ox + i*0.8, 2.6),
        stroke: (paint: luma(230), thickness: 0.4pt))
      line((ox - 2.4, i*0.8), (ox + 2.4, i*0.8),
        stroke: (paint: luma(230), thickness: 0.4pt))
    }
    // axes
    line((ox - 2.5, 0), (ox + 2.5, 0), mark: (end: ">"), stroke: luma(160) + 0.8pt)
    line((ox, -2.6), (ox, 2.6), mark: (end: ">"), stroke: luma(160) + 0.8pt)
  }

  // Panel 0: original unit circle
  let ox0 = 0
  let circle-pts = pts0.map(p => { let (x,y) = p; (ox0 + x, y) })
  for i in range(0, circle-pts.len() - 1) {
    line(circle-pts.at(i), circle-pts.at(i+1), stroke: rgb("#3a86ff") + 1.5pt)
  }
  // right singular vectors (columns of V)
  line((ox0, 0), (ox0 + cos15, sin15), mark: (end: ">"), stroke: rgb("#ff6b6b") + 2pt)
  line((ox0, 0), (ox0 - sin15, cos15), mark: (end: ">"), stroke: rgb("#e76f51") + 2pt)
  content((ox0, -3.0), text(size: 8pt)[Input ($bold(x)$)])

  // Panel 1: after Vt — still unit circle but rotated axes label
  let ox1 = offset-x
  let pts1 = pts0.map(p => { let q = vt(p); (ox1 + q.at(0), q.at(1)) })
  for i in range(0, pts1.len() - 1) {
    line(pts1.at(i), pts1.at(i+1), stroke: rgb("#8338ec") + 1.5pt)
  }
  // Σ stretches along x-axis (singular value axes)
  line((ox1, 0), (ox1 + 1, 0), mark: (end: ">"), stroke: rgb("#ff6b6b") + 2pt)
  line((ox1, 0), (ox1, 1), mark: (end: ">"), stroke: rgb("#e76f51") + 2pt)
  content((ox1, -3.0), text(size: 8pt)[$V^top bold(x)$])

  // Panel 2: after Σ then U — ellipse
  let ox2 = 2 * offset-x
  let pts2 = pts0.map(p => {
    let q = sigma(vt(p))
    let r = u-rot(q)
    (ox2 + r.at(0), r.at(1))
  })
  for i in range(0, pts2.len() - 1) {
    line(pts2.at(i), pts2.at(i+1), stroke: rgb("#06d6a0") + 1.5pt)
  }
  // left singular vectors (major/minor axes of ellipse)
  line((ox2,0), (ox2 + 2.5*cos30, 2.5*sin30), mark:(end:">"), stroke: rgb("#ff6b6b") + 2pt)
  line((ox2,0), (ox2 - 0.8*sin30, 0.8*cos30), mark:(end:">"), stroke: rgb("#e76f51") + 2pt)
  content((ox2, -3.0), text(size: 8pt)[$A bold(x) = U Sigma V^top bold(x)$])

  // labels for singular values on the ellipse diagram
  content((ox2 + 2.5*cos30/2 + 0.2, 2.5*sin30/2 + 0.3),
    text(size: 8pt, fill: rgb("#ff6b6b"))[$sigma_1=2.5$])
  content((ox2 - 0.8*sin30/2 - 0.8, 0.8*cos30/2),
    text(size: 8pt, fill: rgb("#e76f51"))[$sigma_2=0.8$])

  // Arrows between panels
  content((offset-x / 2 - 0.3, 2.9), text(size: 8pt)[$xarrow(V^top)$])
  content((offset-x * 1.5 - 0.3, 2.9), text(size: 8pt)[$xarrow(U Sigma)$])
})
]

The unit circle is rotated by $V^top$, then scaled along the coordinate axes by $Sigma$, then rotated again by $U$, yielding an ellipse whose semi-axes have lengths $sigma_1 = 2.5$ and $sigma_2 = 0.8$.

// ============================================================
// 4. TRANSFORMATION MATRICES
// ============================================================
= Transformation Matrices

== Mathematical Background

In homogeneous coordinates, 2-D affine and projective maps are represented as $3 times 3$ matrices acting on $tilde(bold(x)) = vec(x, y, 1)$ (and $4 times 4$ in 3-D). This unified framework handles translation, rotation, scaling, shear, and perspective in a single matrix multiplication.

=== Translation

$ T(t_x, t_y) = mat(1, 0, t_x; 0, 1, t_y; 0, 0, 1) $

=== Scaling

$ S(s_x, s_y) = mat(s_x, 0, 0; 0, s_y, 0; 0, 0, 1) $

=== Rotation by angle $theta$

$ R(theta) = mat(cos theta, -sin theta, 0; sin theta, cos theta, 0; 0, 0, 1) $

=== Perspective (projective) with vanishing depth $d$

In 3-D homogeneous coordinates $(x, y, z, 1)$, a simple perspective projection onto the $z=0$ plane with focal length $f$ gives

$ P = mat(f, 0, 0, 0; 0, f, 0, 0; 0, 0, 1, 0) $

After multiplying, divide all coordinates by the $w$ component (perspective divide).

#note[
  Composing transforms is as simple as multiplying their matrices: $M = T R S$ applies scaling first, then rotation, then translation — reading right to left. Order matters because matrix multiplication is not commutative.
]

== Visualization: Effect of Each Transform on a Square

The unit square with corners $(0,0),(1,0),(1,1),(0,1)$ is shown after each transformation.

#align(center)[
#canvas({
  import draw: *
  let pi = calc.pi

  // Helper: draw polygon from point list
  let draw-poly(pts, fill-col, stroke-col) = {
    let n = pts.len()
    for i in range(n) {
      line(pts.at(i), pts.at(calc.rem(i+1, n)), stroke: stroke-col + 1.5pt)
    }
    // fill using a series of thin triangles from centroid
    // (CeTZ doesn't have native polygon fill, approximate with area shading)
  }

  // Original square corners
  let sq = ((0,0),(1,0),(1,1),(0,1))

  // ── Layout: 2×2 grid of panels ──
  let panels = (
    (label: "Original", pts: sq, col: rgb("#3a86ff"), ox: 0, oy: 0),
    (label: "Scale $S(2, 0.5)$",
     pts: sq.map(p => (2*p.at(0), 0.5*p.at(1))),
     col: rgb("#06d6a0"), ox: 4.5, oy: 0),
    (label: "Rotate $R(45°)$",
     pts: sq.map(p => {
       let t = 45 * pi / 180
       let x = p.at(0); let y = p.at(1)
       (x*calc.cos(t) - y*calc.sin(t), x*calc.sin(t) + y*calc.cos(t))
     }),
     col: rgb("#ff6b6b"), ox: 0, oy: -4.5),
    (label: "Translate $T(1, 0.5)$",
     pts: sq.map(p => (p.at(0) + 1, p.at(1) + 0.5)),
     col: rgb("#8338ec"), ox: 4.5, oy: -4.5),
  )

  for panel in panels {
    let ox = panel.ox
    let oy = panel.oy
    let pts = panel.pts

    // Grid
    for i in range(-1, 4) {
      line((ox + i, oy - 1.5), (ox + i, oy + 2.5),
        stroke: (paint: luma(225), thickness: 0.4pt))
    }
    for i in range(-2, 3) {
      line((ox - 0.5, oy + i), (ox + 3.5, oy + i),
        stroke: (paint: luma(225), thickness: 0.4pt))
    }
    // Axes
    line((ox - 0.5, oy), (ox + 3.5, oy), mark: (end:">"), stroke: luma(150)+0.8pt)
    line((ox, oy - 1.5), (ox, oy + 2.5), mark: (end:">"), stroke: luma(150)+0.8pt)

    // Original ghost
    let ghost = sq.map(p => (ox + p.at(0), oy + p.at(1)))
    for i in range(4) {
      line(ghost.at(i), ghost.at(calc.rem(i+1, 4)),
        stroke: (paint: luma(200), dash: "dashed", thickness: 1pt))
    }

    // Transformed shape
    let tpts = pts.map(p => (ox + p.at(0), oy + p.at(1)))
    for i in range(4) {
      line(tpts.at(i), tpts.at(calc.rem(i+1, 4)),
        stroke: panel.col + 2pt)
    }
    // Vertex dots
    for pt in tpts {
      circle(pt, radius: 0.07, fill: panel.col, stroke: none)
    }

    content((ox + 1.5, oy - 2.0),
      text(size: 8.5pt, fill: panel.col, weight: "bold")[#panel.label])
  }

  // Dashed ghost legend
  content((2.25, -8.9),
    text(size: 8pt, fill: luma(120))[Dashed = original unit square])
})
]

// ============================================================
// 5. QUATERNIONS
// ============================================================
= Quaternions

== Mathematical Background

Quaternions extend the complex numbers to a 4-dimensional normed division algebra, discovered by Hamilton in 1843. A quaternion is written as

$ bold(q) = w + x bold(i) + y bold(j) + z bold(k) = (w, bold(v)) $

where $w in RR$ is the *scalar part*, $bold(v) = (x,y,z) in RR^3$ is the *vector part*, and the basis elements satisfy

$ bold(i)^2 = bold(j)^2 = bold(k)^2 = bold(i) bold(j) bold(k) = -1 $

from which $bold(i)bold(j) = bold(k)$, $bold(j)bold(k) = bold(i)$, $bold(k)bold(i) = bold(j)$ (cyclic), and note $bold(j)bold(i) = -bold(k)$ (anticommutative).

The *conjugate* is $bold(q)^* = w - x bold(i) - y bold(j) - z bold(k)$, the *norm* is $|bold(q)| = sqrt(w^2 + x^2 + y^2 + z^2)$, and the *inverse* of a unit quaternion is its conjugate.

=== Representing 3-D Rotations

A unit quaternion ($|bold(q)| = 1$) encodes a rotation by angle $theta$ around unit axis $hat(bold(n))$:

$ bold(q) = cos(theta/2) + sin(theta/2)(n_x bold(i) + n_y bold(j) + n_z bold(k)) $

To rotate a 3-D point $bold(p) = (p_x, p_y, p_z)$, embed it as a *pure quaternion* $bold(p)^* = 0 + p_x bold(i) + p_y bold(j) + p_z bold(k)$, then

$ bold(p)'  = bold(q) bold(p)^* bold(q)^(-1) $

The result $bold(p)'$ is again a pure quaternion whose vector part is the rotated point.

=== Converting to Rotation Matrix

The corresponding $3 times 3$ rotation matrix is

$ R = mat(
  1-2(y^2+z^2), space 2(x y - w z), space 2(x z + w y);
  2(x y + w z), space 1-2(x^2+z^2), space 2(y z - w x);
  2(x z - w y), space 2(y z + w x), space 1-2(x^2+y^2)
) $

=== Advantages over Euler Angles

- *No gimbal lock* — Euler angles suffer a degree-of-freedom loss when two rotation axes align; quaternions do not.
- *Smooth interpolation* — SLERP (spherical linear interpolation) between unit quaternions is the standard in animation:

$ "SLERP"(bold(q)_1, bold(q)_2, t) = bold(q)_1 (bold(q)_1^(-1) bold(q)_2)^t $

== Visualization: Rotation Around the Z-Axis via Quaternion

We rotate the vector $bold(p) = (1, 0, 0)$ by $theta = 90°$ around $hat(bold(z)) = (0,0,1)$.

*Quaternion:* $bold(q) = cos 45° + sin 45° bold(k) = frac(sqrt(2), 2)(1 + bold(k))$

*Result:* $bold(p)' = (0, 1, 0)$ (as expected — 90° rotation in the $x$-$y$ plane).

#align(center)[
#canvas({
  import draw: *
  let pi = calc.pi

  // Draw the xy-plane circle to represent the rotation
  let sc = 1.5

  // Axes
  line((-2.2, 0), (2.2, 0), mark: (end: ">"), stroke: luma(150) + 1pt)
  line((0, -2.2), (0, 2.2), mark: (end: ">"), stroke: luma(150) + 1pt)
  content((2.3, 0), text(size: 9pt)[$x$])
  content((0, 2.35), text(size: 9pt)[$y$])

  // Unit circle
  for i in range(0, 360, step: 5) {
    let t0 = i * pi / 180
    let t1 = (i+5) * pi / 180
    line(
      (sc * calc.cos(t0), sc * calc.sin(t0)),
      (sc * calc.cos(t1), sc * calc.sin(t1)),
      stroke: (paint: luma(200), thickness: 0.8pt),
    )
  }

  // Arc from 0° to 90°
  for i in range(0, 18) {
    let t0 = i * 5 * pi / 180
    let t1 = (i+1) * 5 * pi / 180
    line(
      (sc * calc.cos(t0), sc * calc.sin(t0)),
      (sc * calc.cos(t1), sc * calc.sin(t1)),
      stroke: rgb("#3a86ff") + 2.5pt,
    )
  }

  // Original vector p = (1,0)
  line((0,0), (sc, 0), mark: (end: ">"), stroke: rgb("#ff6b6b") + 2.5pt)
  content((sc + 0.2, -0.25), text(size: 9pt, fill: rgb("#ff6b6b"))[$bold(p)=(1,0,0)$])

  // Rotated vector p' = (0,1)
  line((0,0), (0, sc), mark: (end: ">"), stroke: rgb("#06d6a0") + 2.5pt)
  content((0.15, sc + 0.25), text(size: 9pt, fill: rgb("#06d6a0"))[$bold(p)'=(0,1,0)$])

  // Angle label
  content((0.55, 0.45), text(size: 9pt)[$90°$])

  // Quaternion
  content((0, -2.6),
    text(size: 8.5pt)[
      $bold(q) = frac(sqrt(2),2)(1 + bold(k))$, $quad$ axis $= hat(z)$, $quad$ $theta = 90°$
    ]
  )

  // z-axis arrow (into screen)
  circle((3.5, 0), radius: 0.25, stroke: luma(100) + 1pt, fill: none)
  circle((3.5, 0), radius: 0.06, fill: luma(100), stroke: none)
  content((3.5, 0.5), text(size: 8pt)[$hat(z)$ (out)]  )
})
]

The blue arc shows the $90°$ rotation path in the $x$-$y$ plane. The $z$-axis (shown as a dot, pointing out of the page) is the rotation axis encoded in the quaternion's vector part.

// ============================================================
// 6. PROJECTION MATRICES
// ============================================================
= Projection Matrices

== Mathematical Background

A *projection matrix* $P$ satisfies the idempotency condition

$ P^2 = P $

This captures the idea that projecting something that is already projected leaves it unchanged.

=== Orthogonal Projection onto a Subspace

The orthogonal projection onto the column space of a full-column-rank matrix $A in RR^(m times n)$ is

$ P = A (A^top A)^(-1) A^top $

*Key properties:*
- $P^2 = P$ (idempotent)
- $P^top = P$ (symmetric — distinguishes orthogonal from oblique projection)
- $"rank"(P) = n$ (dimension of the target subspace)
- The complementary projector $I - P$ projects onto the orthogonal complement (the null space of $A^top$)

=== Projection onto a Line

For a unit vector $hat(bold(u))$, the projector is simply

$ P = hat(bold(u)) hat(bold(u))^top $

The component of $bold(b)$ along $hat(bold(u))$ is $P bold(b) = (hat(bold(u}) dot bold(b)) hat(bold(u))$.

=== Least Squares via Projection

If $A bold(x) = bold(b)$ has no solution, the least-squares solution $hat(bold(x))$ minimises $||A bold(x) - bold(b)||_2$. The solution is

$ hat(bold(x)) = (A^top A)^(-1) A^top bold(b) $

and the projection $P bold(b) = A hat(bold(x))$ is the closest point in the column space of $A$ to $bold(b)$.

== Visualization: Orthogonal Projection onto a Line

We project $bold(b) = (3, 2)$ onto the line spanned by $bold(a) = (2, 1)$.

*Unit vector:* $hat(bold(a)) = frac(1, sqrt(5))(2, 1)$

*Projection matrix:* $P = frac(1, 5) mat(4, 2; 2, 1)$

*Result:* $P bold(b) = frac(1,5)(4 dot 3 + 2 dot 2, quad 2 dot 3 + 1 dot 2) = frac(1,5)(16, 8) = (3.2, 1.6)$

*Error vector:* $bold(e) = bold(b) - P bold(b) = (-0.2, 0.4)$ — note $bold(e) perp bold(a)$.

#align(center)[
#canvas({
  import draw: *
  let sc = 0.85

  // Grid
  for i in range(0, 5) {
    line((i*sc, -0.5*sc), (i*sc, 3.5*sc), stroke: (paint: luma(225), thickness: 0.4pt))
    line((-0.5*sc, i*sc), (4.5*sc, i*sc), stroke: (paint: luma(225), thickness: 0.4pt))
  }

  // Axes
  line((-0.5*sc, 0), (4.5*sc, 0), mark: (end: ">"), stroke: luma(140) + 1pt)
  line((0, -0.5*sc), (0, 3.5*sc), mark: (end: ">"), stroke: luma(140) + 1pt)
  content((4.6*sc, 0), text(size: 9pt)[$x$])
  content((0, 3.6*sc), text(size: 9pt)[$y$])

  // Line span of a = (2,1) extended
  line((-0.2*sc, -0.1*sc), (4.2*sc, 2.1*sc),
    stroke: (paint: luma(180), dash: "dashed", thickness: 1pt))
  content((4.3*sc, 2.2*sc), text(size: 8.5pt, fill: luma(100))[span($bold(a)$)])

  // Vector a = (2,1)
  line((0,0), (2*sc, 1*sc), mark: (end: ">"), stroke: rgb("#3a86ff") + 2pt)
  content((2*sc + 0.15, 1*sc + 0.2), text(size: 9pt, fill: rgb("#3a86ff"))[$bold(a)$])

  // Vector b = (3,2)
  line((0,0), (3*sc, 2*sc), mark: (end: ">"), stroke: rgb("#ff6b6b") + 2pt)
  content((3*sc + 0.1, 2*sc + 0.2), text(size: 9pt, fill: rgb("#ff6b6b"))[$bold(b)$])

  // Projection Pb = (3.2, 1.6)
  line((0,0), (3.2*sc, 1.6*sc), mark: (end: ">"), stroke: rgb("#06d6a0") + 2.5pt)
  content((3.2*sc + 0.15, 1.6*sc - 0.3), text(size: 9pt, fill: rgb("#06d6a0"))[$P bold(b)$])

  // Error vector e = b - Pb = (-0.2, 0.4) from Pb to b
  line((3.2*sc, 1.6*sc), (3*sc, 2*sc), mark: (end: ">"),
    stroke: rgb("#e76f51") + 2pt)
  content((3.25*sc, 2.0*sc), text(size: 9pt, fill: rgb("#e76f51"))[$bold(e)$])

  // Right angle mark at Pb
  let px = 3.2*sc; let py = 1.6*sc
  // perpendicular direction to a=(2,1) is (-1,2)/sqrt(5)
  let d = 0.18
  let sq1 = (px + d*(-1)/calc.sqrt(5), py + d*2/calc.sqrt(5))
  let sq2 = (px + d*(2)/calc.sqrt(5) + d*(-1)/calc.sqrt(5),
             py + d*(1)/calc.sqrt(5) + d*(2)/calc.sqrt(5))
  let sq3 = (px + d*(2)/calc.sqrt(5), py + d*(1)/calc.sqrt(5))
  line((px, py), sq1, stroke: luma(100) + 0.8pt)
  line(sq1, sq2, stroke: luma(100) + 0.8pt)
  line(sq2, sq3, stroke: luma(100) + 0.8pt)

  // Tick on axes
  for x in (1, 2, 3, 4) {
    line((x*sc, -0.05), (x*sc, 0.05), stroke: luma(140))
    content((x*sc, -0.22), text(size: 7pt)[#x])
  }
  for y in (1, 2, 3) {
    line((-0.05, y*sc), (0.05, y*sc), stroke: luma(140))
    content((-0.22, y*sc), text(size: 7pt)[#y])
  }

  content((2.25*sc, -0.9),
    text(size: 8.5pt)[
      #text(fill:rgb("#3a86ff"))[$bold(a)=(2,1)$] $quad$
      #text(fill:rgb("#ff6b6b"))[$bold(b)=(3,2)$] $quad$
      #text(fill:rgb("#06d6a0"))[$P bold(b)=(3.2, 1.6)$] $quad$
      #text(fill:rgb("#e76f51"))[$bold(e) perp bold(a)$]
    ]
  )
})
]

The right-angle mark at $P bold(b)$ confirms that the error $bold(e)$ is *perpendicular* to the subspace — the defining property of orthogonal projection.

== Summary Table

#table(
  columns: (auto, 1fr, 1fr),
  fill: (col, row) => if row == 0 { rgb("#1a1a2e") } else if calc.odd(row) { rgb("#f7f9fc") } else { white },
  stroke: luma(200),
  inset: 8pt,
  align: (left, left, left),
  [#text(fill:white, weight:"bold")[Topic]],
  [#text(fill:white, weight:"bold")[Key Formula]],
  [#text(fill:white, weight:"bold")[Key Property]],
  [Matrix Multiplication], [$C_(i j) = sum_r A_(i r) B_(r j)$], [Associative, not commutative],
  [Eigenvalues], [$A bold(v) = lambda bold(v)$], [$det(A - lambda I) = 0$],
  [SVD], [$A = U Sigma V^top$], [Best low-rank approx.],
  [Rotation Matrix], [$R(theta) = mat(cos theta, -sin theta; sin theta, cos theta)$], [Orthogonal, $det=1$],
  [Quaternion], [$bold(q) = cos(theta/2) + sin(theta/2) hat(bold(n))$], [No gimbal lock],
  [Projection], [$P = A(A^top A)^(-1) A^top$], [$P^2 = P$, $P^top = P$],
)

#v(1em)
#align(center)[
  #text(size: 9pt, fill: luma(140))[
    _Generated with Typst · CeTZ 0.4.2 · All diagrams computed analytically_
  ]
]

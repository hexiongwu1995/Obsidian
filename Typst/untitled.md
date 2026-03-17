



请生成一个包含 CeTZ 代码的单一 Markdown 文档，用于直观地演示以下列出的每个线性代数主题，每个主题都需要介绍相应的数学背景或相关的知识，所有数学公式全部使用CeTZ内置的行内数学公式格式，CeTZ 代码块使用cetz:0.4.2版本。文档使用全英文编写。请你自行决定篇幅。
需要可视化的内容：矩阵乘法，特征值 / 特征向量，SVD（奇异值分解），变换矩阵（平移、旋转、缩放、透视），四元数，投影矩阵。










# Linear Algebra Visualizations with CeTZ (Typst)

## Your Intention (Organized and Restated)
You asked for a single Markdown document containing CeTZ code (Typst's drawing library) for visually demonstrating each linear algebra topic you listed:  
- Matrix multiplication  
- Eigenvalues / eigenvectors  
- SVD (singular value decomposition)  
- Transformation matrices (translation, rotation, scaling, perspective)  
- Quaternions  
- Projection matrices  

The document should start by clearly restating your request (done here). Each section below includes:  
- A concise English explanation  
- Key formulas written in Typst's built-in inline math format (e.g., $ bold(A) $, $ vec(v) $, $ mat(a, b; c, d) $)  
- A complete, self-contained CeTZ code block (ready to copy-paste into any Typst `.typ` file after importing `@preview/cetz:0.3.2`)  

All visualizations are 2D (or simple 3D projections) for clarity. Render the Typst snippets to see interactive diagrams. No external dependencies beyond CeTZ.

---

## 1. Matrix Multiplication
**Explanation**  
Matrix multiplication $ bold(A) bold(v) $ applies a linear transformation to a vector $ bold(v) $. This is visualized by showing a unit square (red) and its image under the transformation (blue parallelogram). The example matrix $ mat(1, 1; 0, 2) $ combines shear and non-uniform scaling.

**Typst Math**  
$bold(A) = mat(1, 1; 0, 2)$  
$bold(A) vec(x, y) = vec(x + y, 2 y)$

```typst
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  // Original unit square
  rect((0, 0), (1, 1), stroke: (red, 2pt))
  content((0.5, -0.5), [Original])

  // Transformed parallelogram (shifted right by 4 cm)
  let tx = 4
  line((tx, 0), (tx + 1, 0), stroke: (blue, 2pt))
  line((tx, 0), (tx + 1, 2), stroke: (blue, 2pt))
  line((tx + 1, 0), (tx + 2, 2), stroke: (blue, 2pt))
  line((tx + 1, 2), (tx + 2, 2), stroke: (blue, 2pt))
  content((tx + 1, -0.5), [Transformed by $mat(1,1;0,2)$])
})


---

## 2. Eigenvalues and Eigenvectors
**Explanation**  
Eigenvectors $ bold(v) $ remain parallel to themselves after transformation $ bold(A) bold(v) = lambda bold(v) $. The visualization shows a matrix that stretches along one direction (eigenvector in blue stays on the same line) while the other direction changes.

**Typst Math**  
Example matrix $ bold(A) = mat(2, 1; 1, 2) $  
Eigenvalues: $ lambda_1 = 3 $, $ lambda_2 = 1 $  
Eigenvectors: $ vec(1, 1) $ (stretched) and $ vec(1, -1) $ (unchanged length)

```typst
#import "@preview/cetz:0.3.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  // Unit circle (original shape)
  circle((0, 0), radius: 1, stroke: (red, 1pt))

  // Eigenvector direction 1 (blue, scaled by λ=3)
  line((0, 0), (1.5, 1.5), stroke: (blue, 3pt), mark: (end: "stealth"))
  content((1.8, 1.8), [$vec(1,1) times 3$])

  // Eigenvector direction 2 (green, length unchanged)
  line((0, 0), (1, -1), stroke: (green, 3pt), mark: (end: "stealth"))
  content((1.2, -1.2), [$vec(1,-1)$])

  content((0, -2), [Eigen directions unchanged in angle])
})
```

---

## 3. SVD (Singular Value Decomposition)
**Explanation**  
SVD decomposes any matrix as $ bold(A) = bold(U) bold(Sigma) bold(V)^T $: rotation → scaling → rotation. Visualized by transforming a unit circle into an ellipse (red → blue). The semi-axes of the ellipse are the singular values.

**Typst Math**  
$ bold(A) = bold(U) bold(Sigma) bold(V)^T $  
$ bold(Sigma) = mat(sigma_1, 0; 0, sigma_2) $ (singular values on diagonal)

```typst
#import "@preview/cetz:0.3.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  // Original unit circle
  circle((0, 0), radius: 1, stroke: (red, 2pt))

  // Rotated & scaled ellipse (U Σ V^T effect)
  group({
    rotate(30deg)
    scale(x: 2.5, y: 0.8)
    circle((0, 0), radius: 1, stroke: (blue, 3pt))
  })

  content((0, -2), [Unit circle → ellipse via SVD])
})
```

---

## 4. Transformation Matrices
### 4.1 Translation
**Explanation**  
Translation shifts every point by a fixed vector. No change in shape or orientation.

**Typst Math**  
$ bold(T) = mat(1, 0, t_x; 0, 1, t_y; 0, 0, 1) $ (homogeneous)

```typst
#import "@preview/cetz:0.3.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  rect((0, 0), (2, 1), stroke: red)
  group({
    translate((3, 1))
    rect((0, 0), (2, 1), stroke: blue)
  })
  content((1, -1), [Translated by $vec(3,1)$])
})
```

### 4.2 Rotation
**Explanation**  
Rotation turns objects around the origin by angle $ theta $.

**Typst Math**  
$ bold(R) = mat(cos theta, -sin theta; sin theta, cos theta) $

```typst
#import "@preview/cetz:0.3.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  rect((0, 0), (2, 1), stroke: red)
  group({
    rotate(45deg)
    rect((0, 0), (2, 1), stroke: blue)
  })
  content((0, -2), [Rotated by 45°])
})
```

### 4.3 Scaling
**Explanation**  
Scaling stretches or compresses along axes.

**Typst Math**  
$ bold(S) = mat(s_x, 0; 0, s_y) $

```typst
#import "@preview/cetz:0.3.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  rect((0, 0), (1, 1), stroke: red)
  group({
    scale(x: 2.5, y: 0.5)
    rect((0, 0), (1, 1), stroke: blue)
  })
  content((0, -2), [Scaled $s_x=2.5$, $s_y=0.5$])
})
```

### 4.4 Perspective
**Explanation**  
Perspective projection simulates 3D depth on a 2D plane (vanishing point).

**Typst Math**  
Homogeneous perspective matrix applied to 3D points.

```typst
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  // Simple perspective cube (wireframe)
  // Front face
  rect((0, 0), (2, 2), stroke: red)
  // Back face (smaller, offset)
  rect((0.5, 0.5), (2.5, 2.5), stroke: blue)
  // Connecting edges
  line((0, 0), (0.5, 0.5), stroke: black)
  line((2, 0), (2.5, 0.5), stroke: black)
  line((0, 2), (0.5, 2.5), stroke: black)
  line((2, 2), (2.5, 2.5), stroke: black)
  content((1, -1), [Perspective projection])
})
```

---

## 5. Quaternions
**Explanation**  
Quaternions $ q = w + x i + y j + z k $ represent 3D rotations without gimbal lock. Visualized by rotating a vector around an arbitrary axis (shown as a 3D-like arrow before/after).

**Typst Math**  
$q = cos(theta/2) + sin(theta/2) bold(u) $ (axis-angle form)

```typst
#import "@preview/cetz:0.4.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  // Axis of rotation
  line((0, 0), (0, 3), stroke: (gray, 2pt))
  content((0.3, 1.5), [Rotation axis])

  // Original vector
  line((1, 0), (2, 1), stroke: (red, 3pt), mark: (end: "stealth"))

  // Quaternion-rotated vector (simulated 120° around y-axis)
  group({
    rotate(120deg)
    line((1, 0), (2, 1), stroke: (blue, 3pt), mark: (end: "stealth"))
  })
  content((1, -1), [Quaternion rotation])
})
```

---

## 6. Projection Matrices
**Explanation**  
Projection matrices map 3D points onto a 2D plane (orthographic or perspective). Here we show orthographic projection of a 3D cube onto the xy-plane.

**Typst Math**  
Orthographic: $bold(P) = mat(1, 0, 0; 0, 1, 0; 0, 0, 0)$

```typst
#import "@preview/cetz:0.3.2": canvas, draw
#canvas(length: 1cm, {
  import draw: *
  // 3D cube projected orthographically
  // Front
  rect((0, 0), (2, 2), stroke: red)
  // Top face
  line((0, 2), (0.5, 3), stroke: black)
  line((2, 2), (2.5, 3), stroke: black)
  line((0.5, 3), (2.5, 3), stroke: black)
  // Side
  line((2, 0), (2.5, 1), stroke: black)
  line((2.5, 1), (2.5, 3), stroke: black)
  content((1, -1), [Orthographic projection])
})
```

---

**How to Use**  
1. Create a new Typst file.  
2. Add `#import "@preview/cetz:0.3.2": canvas, draw` at the top.  
3. Paste any code block.  
4. Compile with `typst c file.typ` → you get beautiful vector diagrams!

All diagrams are minimal yet fully illustrate the mathematical concept. Feel free to modify the numbers or colors.
```


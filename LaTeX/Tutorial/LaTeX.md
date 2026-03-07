---
math-engine: mathjax
---


## Obsidian LaTeX 语法教程

本教程涵盖了在 Obsidian 中常用的 LaTeX 语法，所有内容均可在 Obsidian 中正常渲染。

### 1. 基本语法

1.1 行内公式
使用单个美元符号包裹公式：
`$公式$` 例如：$E = mc^2$

1.2 独立公式块
使用两个美元符号创建独立公式：
```
$$公式$$
```
1.3 带编号的公式块
使用 `\begin{equation}` 和 `\end{equation}`：
```
\begin{equation}公式\end{equation}
```

### 2. 常用数学符号

2.1 希腊字母
```
$\alpha, \beta, \gamma, \Gamma, \Delta, \pi, \Pi, \omega, \Omega$
```
渲染效果：$\alpha, \beta, \gamma, \Gamma, \Delta, \pi, \Pi, \omega, \Omega$

2.2 上下标
```
$x^2, x_{n}, x^{y}_{z}, e^{i\pi} + 1 = 0$
```
渲染效果：$x^2, x_{n}, x^{y}_{z}, e^{i\pi} + 1 = 0$

2.3 分数
```
$\frac{a}{b}, \frac{1}{1+\frac{1}{x}}$
```
渲染效果：$\frac{a}{b}, \frac{1}{1+\frac{1}{x}}$

2.4 根号
```
$\sqrt{x}, \sqrt[n]{x}, \sqrt{\frac{x}{y}}$
```
渲染效果：$\sqrt{x}, \sqrt[n]{x}, \sqrt{\frac{x}{y}}$

2.5 求和、积分、极限
```
$\sum_{i=1}^{n} i, \int_{a}^{b} f(x)dx, \lim_{x \to \infty} f(x)$
```
渲染效果：$\sum_{i=1}^{n} i, \int_{a}^{b} f(x)dx, \lim_{x \to \infty} f(x)$

2.6 矩阵
```
$$
\begin{matrix}
a & b \\
c & d 
\end{matrix}
\quad

\begin{pmatrix}
a & b \\
c & d
\end{pmatrix}
\quad

\begin{bmatrix}
1 & 2 \\
3 & 4
\end{bmatrix}
$$

\begin{vmatrix}
1 & 2 \\
3 & 4
\end{vmatrix}
$$

```
$$ \begin{matrix}
a & b \\
c & d 
\end{matrix}
\quad
\begin{pmatrix}
a & b \\
c & d
\end{pmatrix}
\quad
\begin{bmatrix}
1 & 2 \\
3 & 4
\end{bmatrix} 
\quad
\begin{vmatrix}
1 & 2 \\
3 & 4
\end{vmatrix}
$$

### 3. 常用数学运算符

3.1 基本运算符
```
$+, -, \times, \cdot, \div, \pm, \mp$
```
渲染效果：$+, -, \times, \cdot, \div, \pm, \mp$

3.2 关系运算符
```
$=, \neq, <, >, \leq, \geq, \approx, \sim, \equiv$ \perp (Perpendicular)
```
渲染效果：$=, \neq, <, >, \leq, \geq, \approx, \sim, \equiv, \perp$

3.3 集合符号
```
$\in, \notin, \subset, \subseteq, \cup, \cap, \emptyset, \forall, \exists$
```
渲染效果：$\in, \notin, \subset, \subseteq, \cup, \cap, \emptyset, \forall, \exists$

### 4. 常用函数名

4.1 三角函数
```
$\sin x, \cos x, \tan x, \cot x, \sec x, \csc x$
```
渲染效果：$\sin x, \cos x, \tan x, \cot x, \sec x, \csc x$

4.2 对数函数
```
$\log x, \ln x, \lg x$
```
渲染效果：$\log x, \ln x, \lg x$

4.3 其他函数
```
$\max, \min, \sup, \inf, \arg, \det, \dim, \exp$
```
渲染效果：$\max, \min, \sup, \inf, \arg, \det, \dim, \exp$

### 5. 括号与定界符

5.1 自动调整大小的括号
```
$\left( \frac{a}{b} \right), \left[ \frac{x}{y} \right], \left\{ \frac{m}{n} \right\}$
```
渲染效果：$\left( \frac{a}{b} \right), \left[ \frac{x}{y} \right], \left\{ \frac{m}{n} \right\}$

5.2 其他括号
```
$\langle x \rangle, \lfloor x \rfloor, \lceil x \rceil, |x|, \|x\|$
```
渲染效果：$\langle x \rangle, \lfloor x \rfloor, \lceil x \rceil, |x|, \|x\|$

### 6. 箭头符号

6.1 常用箭头
```
$\to, \rightarrow, \leftarrow, \Rightarrow, \Leftarrow, \leftrightarrow, \Leftrightarrow$
```
渲染效果：$\to, \rightarrow, \leftarrow, \Rightarrow, \Leftarrow, \leftrightarrow, \Leftrightarrow$

6.2 其他箭头
```
$\uparrow, \downarrow, \updownarrow, \mapsto, \longrightarrow$
```
渲染效果：$\uparrow, \downarrow, \updownarrow, \mapsto, \longrightarrow$

### 7. 排版与对齐

7.1 多行公式对齐
使用 `aligned` 环境：
```
$$
\begin{aligned}
f(x) &= (x+1)^2 \\
&= x^2 + 2x + 1
\end{aligned}
$$
```
$$
\begin{aligned}
f(x) &= (x+1)^2 \\
&= x^2 + 2x + 1
\end{aligned}
$$

7.2 分段函数
使用 `cases` 环境：
```
$$
f(x) = 
\begin{cases}
1 & \text{if } x > 0 \\
0 & \text{if } x = 0 \\
-1 & \text{if } x < 0
\end{cases}
$$
```
$$f(x) = 
\begin{cases}
1 & \text{if } x > 0 \\
0 & \text{if } x = 0 \\
-1 & \text{if } x < 0
\end{cases}
$$


### 8. 字体与样式

8.1 数学字体
```
$\mathrm{ABC}, \mathbf{ABC}, \mathit{ABC}, \mathcal{ABC}, \mathbb{ABC}$
```
渲染效果：$\mathrm{ABC}, \mathbf{ABC}, \mathit{ABC}, \mathcal{ABC}, \mathbb{ABC}$

8.2 大小调整
```
$\displaystyle\sum_{i=1}^n, \textstyle\sum_{i=1}^n, \scriptstyle\sum, \scriptscriptstyle\sum$
```
$\displaystyle\sum_{i=1}^n, \textstyle\sum_{i=1}^n, \scriptstyle\sum, \scriptscriptstyle\sum$

### 9. 特殊符号

9.1 微积分符号
```
$\nabla, \partial, \infty, \prime, \ddot{x}, \dot{x}$
```
渲染效果：$\nabla, \partial, \infty, \prime, \ddot{x}, \dot{x}$

9.2 其他常用符号
```
$\angle, \degree, \circ, \ast, \star, \bullet, \dagger, \ddagger$
```
渲染效果：$\angle, \degree, \circ, \ast, \star, \bullet, \dagger, \ddagger$

### 10. 实用示例

10.1 二次方程求根公式
```
$$x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$
```

10.2 欧拉公式
```
$$
e^{i\theta} = \cos\theta + i\sin\theta
$$
```
$$e^{i\theta} = \cos\theta + i\sin\theta$$
10.3 高斯积分
```
$$\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}$$
```
$$\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}$$

### 11. 使用提示

空格处理：LaTeX 忽略多个空格，使用 `\,`、`\;`、`\quad`、`\qquad` 添加空格

```
$a\,b\;c\quad d\qquad e$
```
   $a\,b\;c\quad d\qquad e$

转义字符：在 Obsidian 中，如果需要在文本中显示美元符号，使用反斜杠转义：`\$`

颜色支持：Obsidian 可能需要安装插件才能支持彩色公式，如：
   ```
   $\color{red}{红色文字}$
   ```
   $\color{red}{红色文字}$
   

常见错误：
 - 确保括号匹配
 - 反斜杠后不要有多余空格
 - 确保公式环境正确闭合
 - 遇到问题时，使用 `Ctrl+/` 切换源码视图检查语法


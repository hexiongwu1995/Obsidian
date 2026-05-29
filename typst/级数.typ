#set page(
  paper: "a4",
  flipped: false,
  margin: 1.5cm,
  numbering: "1/1",
  number-align: center,
  fill: rgb("#ffffff13"),
)

#set document(
  title: [级数],
  author: ("何雄武",),
  date: datetime(year: 2026, month: 5, day: 6),
)

#show title: it => {
  set align(center)
  set text(size: 18pt, weight: "bold", fill: rgb("#0066fff0"))
  it
  v(1em)
}

#set par(spacing: 2em, leading: 1em, justify: true)

#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  counter(math.equation).update(0)
  v(1em)
  set text(size: 15pt, weight: "bold", fill: rgb("0066fff0"))
  it
  v(1em)
}

#show heading.where(level: 2): it => {
  set text(size: 10pt, weight: "bold", fill: rgb("0066fff0"))
  it
  v(0.5em)
}

#set text(
  lang: "zh",
  font: ("Cambria Math", "KaiTi", "DengXian", "New Computer Modern Sans", "Noto Sans Mono CJK SC", "SimSun"),
  size: 10pt,
)

#show table: it => {
  set align(center)
  it
}

#set math.equation(numbering: n => numbering("(1.1)", counter(heading).get().first(), n), supplement: [Eq.])

#show math.equation: set block(breakable: true)

#import "@preview/lilaq:0.6.0" as lq
#import "@preview/cetz:0.5.0"
#import "@preview/gentle-clues:1.3.1": *
#import "@preview/physica:0.9.8": *
#import "@preview/numty:0.1.0" as nt

#show: gentle-clues.with(
  breakable: true,
)

#title()


= 什么是级数

级数（Series）是数学分析中的一个核心概念，指将无穷多个数按照一定顺序相加所得到的表达式。简而言之，给定一个数列 ${a_1, a_2, a_3, dots.c, a_n, dots.c}$，将其各项用加号连接起来，便得到了一个级数：

$ sum_(n=1)^oo a_n = a_1 + a_2 + a_3 + dots.c + a_n + dots.c $

其中 $a_n$ 称为级数的通项或一般项。级数的本质是"无穷求和"，但无穷多项相加的含义并不像有限项求和那样直观，因此需要借助极限工具来精确刻画。

对于级数 $sum_(n=1)^oo a_n$，定义其前 $n$ 项的和为部分和（Partial Sum）：

$ S_n = sum_(k=1)^n a_k = a_1 + a_2 + a_3 + dots.c + a_n $

这样，每一个级数都对应着一个部分和数列 ${S_1, S_2, S_3, dots.c, S_n, dots.c}$。如果当 $n$ 趋向于无穷大时，部分和 $S_n$ 趋近于某个确定的有限值 $S$，即 $lim_(n->oo) S_n = S$，则称该级数收敛（Convergent），并称 $S$ 为级数的和；反之，如果 $S_n$ 不趋近于任何有限值，则称级数发散（Divergent）。

级数理论在数学和物理学中有着广泛的应用。在数学中，许多重要的常数和函数都可以表示为级数的形式，例如圆周率 $pi$、自然对数的底数 $e$ 以及三角函数等。在物理学中，级数被用来求解微分方程、分析振动现象以及处理量子力学中的微扰问题。著名的傅里叶级数更是将周期函数分解为简单正弦波的叠加，成为信号处理和热传导等领域的基石。

根据通项的形式不同，级数可以分为多种类型：常数项级数、函数项级数、幂级数、傅里叶级数等。其中，常数项级数是研究各类级数的基础，而调和级数则是最具代表性的常数项级数之一。


= 调和级数的定义

调和级数（Harmonic Series）是数学中最著名的无穷级数之一，其名称来源于音乐中的泛音（Harmonics）概念。在弦乐器中，一根弦振动时不仅发出基音，还会同时发出频率为基音整数倍的泛音，这些泛音的波长与弦长之比恰好构成了调和级数中各项的倒数。调和级数的数学定义是所有正整数倒数的无穷和：

$ H = sum_(n=1)^oo 1/n = 1 + 1/2 + 1/3 + 1/4 + dots.c $

其中前 $n$ 项的部分和称为调和数（Harmonic Number），通常记作 $H_n$：

$ H_n = sum_(k=1)^n 1/k = 1 + 1/2 + 1/3 + dots.c + 1/n $

= 调和级数的发散性

调和级数最引人注目的性质在于：尽管其通项 $a_n = 1/n$ 随着 $n$ 的增大而趋向于零，但整个级数却是发散的。这意味着，只要累加足够多的项，部分和 $H_n$ 可以超过任意大的数。这一看似反直觉的结论最早由法国学者尼克尔·奥雷姆（Nicole Oresme）在约1350年给出了严格证明。

奥雷姆的证明思路极为巧妙：他将调和级数的项按如下方式分组：

$ H = 1 + 1/2 + (1/3 + 1/4) + (1/5 + 1/6 + 1/7 + 1/8) + dots.c $

每一组括号内的项数逐组翻倍，而每一组的总和都大于 $1/2$。因此调和级数的部分和大于无穷多个 $1/2$ 之和，从而趋于无穷。

另一个经典的证明方法是利用积分判别法。由于函数 $f(x) = 1/x$ 在区间 $[1, oo)$ 上单调递减且恒为正，我们可以将级数与反常积分建立联系：

$ integral_1^oo 1/x dif x = lim_(b->oo) ln b = oo $

由于级数的部分和大于该积分，因此调和级数发散。

为了更直观地理解这一比较过程，我们可以在几何上考察函数 $f(x) = 1/x$ 的曲线与代表级数各项的矩形之间的关系。考虑区间 $[k, k+1]$（其中 $k$ 为自然数），由于 $f(x)$ 在该区间上单调递减，因此在子区间 $[k, k+1]$ 上恒有 $1/k >= 1/x$。由此可得，宽度为 $1$、高度为 $1/k$ 的矩形面积 $1/k$（即级数的第 $k$ 项）必然大于曲线下方从 $k$ 到 $k+1$ 的曲边梯形面积——也就是定积分 $integral_k^(k+1) 1/x dif x$。对所有 $k$ 从 $1$ 到 $n$ 求和，便得到如下不等式：

$ H_n = sum_(k=1)^n 1/k > sum_(k=1)^n integral_k^(k+1) 1/x dif x = integral_1^(n+1) 1/x dif x = ln (n+1) $

当 $n -> oo$ 时，$ln(n+1)$ 趋于无穷大，因而 $H_n$ 也必趋于无穷大，这就从积分比较的角度严格证明了调和级数的发散性。这条不等式还给出了调和数的一个下界估计：$H_n > ln(n+1)$，清晰地揭示了调和数至少以对数速度增长的事实。

#show lq.selector(lq.legend): set grid(row-gutter: 6pt)

#figure(
  lq.diagram(
    title: [],
    xlabel: [$x$],
    ylabel: [$y$],
    width: 80%,
    height: 6cm,
    xlim: (0, 12),
    ylim: (0, 1.2),
    xaxis: (
      ticks: range(1, 12),
    ),
    yaxis: (
      ticks: lq.linspace(0, 1, num: 3),
    ),
    grid: (stroke: luma(95%), stroke-sub: luma(98%) + 0.25pt),
    legend: (stroke: none),
    lq.plot(
      lq.linspace(0.9, 11.5, num: 100),
      x => 1 / x,
      stroke: 1pt + rgb("#0066ff"),
      label: [$f(x) = 1/x$],
      mark: none,
    ),
    lq.fill-between(
      lq.linspace(1, 11, num: 100),
      x => 1 / x,
      fill: rgb("#aaccff"),
      stroke: none,
      label: [曲线下方面积 $integral_1^(n+1) 1/x dif x$],
    ),
    lq.bar(
      range(1, 11),
      x => 1 / x,
      fill: rgb("#ffccaa2b"),
      stroke: 0.8pt + rgb("#ff6600"),
      align: left,
      width: 1,
      label: [矩形面积 $1/k$（调和级数各项）],
    ),
  ),
  caption: [积分判别法示意],
) <fig:integral-test>

在 @fig:integral-test 中，蓝色曲线为 $f(x)=1/x$，橙色矩形代表调和级数前 10 项（高度 $1/k$、宽度 $1$，左端位于 $x = k$ 处）。由于 $f(x)$ 单调递减，在区间 $[k, k+1]$ 上恒有 $1/k >= 1/x$，因此每个矩形面积均大于其下方曲边梯形的面积，求和即得 $H_n > integral_1^(n+1) 1/x dif x = ln(n+1)$，从而推出调和级数发散。


= 调和数的渐近行为

虽然调和级数是发散的，但它的发散速度非常缓慢。前 $n$ 项的和 $H_n$ 大约增长得像 $ln n$ 一样快。精确地，欧拉于1735年发现：

$ gamma = lim_(n->oo) (H_n - ln n) approx 0.5772156649 dots.c $

这个常数 $gamma$ 被称为欧拉—马歇罗尼常数（Euler-Mascheroni Constant），它是数学中最重要的常数之一。至今人们仍不知道 $gamma$ 是有理数还是无理数，这仍是数学界的一个未解之谜。

#let n = range(1, 101)
#let ln_n = n.map(it => calc.ln(it))
#let H_n = {
  let arr = ()
  let s = 0.0
  for k in range(1, 101) {
    s += 1.0 / k
    arr.push(s)
  }
  arr
}
#let diff = H_n.zip(ln_n).map(((a, b)) => a - b)

#show lq.selector(lq.legend): set grid(row-gutter: 2pt)

#figure(
  lq.diagram(
    title: [],
    xlabel: [$n$],
    ylabel: [],
    width: 80%,
    height: 7cm,
    xlim: (0, 105),
    ylim: (0, 6),
    xaxis: (
      ticks: range(0, 110, step: 10),
    ),
    yaxis: (
      ticks: lq.linspace(1, 5, num: 5),
    ),
    grid: (stroke: luma(95%), stroke-sub: luma(98%) + 0.25pt),
    legend: (stroke: none, position: left + top),
    lq.plot(
      n,
      H_n,
      stroke: 1.2pt + rgb("#ff6600"),
      mark: none,
      step: end,
      label: [$H_n$],
    ),
    lq.plot(
      n,
      ln_n,
      stroke: 1.2pt + rgb("#0066ff"),
      mark: none,
      label: [$ln n$],
    ),
    lq.plot(
      n,
      diff,
      stroke: 1pt + rgb("#aeaeae"),
      mark: none,
      label: [$H_n - ln n$],
      step: end,
    ),
    lq.plot(
      (1, 100),
      (0.5772156649, 0.5772156649),
      mark: none,
      stroke: (thickness: 0.5pt, paint: rgb("#7a7a7a"), dash: "dotted"),
      label: [$gamma approx 0.5772$],
    ),
  ),
  caption: [调和数 $H_n$、对数函数 $ln n$ 及其差值 $H_n - ln n$ 随 $n$ 的变化趋势。],
) <fig:harmonic-asymptotic>

由 @fig:harmonic-asymptotic 可见： $H_n$ 与 $ln n$ 均随 $n$ 增大而增长，但二者之差逐渐趋近于欧拉—马歇罗尼常数 $gamma$。

= 调和级数的推广

调和级数的概念可以自然地推广到所谓的 $p$-级数：

$ zeta(p) = sum_(n=1)^oo 1/n^p $

根据 $p$ 的取值不同，$p$-级数表现出截然不同的收敛行为：当 $p > 1$ 时级数收敛，当 $p <= 1$ 时级数发散。调和级数恰好对应于 $p = 1$ 这一临界情形，因此它是区分收敛与发散的边界案例。

特别地，当 $p = 2$ 时，我们得到著名的巴塞尔问题（Basel Problem），欧拉在1734年证明了其和为 $pi^2/6$。交替调和级数 $sum_(n=1)^oo (-1)^(n+1)/n$ 则是一个条件收敛的级数，其和为 $ln 2$，但通过重排其项可以使其收敛到任意实数甚至发散——这正是黎曼重排定理的一个经典示例。

= 巴塞尔问题

当 $p = 2$ 时，$p$-级数取如下形式：

$ zeta(2) = sum_(n=1)^oo 1/n^2 = 1/1^2 + 1/2^2 + 1/3^2 + dots.c $

这一级数的求和问题是数学史上著名的巴塞尔问题（Basel Problem），其名称源自瑞士城市巴塞尔——伯努利家族和欧拉的故乡。该问题由皮耶特罗·门戈利（Pietro Mengoli）于1644年正式提出，此后近一个世纪里，众多数学家尝试求解却未能成功。

这一问题的解决者是莱昂哈德·欧拉（Leonhard Euler）。1734年，年仅27岁的欧拉以非凡的洞察力证明了：

$ sum_(n=1)^oo 1/n^2 = pi^2 / 6 $

#figure(
  lq.diagram(
    title: [],
    xlabel: [$x$],
    ylabel: [$y$],
    width: 80%,
    height: 6cm,
    xlim: (0, 12),
    ylim: (0, 1.1),
    xaxis: (
      ticks: range(1, 12),
    ),
    yaxis: (
      ticks: lq.linspace(0, 1, num: 3),
    ),
    grid: (stroke: luma(95%), stroke-sub: luma(98%) + 0.25pt),
    legend: (stroke: none),
    lq.plot(
      lq.linspace(0.9, 11.5, num: 100),
      x => 1 / (x * x),
      stroke: 1pt + rgb("#0066ff"),
      label: [$f(x) = 1/x^2$],
      mark: none,
    ),
    lq.fill-between(
      lq.linspace(1, 11, num: 100),
      x => 1 / (x * x),
      fill: rgb("#aaccff"),
      stroke: none,
      label: [曲线下方面积 $integral_1^(n+1) 1/x^2 dif x$],
    ),
    lq.bar(
      range(1, 11),
      x => 1 / (x * x),
      fill: rgb("#ffccaa2b"),
      stroke: 0.8pt + rgb("#ff6600"),
      align: left,
      width: 1,
      label: [矩形面积 $1/k^2$（$p = 2$ 级数各项）],
    ),
  ),
  caption: [$p = 2$ 时积分判别法示意],
) <fig:integral-test-p2>

与调和级数不同，$f(x) = 1/x^2$ 的曲线下降极为迅速。每个矩形 $1/k^2$ 的面积仍大于其下方曲边梯形的面积，但由于反常积分 $integral_1^oo 1/x^2 dif x = 1$ 收敛至有限值，$p = 2$ 级数亦收敛。


== 欧拉的证明

欧拉的证明基于一个天才般的类比——他将正弦函数视为一个"无穷次多项式"，从而利用多项式的因式分解来获取级数的和。这一证明分为几个清晰的步骤，每一步都闪耀着数学洞察的光芒。

=== 第一步：正弦函数的泰勒展开

首先，我们需要正弦函数的泰勒级数（实为麦克劳林级数）展开。$sin x$ 在 $x = 0$ 处可展开为：

$ sin x = x - x^3 / (3!) + x^5 / (5!) - x^7 / (7!) + x^9 / (9!) - dots.c $


将等式两边同时除以 $x$（$x != 0$），我们得到：

$ (sin x) / x = 1 - x^2 / (3!) + x^4 / (5!) - x^6 / (7!) + x^8 / (9!) - dots.c $  <sinc-series>

这个形式至关重要——它的右边是一个只含偶次幂的幂级数，常数项为 1，且函数 $sinc(x) = (sin x)/x$ 在 $x = 0$ 处连续可去（其极限值为 1）。

=== 第二步：多项式因式分解的类比

欧拉的革命性思想来源于他对多项式与无穷级数之间深刻联系的洞察。对于一个 $2n$ 次多项式 $P_(2n)(x)$，如果它有 $2n$ 个非零根 $r_1, r_2, dots.c, r_(2n)$ 且满足 $P_(2n)(0) = 1$，则该多项式可以唯一地分解为以下形式：

$ P_(2n)(x) = product_(k=1)^(2n) (1 - x / r_k) = (1 - x / r_1)(1 - x / r_2) dots.c (1 - x / r_(2n)) $

特别地，如果这些根是成对出现的相反数，即 $r_1 = -r_2$, $r_3 = -r_4$, $dots.c$，则每一对因子可以合并为 $(1 - x^2 / r_k^2)$。

作为具体示例，考虑四次多项式 $1 - x^2 / 2 + x^4 / 24$，它恰好是 $(sin x)/x$ 泰勒展开截断至 $x^4$ 项的结果？ 这个四次多项式有四个根：$approx plus.minus 2.588$ 和 $approx plus.minus 3.819$，可以精确地因式分解为：

$ 1 - x^2 / 2 + x^4 / 24 = (1 - x^2 / (2.588^2))(1 - x^2 / (3.819^2)) $

这一事实强烈地暗示：如果我们将截断的阶数不断提高，那么 $(sin x)/x$ 的泰勒多项式——作为 $sin x$ 的逐次逼近——应该趋近于一个无穷乘积，其因子对应于 $sin x$ 的所有非零根。

=== 第三步：正弦函数的无穷乘积

那么 $sin x$ 的根是什么呢？方程 $sin x = 0$ 的解为 $x = 0, plus.minus pi, plus.minus 2 pi, plus.minus 3 pi, dots.c$。排除 $x = 0$ 这个根（因为它已被 $x$ 因子消去），$sinc(x) = (sin x)/x$ 的根恰好为 $x = plus.minus pi, plus.minus 2 pi, plus.minus 3 pi, dots.c$。

基于多项式因式分解的类比，欧拉大胆地断言 $sinc(x)$ 可以像多项式一样分解为以这些根为因子的无穷乘积：

$
  (sin x) / x = product_(n=1)^oo (1 - x^2 / (n^2 pi^2)) = (1 - x^2 / pi^2)(1 - x^2 / (4 pi^2))(1 - x^2 / (9 pi^2)) dots.c
$  <sinc-product>

这里，每一对相反数根 $plus.minus n pi$ 合并为一个二次因子 $(1 - x^2/(n^2 pi^2))$。需要强调，欧拉当时并未给出这一无穷乘积收敛性的严格证明，但他通过对数值的惊人验证——仅取前几项乘积就可得到 $pi^2/6$ 的近似值——以及后续对其他函数的类似成功推广，使得这一公式的可信度毋庸置疑。（严格的数学证明由柯西和魏尔斯特拉斯在一个世纪后完成。）

=== 第四步：比较 $x^2$ 项系数

现在，我们同时拥有了 $sinc(x)$ 的两种表达式。

一方面，由泰勒展开 @sinc-series，$x^2$ 项的系数为 $-1/(3!) = -1/6$。

另一方面，由无穷乘积 @sinc-product，我们将乘积展开，重点关注 $x^2$ 项的来源——它来自于从各个因子中恰好选取一个 $(-x^2/(n^2 pi^2))$ 项，而其他所有因子均选取 1。因此 $x^2$ 项的系数为：

$ - sum_(n=1)^oo 1 / (n^2 pi^2) = - 1 / pi^2 sum_(n=1)^oo 1 / n^2 $

令两种表达式中 $x^2$ 的系数相等，即得：

$ - 1 / 6 = - 1 / pi^2 sum_(n=1)^oo 1 / n^2 $

=== 第五步：导出最终结果

两边同时乘以 $-pi^2$，立即得到：

$ sum_(n=1)^oo 1 / n^2 = pi^2 / 6 $  <basel-result>

这就是巴塞尔问题的最终答案。

=== 欧拉证明的深远意义

欧拉的这一证明在数学史上具有里程碑式的意义。它不仅解决了一个困扰数学界近一个世纪的难题，更重要的是开创了通过无穷乘积研究级数求和的全新方法。得到 $pi^2/6$ 这一结果后，欧拉乘胜追击，继续利用类似技巧求解了 $zeta(4) = pi^4/90$、$zeta(6) = pi^6/945$ 等一系列问题，最终猜出了一般形式——即 $zeta(2n)$ 总是 $pi^(2n)$ 乘以一个有理数。

从数值角度验证，$pi^2/6 approx 1.644934$，而巴塞尔级数的前几项之和 $1 + 1/4 + 1/9 + 1/16 approx 1.42361$、前十项之和约为 $1.54977$，确实在稳步趋近这一极限值（参见前文的收敛曲线）。这一结果还与概率论中两个随机正整数互素的概率（等于 $6/pi^2 approx 0.6079$）等深刻结论联系在一起，彰显了数学不同分支之间惊人的内在统一性。

此外，欧拉的无穷乘积法也直接启发了后来黎曼 $zeta$ 函数的研究以及素数定理的证明。函数 $sin x$ 的无穷乘积展开是数学分析中最优美也最深远的公式之一，它架起了三角学、代数学和数论之间的桥梁。

== 傅里叶级数证明

除欧拉的无穷乘积法外，傅里叶级数（Fourier Series）提供了另一种简洁而优雅的证明途径。考虑函数 $f(x) = x^2$ 在区间 $[-pi, pi]$ 上的傅里叶级数展开。由于 $f(x)=x^2$在 $[-pi, pi]$ 上连续且绝对可积，因此它可以展开为一个傅里叶级数：

$ f(x) = a_0/2 + sum_(n=1)^infinity [a_n cos((2 pi n x)/T) + b_n sin((2 pi n x)/T)] $

$T= 2 pi$, 且：$ b_n = 2/T integral_(-pi)^(pi) f(x) sin((2 pi n x)/T) dif x $


由于 $f(x)$ 是偶函数，则：$ b_n = 0 $

因为奇函数与偶函数的乘积在对称区间上的积分为零。因此，$f(x)$ 的傅里叶级数展开式中仅包含余弦项：

$ f(x) = a_0 / 2 + sum_(n = 1)^oo a_n cos(n x) $

其中傅里叶系数由欧拉公式计算：

$ a_0 = 2 / pi integral_0^pi x^2 dif x = 2 / pi dot [x^3 / 3]_0^pi = 2 / 3 pi^2 $

$ a_n = 2 / pi integral_0^pi x^2 cos(n x) dif x $

利用两次分部积分计算 $a_n$：

$
  a_n & = 2 / pi ( [x^2 (sin(n x)) / n]_0^pi - integral_0^pi 2x (sin(n x)) / n dif x ) \
      & = - 4 / (n pi) integral_0^pi x sin(n x) dif x \
      & = - 4 / (n pi) ( [x (-cos(n x)) / n]_0^pi + integral_0^pi (cos(n x)) / n dif x ) \
      & = - 4/(n pi) ( [ pi/n (-1)^(n-1) - 0 ] + 0 ) \
      & = - 4 / (n pi) dot (pi (-1)^(n-1)) / n \
      & = (4 (-1)^n) / n^2
$

因此，$x^2$ 的傅里叶级数展开为：

$ x^2 = pi^2 / 3 + sum_(n = 1)^oo (4 (-1)^n) / n^2 cos(n x) $

令 $x = pi$，则 $cos(n pi) = (-1)^n$，代入上式得：

$ pi^2 = pi^2 / 3 + sum_(n = 1)^oo (4 (-1)^n) / n^2 (-1)^n = pi^2 / 3 + 4 sum_(n = 1)^oo 1 / n^2 $

移项整理即得：

$ sum_(n = 1)^oo 1 / n^2 = pi^2 / 6 $

这一证明仅需微积分和傅里叶级数的基础知识，无需无穷乘积等较深的概念。其核心思想——将函数展开为三角级数后代入特定自变量——逻辑清晰、计算直接，堪称巴塞尔问题最直观的证明之一。



为了直观地观察 $zeta(2)$ 的收敛过程，我们可以绘制其部分和 $S_n = sum_(k=1)^n 1/k^2$ 随 $n$ 的变化曲线。注意到该级数收敛极为迅速——前 10 项的和就已达到 $pi^2/6$ 的约 $99.5%$，远快于调和级数。

#let N = 30
#let n2 = range(1, N + 1)
#let S_n = {
  let arr = ()
  let s = 0.0
  for k in range(1, N + 1) {
    s += 1.0 / (k * k)
    arr.push(s)
  }
  arr
}
#let zeta2 = calc.pi * calc.pi / 6

#show lq.selector(lq.legend): set grid(row-gutter: 10pt)


#figure(
  lq.diagram(
    title: [],
    xlabel: [$n$],
    ylabel: [$S_n$],
    width: 80%,
    height: 4cm,
    xlim: (0, N + 3),
    ylim: (0, 1.7),
    xaxis: (
      ticks: range(0, N + 1, step: 5),
    ),
    yaxis: (
      ticks: lq.linspace(0, 1.6, num: 5),
    ),
    grid: (stroke: luma(95%), stroke-sub: luma(98%) + 0.25pt),
    legend: (stroke: none, position: (75%, 20%)),
    lq.plot(
      n2,
      S_n,
      stroke: 1.2pt + rgb("#0066ff"),
      mark: none,
      step: end,
      label: [$display(S_n = sum_(k=1)^n 1/k^2)$],
    ),
    lq.plot(
      (1, N),
      (zeta2, zeta2),
      mark: none,
      stroke: (thickness: 1pt, paint: rgb("#898989"), dash: "dashed"),
      label: [$pi^2/6 approx 1.6449$],
    ),
  ),
  caption: [$p = 2$ 时，部分和 $S_n = sum_(k=1)^n 1/k^2$ 的收敛趋势。灰色虚线为极限值 $pi^2/6$。],
) <fig:basel-convergence>

由 @fig:basel-convergence 可以清晰地看到，$S_n$ 随着 $n$ 的增大迅速趋近于 $pi^2/6 approx 1.6449$。与调和级数缓慢发散形成鲜明对比，$p = 2$ 的级数收敛十分迅速，这也再次印证了 $p$-级数在 $p = 1$ 处发生了从发散到收敛的临界转折。



== 证明

证明：对单调递减函数 $1/x^2$，有
$ display(integral_(N+1)^infinity 1/x^2 dif x < sum_(n=N+1)^infinity 1/n^2 < integral_N^infinity 1/x^2 dif x) $

因为 $1/x^2$ 严格单调递减，在区间 $[k, k+1]$ 上恒有 $1/(k+1)^2 < 1/x^2 < 1/k^2$。对 $k = N+1$：

$ integral_(N+1)^(N+2) 1/x^2 dif x < 1/(N+1)^2 < integral_N^(N+1) 1/x^2 dif x $

推广到一般项：对任意 $k >= N+1$，有
$ integral_(k)^(k+1) 1/x^2 dif x < 1/k^2 < integral_(k-1)^(k) 1/x^2 dif x $

对 $k$ 从 $N+1$ 到 $oo$ 求和，即得：
$ integral_(N+1)^oo 1/x^2 dif x < sum_(n=N+1)^oo 1/n^2 < integral_N^oo 1/x^2 dif x $





#set page(
  paper: "a4",
  flipped: false,
  margin: 1.5cm,
  numbering: "1/1",
  number-align: center,
  fill: rgb("#ffffff13"),
)

#set document(
  title: [数学常识],
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




= 周期函数 $f(x)$ 的傅里叶级数

//以下为傅里叶级数的一般理论，上文求解中使用的正弦级数展开即基于此。

== 基本定理陈述

设 $f(x)$ 是以 $T$ 为周期的周期函数，且在任意一个长度为 $T$ 的区间上绝对可积，则 $f(x)$ 可以展开为傅里叶级数：

$ f(x) tilde frac(a_(0), 2) + sum_(n = 1)^(infinity)[ a_(n) cos(frac(2 pi n x, T)) + b_(n) sin(frac(2 pi n x, T)) ] $

其中符号 $tilde$ 表示右边的级数是由 $f$ 的傅里叶系数形式构造的，要使其真正等于 $f(x)$，还需附加收敛条件。

#abstract(title: [绝对可积])[
  可积 (Integrable)的直觉含义：函数 $f(x)$ 在区间 [a,b] 上的积分存在（有限值）。

  绝对可积 (Absolutely Integrable)的直觉含义：$|f(x)|$是可积的，即$display(integral)_a^b |f(x)| d x < infinity$

  傅里叶级数展开定理要求$f(x)$在$[x_0, x_0 +T]$上是绝对可积的，即$display(integral)_(x_0)^(x_0 +T) |f(x)|d x < infinity$

  绝对可积要求$|f(x)|$的积分有限，而可积只要求$f(x)$本身的积分有限（可能通过正负抵消而收敛）。

  这比"可积"的要求更强 —— 它排除了条件收敛的情形，确保：傅里叶系数（含 $|f(x) cos|$、$|f(x) sin|$）的积分绝对收敛，系数定义良好？？？

  傅里叶级数理论要求绝对可积，是为了保证系数公式在更一般的意义下成立？？？
]

== 傅里叶系数公式

利用三角函数系在区间 $[x_(0), x_(0) + T ]$ 上的正交性，可得系数公式（与起点 $x_(0)$ 无关）：

$ a_(0) = 2/T integral_(x_(0))^(x_(0)+ T) f(x) thin d x #h(3.8cm) $

$ a_(n) = 2/T integral_(x_(0))^(x_(0)+ T) f(x) cos(frac(2 pi n x, T)) d x #h(1cm) n >= 1 $

$ b_(n) = 2/T integral_(x_(0))^(x_(0)+ T) f(x) sin(frac(2 pi n x, T)) d x #h(1cm) n >= 1 $





== 正交性基础（为什么系数公式成立）

三角函数系

$ { 1,thick cos frac(2 pi n x, T),thick sin frac(2 pi n x, T) quad(n = 1, 2, 3, ...) } $

在任意长度为 $T$ 的区间 $[x_(0), x_(0)+ T ]$ 上满足正交关系，且结果与起点 $x_(0)$ 无关：

① 余弦-余弦正交：

$
  integral_(x_(0))^(x_(0)+ T) cos frac(2 pi m x, T) cos frac(2 pi n x, T) d x = cases(0 #h(1cm) & m != n, display(frac(T, 2)) #h(1cm) & m = n != 0, T #h(1cm) & m = n = 0) #h(1cm) forall m,n in NN
$

#abstract(title: [证明])[
  证明：$display(integral_(x_(0))^(x_(0)+ T) cos frac(2 pi m x, T) cos frac(2 pi n x, T) d x =0 #h(1cm) "当" m!=n "时")$

  提示：使用积化和差公式 $display(cos A cos B = 1/2 [cos(A+B) + cos(A-B)])$
]

② 正弦-正弦正交：

$
  integral_(x_(0))^(x_(0)+ T) sin frac(2 pi m x, T) sin frac(2 pi n x, T) d x = cases(0 #h(1cm) & m != n, display(frac(T, 2)) #h(1cm) & m = n != 0, 0 #h(1cm) & m = n = 0) #h(1cm) forall m,n in NN
$

#abstract(title: [证明])[
  证明：$display(integral_(x_(0))^(x_(0)+ T) sin frac(2 pi m x, T) sin frac(2 pi n x, T) d x =0 #h(1cm) "当" m!=n "时")$

  提示：使用积化和差公式 $display(sin A sin B = 1/2 [cos(A-B) - cos(A+B)])$
]


③ 余弦-正弦正交（跨族正交）：

$ integral_(x_(0))^(x_(0)+ T) cos frac(2 pi m x, T) sin frac(2 pi n x, T) d x = 0 #h(1cm) forall m \, n in NN $

#abstract(title: [证明])[
  证明：$display(integral_(x_(0))^(x_(0)+ T) cos frac(2 pi m x, T) sin frac(2 pi n x, T) d x =0 #h(1cm) forall m \, n in NN)$

  提示：使用积化和差公式 $display(cos A sin B = 1/2[sin(B+A) + sin(B-A)])$
]

== 推导思路（求解系数）

=== 正交展开法

假设 $f(x)$ 可以展开为：

$
  f(x) tilde frac(A_(0), 2) + sum_(n = 1)^(infinity)[ A_(n) cos(frac(2 pi n x, T)) + B_(n) sin(frac(2 pi n x, T)) ]
$<Fourier_Series_Expansion>

#abstract(title: [$n in NN^+$])[
  不需要求解 $B_0$
]

两边同乘 $cos((2 pi m x) / T)$ 并在 $[x_(0), x_(0)+ T ]$ 上积分，利用正交性，只有 $n = m$ 的项非零，得到：

$
  integral_(x_(0))^(x_(0)+ T) f(x) cos(frac(2 pi m x, T)) d x =cases(A_n T/2 #h(1cm) & m !=0, A_0 T/2 #h(1cm) &m=0) #h(1cm) = #h(0.5cm) A_(m) dot T/2
$

因此，$A_m$ 也即$A_n$等于：

$ A_(m) = 2/T integral_(x_(0))^(x_(0)+ T) f(x) cos(frac(2 pi m x, T)) d x #h(1cm) m in NN $


等式 @Fourier_Series_Expansion 两端同乘 $sin((2 pi m x)/T)$，并在区间 $[x_0, x_0 +T]$上积分，利用正交性，只有 $m=n$ 的项非零，得到：

$ integral_(x_0)^(x_0 +T) f(x) sin((2 pi m x)/T)d x = cases(B_n T/2 #h(1cm) & m!=0, 0 #h(1cm) & m=0) #h(1cm) = B_m T/2 $

因此，$B_m$也即$B_n$等于：

$ B_m = 2/T integral_(x_0)^(x_0 +T) f(x) sin((2 pi m x)/T)d x #h(1cm) m in NN^+ $


== 收敛条件（狄利克雷条件）

若 $f(x)$ 在 $[x_(0), x_(0)+ T ]$ 上满足：

+ 绝对可积：$display(integral_(x_(0))^(x_(0)+ T) | f(x)| d x < infinity)$
+ 有限个极值点：在任意有限区间内只有有限个极大值和极小值
+ 有限个第一类间断点：在任意有限区间内只有有限个跳跃间断点

则傅里叶级数收敛，且：

$ S(x) = frac(f(x^(+)) + f(x^(-)), 2) $

- 若 $f$ 在 $x$ 处连续，则 $S(x) = f(x)$
- 若 $x$ 是间断点，则 $S(x)$ 收敛于左右极限的算术平均值
- 在端点 $x_(0)$ 和 $x_(0)+ T$ 处（由于周期性，本质是同一点），$S(x_(0)) = display(frac(f(x_(0)^(+)) + f((x_0 + T)^-), 2))$

#abstract(title: [傅里叶级数的和函数$S(x)$])[
  S(x)就是式 @Fourier_Series_Expansion 右侧的函数值，它是由傅里叶系数构造出来的级数在点 x 处的收敛值。
  简单直觉：你不能直接用 f(x) 表示傅里叶级数的和，因为在间断点处级数不会收敛到 f(x) 本身（会 overshoot，即 Gibbs 现象），而是收敛到跳跃两边的"中间值"。所以引入 S(x) 来精确描述级数实际收敛到的值。
]

核心原理：三角函数在任意一个完整周期上的积分结果相同，因为被积函数是周期函数，积分值只依赖于区间长度 $T$，不依赖于起点 $x_(0)$。这就是为什么系数公式中的积分区间可以取任意起点。


== 复数形式

=== 级数展开为

$ f(x) tilde sum_(n = - infinity)^(infinity) c_(n) thin e^(i frac(2 pi n x, T)) $

=== 系数

$ c_(n) = 1/T integral_(x_(0))^(x_(0)+ T) f(x) thin e^(- i frac(2 pi n x, T)) d x $

=== 三角形式与复数形式的关系：

$ c_(n) = frac(a_(n) - i b_(n), 2), quad c_(- n) = frac(a_(n) + i b_(n), 2), quad c_(0) = frac(a_(0), 2) $



#pagebreak()

= 傅里叶正弦级数

== 定义

若 $f(x)$ 定义在区间 $[0, L]$ 上，且满足狄利克雷条件，则 $f(x)$ 可以展开为**傅里叶正弦级数**（Fourier Sine Series）：

$ f(x) tilde sum_(n = 1)^(infinity) b_(n) sin(frac(n pi x, L)) $ <Sine_Series>

其中系数公式为：

$ b_(n) = 2/L integral_(0)^(L) f(x) sin(frac(n pi x, L)) d x #h(1cm) n in NN^+ $ <Sine_Coefficient>

== 物理意义

傅里叶正弦级数对应的是将 $f(x)$ 先做**奇延拓**到 $[-L, L]$，再做周期为 $2L$ 的周期延拓后展开为完整傅里叶级数，恰好只保留正弦项（$a_n = 0$）。

#abstract(title: [奇延拓])[
  构造一个奇函数 $F(x)$，使其在 $(0, L]$ 上等于 $f(x)$，且在 $x=0$ 处 $F(0)=0$：

  $ F(x) = cases(f(x) #h(3cm) & 0 < x <= L, -f(-x) #h(2cm) & -L <= x < 0, 0 #h(3cm) & x = 0) $

  将 $F(x)$ 以 $2L$ 为周期延拓到整个实数轴，展开成完整傅里叶级数后，所有余弦项系数 $a_n$ 均为零，只剩下正弦项。
]

== 在本文中的应用

在求解两端固定的弦振动问题时：

- 空间特征函数为 $X_n (x) = sin(frac(n pi x, L_0))$，这就是傅里叶正弦级数的基函数。
- 初始位移 $y(x,0)$ 在 $[0, L_0]$ 上展开为正弦级数，恰好对应了边界条件 $y(0,t)=y(L_0,t)=0$。
- 系数 $b_n$ 由公式 @Sine_Coefficient 给出，即：

$ b_n = 2/L_0 integral_(0)^(L_0) y(x,0) sin(frac(n pi x, L_0)) d x $

这正是本文求解 $C_(2,n) D_(1,n)$ 时使用的公式。

#abstract(title: [对比完整傅里叶级数])[
  完整傅里叶级数的基函数为 $sin(frac(2 pi n x, T))$（周期 $T$），而傅里叶正弦级数的基函数为 $sin(frac(n pi x, L))$（半周期 $L$）。二者不可混淆：
  - 完整傅里叶级数的周期为 $T$，频率为 $frac(2 pi n, T)$；
  - 傅里叶正弦级数的"周期"为 $2L$（奇延拓后），半区间 $[0, L]$ 上的频率为 $frac(n pi, L)$。

  在本文中，弦长 $L_0$ 对应的是半区间长度，基函数 $sin(frac(n pi x, L_0))$ 的频率为 $frac(n pi, L_0) = frac(2 pi n, 2 L_0)$，即完整傅里叶级数中周期 $T=2L_0$ 的情形。
]



= 泰勒公式

#abstract(title: [带佩亚诺型余项的泰勒公式])[
  定理：设函数 $f(x)$ 在点 $x_0$ 的某邻域内具有 $n$阶导数（足够光滑），则在该邻域内，可以使用一个多项式来近似代替这个函数： \
  $f(x)= f(x_0) + f'(x_0)(x - x_0) + (f''(x_0))/(2!) (x - x_0)^2 + dots + (f^((n))(x_0))/(n!) (x - x_0)^n + O((x - x_0)^(n+1))$  \ \

]

#abstract(title: [$f(x)= sqrt(1 + x^2)$的泰勒公式])[

  记：$f(x)= sqrt(1 + x^2)$ \
  导数：$f'(x) = display(x / sqrt(1 + x^2))$ #h(2cm)
  $f''(x) = display(1 / (1 + x^2)^(3/2))$ #h(2cm) $f'''(x) = display((- 3 x) / (1 + x^2)^(5/2))$ #h(2cm)

  则，在 $x=0$的某个邻域内： \
  $display(
    f(x) & = f(0) + f'(0)(x-0) + (f''(0))/(2!) (x - 0)^2 + dots + (f^((n))(0))/(n!) (x - 0)^n + O((x - 0)^(n+1)) \
    & = 1 + x^2 /2 + O(x^4)
  )$

  则： $display(sqrt(1 + x^2) -1 & = x^2 /2 + O(x^4))$
]





#abstract(title: [$sin x$ 的泰勒公式])[
  在 $x=0$ 的邻域内，$sin x$ 的泰勒展开式为：
  $
    sin x = x - x^3/3! + x^5/5! - x^7/7! + dots.c + (-1)^n x^(2n+1)/((2n+1)!) + O(x^(2n+3))
  $
  其中 $n in NN$。
]

#abstract(title: [$cos x$ 的泰勒公式])[
  在 $x=0$ 的邻域内，$cos x$ 的泰勒展开式为：
  $
    cos x = 1 - x^2/2! + x^4/4! - x^6/6! + dots.c + (-1)^n x^(2n)/((2n)!) + O(x^(2n+2))
  $
  其中 $n in NN$。
]

#abstract(title: [$tan x$ 的泰勒公式])[
  在 $x=0$ 的邻域内，$tan x$ 的泰勒展开式为：
  $
    tan x = x + x^3/3 + 2 x^5/15 + 17 x^7/315 + dots.c + O(x^(2n+1))
  $
  其中 $n in NN^+$。与 $sin x$ 和 $cos x$ 不同，$tan x$ 的泰勒展开系数没有简单的通项公式，展开式中只含 $x$ 的奇次幂（因为 $tan x$ 是奇函数），各项系数由伯努利数给出。]


#abstract(title: [大$O$记号 与小$o$记号])[
  当 $x -> 0$ 时，二者都用于描述无穷小的阶数，但有本质区别：
  + $O(x^n)$：存在常数 $C>0$ 使得 $|O(x^n)| <= C |x|^n$。即该量至少与 $x^n$ 同阶（可能是 $x^n$、$x^(n+1)$ 或更高阶）。
  + $o(x^n)$：满足 $display(lim_(x -> 0) (o(x^n))/(x^n) = 0)$。即该量严格比 $x^n$ 更高阶。

  例：$x^4 = O(x^3)$ 成立（因为 $|x^4| <= C|x^3|$），但 $x^4 = o(x^3)$ 也成立（因为 $x^4/x^3 = x -> 0$）。而 $x^3 = O(x^3)$ 成立，但 $x^3 = o(x^3)$ 不成立。
]





---
math-engine: mathjax
---


## 数值积分

数值积分是一种数值计算方法，用于近似求解定积分 $\displaystyle \int_a^b f(x) \, dx$，当解析积分难以或无法求解时特别有用。它通过将积分区间 $[a, b]$ 分割成小段，并用简单几何形状（如矩形、梯形或抛物线）近似每个小段下的函数面积，然后求和这些面积来估计积分值。相比解析积分，数值积分更灵活，能处理复杂函数，但可能引入截断误差和舍入误差。

### 一、数值积分的基本原理

数值积分基于牛顿-莱布尼茨公式，但用离散点代替连续函数。常见方法包括：
矩形法：将区间分成 $n$ 个等宽子区间，每个子区间用函数在左端点、右端点或中点的值乘以宽度 $\displaystyle h = \frac{b - a}{n}$ 来近似面积。公式为 $\displaystyle \int_a^b f(x) \, dx \approx h \sum_{i=0}^{n-1} f(a + i h)$（左矩形法）。
梯形法：每个子区间用梯形近似面积，提高精度。公式为 $\displaystyle \int_a^b f(x) \, dx \approx \frac{h}{2} \left[ f(a) + 2 \sum_{i=1}^{n-1} f(a + i h) + f(b) \right]$。
辛普森法：用抛物线拟合三个点，提高二次函数的精度。公式为 $\displaystyle \int_a^b f(x) \, dx \approx \frac{h}{3} \left[ f(a) + 4 \sum_{i=1}^{n/2} f(a + (2i-1) h) + 2 \sum_{i=1}^{n/2 - 1} f(a + 2i h) + f(b) \right]$（$n$ 需为偶数）。
Romberg积分：基于梯形法，通过外推（如Richardson外推）加速收敛，减少误差。
Gauss求积：使用加权求和 $\displaystyle \int_a^b f(x) \, dx \approx \sum_{i=1}^n w_i f(x_i)$，其中 $x_i$ 和 $w_i$ 是Gauss点和权重，适用于高精度需求。
自适应方法：如自适应辛普森或Gauss-Kronrod，根据函数行为动态调整子区间。
这些方法的选择取决于函数的平滑度、积分区间长度和所需精度。误差分析通常涉及泰勒展开，误差阶为 $O(h^k)$，其中 $k$ 随方法而变（矩形法 $k=1$，辛普森 $k=4$）。在实际应用中，库如SciPy的 `integrate.quad` 结合多种方法，提供自动误差控制。


### 二、选择数值积分方法需要考虑的因素

数值积分是用来近似计算定积分$\displaystyle \int_a^b f(x) \, dx$的方法，因为很多积分无法解析求解。选择合适的方法时，需要综合考虑函数的性质、奇异性或振荡、积分区间、精度要求和计算效率。下面我用简单例子，逐一解释这些因素，力求通俗易懂。每个例子都假设我们积分一个基本函数，并比较不同方法的效果。

#### 1. 被积函数的性质
函数的“性质”指它是否光滑、连续，还是有尖峰、跳跃等特点。光滑函数（比如多项式）适合简单方法，而复杂函数需要更高级的。
简单例子：计算$\displaystyle \int_0^1 x^2 \, dx$（这是一个光滑的二次函数，解析值为$\displaystyle \frac{1}{3}$）。
如果用梯形法则（简单方法，假设函数线性变化）：取2个子区间，近似值为0.375（误差0.0417）。
如果用辛普森法则（考虑二次变化，更适合光滑曲线）：近似值为0.3333（几乎无误差）。
为什么考虑这个：光滑函数用高阶方法（如辛普森）精度高；如果函数有尖峰（如$f(x) = |x|$），梯形法则可能出错大，需要自适应方法（如自动调整子区间）来处理。
总之，光滑函数选简单规则；不规则函数选能“聪明”调整的方法。

#### 2. 潜在的奇异性或振荡行为
奇异性指函数在某点无限大或不连续（如$\displaystyle \frac{1}{\sqrt{x}}$在x=0处奇异）；振荡指函数快速上下摆动（如$\sin(100x)$）。
简单例子（奇异性）：计算$\displaystyle \int_0^1 \frac{1}{\sqrt{x}} \, dx$（解析值为2，在x=0处奇异）。
用均匀网格的梯形法则：取10个子区间，近似值为2.5（误差大，因为忽略奇异点）。
用变量变换（如让$\displaystyle t = \sqrt{x}$，转为$\displaystyle \int_0^1 2 \, dt$）或自适应方法（如Romberg积分，自动加密网格近奇异点）：近似值为2（精确）。
为什么考虑这个：奇异函数用标准方法会发散或误差巨大；需用变换或自适应来“避开”问题。

简单例子（振荡）：计算$\displaystyle \int_0^\pi \sin(10x) \, dx$（解析值为0.2，高频振荡）。
用标准梯形法则（固定子区间）：取10个点，近似值可能为0.1（误差因振荡漏掉峰谷）。
用Clenshaw-Curtis方法（专为振荡设计，用傅里叶变换处理）：近似值为0.2（精确）。
为什么考虑这个：振荡函数标准方法采样不足导致误差；需用振荡专用方法或增加采样点。
忽略这些，计算可能完全错。
```tikz
\begin{document}
\definecolor{myblue}{RGB}{60, 120, 245}
\begin{tikzpicture}[xscale=0.51,yscale=0.5,>=stealth]
\draw [->,thin](-1,0)--(11,0)node[right]{x};
\draw [->,thin](0,-1)--(0,11)node[above]{y};
%\draw [thin](-1,0)--(-1,0.02)node[below=0.2cm,font=\large]{-1};
\draw [thin](10,0)--(10,0.02)node[below=0.2cm,font=\large]{10};
%\draw [thin](0,-1)--(0.02,-1)node[left=0.2cm,font=\large]{-1};
\draw [thin](0,10)--(0.02,10)node[left=0.2cm,font=\large]{10};
\draw[thick,myblue] plot[domain=0.01:10,samples=100,smooth](\x,{1/sqrt(\x)});
\draw[thin,myblue](6,8)--(7,8)node[right=0.1cm,font=\large]{$\displaystyle y=\frac{1}{\sqrt{x}}$};
\end{tikzpicture}
\end{document}
```

```tikz
\begin{document}
\begin{tikzpicture}[xscale=4,yscale=2,>=stealth]
\draw [->,thin](-1.05,0)--(1.05,0)node[right]{x};
\draw [->,thin](0,-1.5)--(0,1.5)node[above]{y};
\draw [thin](-1,0)--(-1,0.02)node[below=0.2cm,font=\large]{-1};
\draw [thin](1,0)--(1,0.02)node[below=0.2cm,font=\large]{1};
\draw [thin](0,-1)--(0.02,-1)node[left=0.2cm,font=\large]{-1};
\draw [thin](0,1)--(0.02,1)node[left=0.2cm,font=\large]{1};
%\draw[thin,cyan] plot[domain=0.1:1,samples=100,smooth](\x,{1/sqrt(\x)});

\draw[thin,orange] plot[domain=-0.8:0.8,samples=100,smooth](\x,{sin(100*(\x) r)});
\draw[thin,orange](0.2,1.3)--(0.4,1.3)node[right=0.1cm,font=\large]{$y=sin(100x)$};
\end{tikzpicture}
\end{document}
```


#### 3. 积分区间的特征
区间是有限（如$[0,1]$）还是无限（如$[0,\infty)$），或多维，会影响方法选择。
简单例子（有限区间）：计算$\displaystyle \int_0^1 e^x \, dx$（解析值为$e-1 \approx 1.718$）。
用高斯-勒让德求积（专为有限区间，节点优化）：取3个节点，近似值为1.718（精确）。
无限区间例子：计算$\displaystyle \int_0^\infty e^{-x} \, dx$（解析值为1）。
用高斯-拉盖尔求积（专为$[0,\infty)$设计，权重$e^{-x}$）：取少量节点，精确得1。
用标准方法（如梯形）需截断区间（如到10），近似0.9999，但若函数衰减慢，误差大。
为什么考虑这个：有限区间用Newton-Cotes系列；无限需专用正交（如拉盖尔）或变换（如$\displaystyle t = \frac{1}{1+x}$转为有限）。
区间特征不对，方法可能不收敛。

#### 4. 所需的计算精度
精度指近似值与真值的接近度。高精度需更多计算，但不总是必要。
简单例子：计算$\displaystyle \int_0^1 \sqrt{x} \, dx$（解析值为$\displaystyle \frac{2}{3} \approx 0.6667$）。
如果只需粗精度（误差<0.1）：用中点法则，1个子区间，近似0.707（误差0.04，够用）。
如果需高精度（误差<0.001）：用Romberg方法（逐步细化网格），自动迭代到0.6667。
为什么考虑这个：低精度选简单方法（如矩形法则）；高精度选复合或自适应方法（如增加子区间或用误差估计）。
精度越高，方法越复杂，但能避免过度计算。

#### 5. 计算效率
效率指用多少计算资源（时间、内存）达到精度。需平衡精度和速度，尤其大数据。
简单例子：计算$\displaystyle \int_0^{10} \cos(x) \, dx$（解析值为$\sin(10) \approx -0.5440$）。
用蒙特卡罗方法（随机采样，效率低但简单）：1000次采样，近似-0.5（快，但误差0.044）。
用复合辛普森（确定性，效率高）：10子区间，近似-0.5440（稍慢但精确）。
为什么考虑这个：小问题选高精度方法；大区间或多维积分选蒙特卡罗（并行快）；振荡或奇异时，自适应方法高效（只在需要处加密）。
效率差的方法在实际（如工程模拟）中可能运行太慢。

#### 6. 总结比较
用表格简单对比这些因素在例子中的影响：

| 因素   | 示例函数                 | 适合方法示例          | 不适合方法示例     | 理由简述            |
| ---- | -------------------- | --------------- | ----------- | --------------- |
| 函数性质 | $x^2$ (光滑)           | 辛普森法则           | 梯形法则        | 光滑用高阶精确；简单方法误差大 |
| 奇异性  | $\frac{1}{\sqrt{x}}$ | 自适应/变换          | 均匀梯形        | 奇异需针对处理否则发散     |
| 振荡行为 | $\sin(10x)$          | Clenshaw-Curtis | 标准梯形        | 振荡需捕捉峰谷否则漏掉     |
| 积分区间 | $e^{-x}$ 从0到∞        | 高斯-拉盖尔          | 标准截断梯形      | 无限需专用权重否则不准     |
| 计算精度 | $\sqrt{x}$           | Romberg (高精度)   | 中点 (低精度)    | 高精度需迭代；低精度简单    |
| 计算效率 | $\cos(x)$ 大区间        | 复合辛普森           | 蒙特卡罗 (若需精确) | 确定性高效；随机适合粗估    |

选择方法时，先分析函数和需求，再试简单方法，若不行再升级。实际中，软件如Python的SciPy库能自动帮选，但理解这些能优化结果。

#### 7.归一化徳拜热容函数的性质

归一化德拜热容函数定义为 $\displaystyle D(x) = 3 x^3 \int_0^{1/x} \frac{t^4 e^t}{(e^t - 1)^2} \, dt$     其中： $\displaystyle x=\dfrac{T}{\theta_{D}}$ ，$T$ 是温度，$\theta_D$ 是德拜温度。
因为被积函数 $\displaystyle f(t)=\dfrac{t^4e^t}{(e^t-1)^2}$ 在区间 $\displaystyle (0,+\infty)$上是连续的，则：在区间 $\displaystyle (0,+\infty)$上必定存在它的原函数 $\displaystyle F(t)$ ，而且 $\displaystyle F(t)$ 在该区间上也是连续的且可导的。  $\displaystyle \Rightarrow \quad$ $\displaystyle  D(x)$在$(0,+\infty)$上也是连续且可导的。

可证明：$\displaystyle \lim_{x \to 0+}D(x)=0$ ，$\displaystyle \lim_{x \to +\infty}D(x)=1$ ，则：D(x)在$(0,+\infty)$上是连续可导的有界函数。

需要绘制D(x)在$(0,+\infty)$上的函数曲线。由于D(x)是一个带变限积分的函数，而且绘图区域是一个无穷区间，先绘制被积函数在定义域上的函数曲线，如下图所示。
因为$D(x)$有一条渐近线$y=1$，在确定$D(x)$的绘图区域时，需要表现出渐进性质。根据被积函数的图形，可以将绘图区域设置为$(0.05,5)$。

```tikz
\usetikzlibrary{fpu}
\begin{document}
\definecolor{mygreen}{RGB}{60, 180, 90}
\begin{tikzpicture}[xscale=0.5,yscale=1,>=stealth]
\draw [->,thin](-1,0)--(12.8,0)node[right]{t};
\draw [->,thin](0,-1)--(0,5.8)node[left]{f(t)};
\draw[xstep=1,ystep=1,dotted,gray](0,0)grid(12,5);
\draw [thin](12,0)--(12,0.1)node[below=0.2cm,font=\large]{12};
\draw [thin](0,5)--(0.1,5)node[left=0.2cm,font=\large]{5};
\begin{scope}
\pgfkeys{/pgf/fpu=true,/pgf/fpu/output format=fixed}
\draw[thin,mygreen] plot[domain=0.1:12,samples=30,smooth](\x,{((pow(\x,4)*exp(\x))/((exp(\x)-1)^2)});
\end{scope}
\draw[thin,mygreen](6,5)--(7,5)node[right=0.1cm,font=\large]{$\displaystyle f(t)=\frac{t^4e^t}{(e^t-1)^2}$};
\end{tikzpicture}
\end{document}
```
归一化德拜热容函数定义为 $\displaystyle D(x) = 3 x^3 \int_0^{1/x} \frac{t^4 e^t}{(e^t - 1)^2} \, dt$     其中： $\displaystyle x=\dfrac{T}{\theta_{D}}$ 
我现在需要在Obsidian中使用tikz代码绘制该函数的函数曲线，由于这个函数的表达式中带有变限积分，需要先使用数值积分输出它的坐标点$(x,D(x))$。请帮我编写一段Python代码，目标是输出它的坐标点，自变量x的范围限制在(0.05,5)。请对求解思路或步骤进行详细解释，包括选择的数值积分方法。我从未使用过Python，请对代码进行详细注释。我的Obsidian中使用了Execute Code插件，可以运行python代码。python代码必须是全英文，不能出现中文字符。

### 三、使用数值积分求解德拜热容函数的坐标点

#### 求解思路与数值积分方法
为了得到精确的曲线，我们需要完成以下步骤：
定义被积函数：我们需要定义积分内部的函数 $\displaystyle f(t) = \frac{t^4 e^t}{(e^t - 1)^2}$。
注意奇点：当 $t=0$ 时，分母为 0。但在数学上，该函数的极限是 0（因为分子 $t^4$ 收敛速度比分母 $(e^t-1)^2 \approx t^2$ 更快）。我们在代码中需要处理这个除以零的临界情况。
确定积分区间：对于每一个自变量 $x$，积分的上限是 $1/x$。当 $x=0.05$ 时，上限是 $20$。当 $x=5$ 时，上限是 $0.2$。
选择数值积分方法：我们将使用 Gaussian Quadrature (高斯求积法)。
在 Python 的科学计算库 `scipy` 中，函数 `quad` 是处理此类定积分的标准工具。它非常精准，会自动调整步长以保证误差最小，非常适合处理这种物理函数的积分。
生成坐标点：我们将从 $x=0.05$ 到 $x=5$ 生成一系列密集的点（例如 100 个点），逐个计算积分值，最终输出符合 TikZ 格式的坐标对。

####  Python 代码
代码说明：Dependencies: 代码依赖 `numpy` (用于数学运算) 和 `scipy` (用于积分)。如果你运行报错提示 `ModuleNotFoundError`，你需要先在你的电脑终端(Terminal/Cmd)运行 `pip install numpy scipy`。


```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
import numpy as np
from scipy.integrate import quad
# ==========================================
# Configuration
# ==========================================
# Start of x range
x_start = 0.05
# End of x range
x_end = 3.0
# Number of points to calculate (more points = smoother curve)
num_points = 20

# Function Definitions
def integrand(t):
    """
    The function inside the integral: (t^4 * e^t) / (e^t - 1)^2
    """
    # Prevent division by zero error when t is extremely close to 0.
    # Mathematically, the limit of this function as t -> 0 is 0.
    if t < 1e-10:
        return 0.0
    
    try:
        # Calculate the numerator and denominator
        numerator = (t**4) * np.exp(t)
        denominator = (np.exp(t) - 1)**2
        return numerator / denominator
    except OverflowError:
        # Handle cases where exp(t) might be too large (though unlikely in this range)
        return 0.0

def debye_function(x):
    """
    Calculates D(x) = 3 * x^3 * Integral from 0 to 1/x
    """
    # 1. Calculate the integration coefficient: 3 * x^3
    coef = 3 * (x**3)
    # 2. Determine the upper limit of integration: 1/x
    upper_limit = 1.0 / x
    # 3. Perform the definite integral using Gaussian quadrature (quad)
    # quad returns a tuple (value, error), we only need the value [0]
    integral_result, _ = quad(integrand, 0, upper_limit)
    # 4. Return the final result
    return coef * integral_result

# ==========================================
# Main Execution & Output
# ==========================================

# Generate a list of x values linearly spaced between x_start and x_end
x_values = np.linspace(x_start, x_end, num_points)
# Prepare the string variable to store coordinates for TikZ
tikz_coordinates = ""

print("Calculating coordinates... Please wait.\n")
print("--- Copy the line below for your TikZ code ---")
print("")
# Loop through each x, calculate y, and format it
for x in x_values:
    y = debye_function(x)
    # Format as (x, y) with 4 decimal places
    tikz_coordinates += f"({x:.4f}, {y:.4f}) "

# Print the final result in one block
print(tikz_coordinates)
print("")
print("use \\draw plot coordinates{...} in tikz")
```


#### 绘制EinsteinDebye热容曲线

归一化德拜热容函数定义为 $\displaystyle D(x) = 3 x^3 \int_0^{1/x} \frac{t^4 e^t}{(e^t - 1)^2} \, dt$     其中： $\displaystyle x=\dfrac{T}{\theta_{D}}$ 
三维固体的爱因斯坦热容公式为：$\displaystyle 摩尔热容：C_{m}=3R*(\frac{θ_E}{T})^2*\frac{e^{\frac{θ_E}{T}}}{(e^{\frac{θ_E}{T}}-1)^2}$ 
记：$\displaystyle x=\frac{T}{\theta_{E}}$ ，则：$\displaystyle C_{m}=3R*{\frac{e^{1/x}}{x^2(e^{1/x}-1)^2}}$ ，则它的归一化形式为 $\displaystyle y=\frac{e^{1/x}}{x^2(e^{1/x}-1)^2}$ 

```tikz
\usetikzlibrary{fpu}
\begin{document}
\definecolor{myblue}{RGB}{30, 100, 235}
\definecolor{mygreen}{RGB}{60, 180, 90}
\begin{tikzpicture}[xscale=2,yscale=6,>=stealth]
\draw [->,thin](0,0)--(3.1,0)node[right=0.05cm,font=\large]{$\frac{T}{\theta}$};
\draw [->,thin](0,0)--(0,1.15)node[left=0.1cm,font=\large]{$\frac{C_m}{3R}$};
\draw[xstep=0.2,ystep=0.1,dotted,gray](0,0)grid(3,1);
\foreach \x in{1,2,3}
\draw [thin](\x,0)--(\x,0.03)node[below=0.2cm,font=\small]{\x};
\foreach \y in{0.2,0.4,...,1}
\draw [thin](0,\y)--(0.03,\y)node[left=0.2cm,font=\small]{\pgfmathprintnumber[fixed,precision=1]\y};

\draw[thick,myblue] plot[smooth] coordinates{(0.0500, 0.0097) (0.2053, 0.3841) (0.3605, 0.7005) (0.5158, 0.8346) (0.6711, 0.8972) (0.8263, 0.9304) (0.9816, 0.9500) (1.1368, 0.9624) (1.2921, 0.9707) (1.4474, 0.9765) (1.6026, 0.9808) (1.7579, 0.9840) (1.9132, 0.9865) (2.0684, 0.9884) (2.2237, 0.9900) (2.3789, 0.9912) (2.5342, 0.9923) (2.6895, 0.9931) (2.8447, 0.9938) (3.0000, 0.9945)};
\begin{scope}
\pgfkeys{/pgf/fpu=true,/pgf/fpu/output format=fixed}
\draw[thick,mygreen] plot[domain=0.05:3,samples=30,smooth](\x,{exp(1/\x)/((\x^2)*((exp(1/\x)-1)^2)});
\end{scope}
\draw[thick,myblue](2,0.8)--(2.2,0.8)node[right=0.1cm,font=\small]{$Debye$};
\draw[thick,mygreen](2,0.7)--(2.2,0.7)node[right=0.1cm,font=\small]{$Einstein$};
\end{tikzpicture}
\end{document}
```


### 数值定积分函数quad
`scipy.integrate.quad` 是 SciPy 中最常用、最强大的数值定积分函数。它基于 Fortran 的 QUADPACK 库（主要是 QAG、QAGI、QAGS 等算法的自适应算法）实现，能够处理大部分常见的定积分问题，包括无限区间、奇点、振荡积分、加权积分等。

#### 函数签名

```python
from scipy.integrate import quad

quad(
    func,               # 被积函数
    a,                  # 下限（可为 -np.inf）
    b,                  # 上限（可为 np.inf）
    args=(),            # 传递给 func 的额外参数（元组）
    full_output=0,      # 是否返回详细积分信息
    epsabs=1.49e-08,    # 绝对误差容差
    epsrel=1.49e-08,    # 相对误差容差
    limit=50,           # 子区间最大分割数
    points=None,        # 人为指定的内部奇点位置（list/array）
    weight=None,        # 加权类型（'cos','sin','cauchy' 等）
    wvar=None,          # 权重函数的参数（ω）
    wopts=None,         # 权重相关选项（较少用）
    maxp1=50,           # 当使用权 'alg' 或 'alg-loga' 时的参数
    limlst=50,          # sin/cos 权重时周期数上限
    complex_func=False  # 是否允许被积函数返回复数（1.4.0+）
)
```

最常见的三种调用方式对应的返回值：

| full_output 值 | 返回内容                                | 说明                |
| ------------- | ----------------------------------- | ----------------- |
| 0（默认）         | `(积分值, 误差估计)`                       | 最常用               |
| 1             | `(积分值, 误差估计, infodict)`             | infodict 包含详细诊断信息 |
| >1（通常2）       | `(积分值, 误差估计, infodict, neval, ier)` | 几乎所有信息都返回（调试用）    |

其中 `infodict` 常见字段：
`neval`：函数被调用次数；`last`：使用的子区间数；`rlist`、`elist`、`iord`：内部工作数组（调试用）

常用参数详解

| 参数     | 典型值                    | 作用                        | 建议场景            |
| ------ | ---------------------- | ------------------------- | --------------- |
| epsabs | 1e-8 ~ 1e-12           | 希望达到的绝对误差                 | 积分值本身很大时调小      |
| epsrel | 1e-8 ~ 1e-10           | 希望达到的相对误差                 | 积分值接近0或很小时更重要   |
| limit  | 50（默认）→500             | 允许的最大子区间数（大致对应分割次数）       | 振荡严重、奇点多时增大     |
| points | [0.5, 1.2, 3.0]        | 告诉算法这些点附近可能有不连续/奇点，优先细分   | 已知间断点、对数奇点等     |
| weight | 'cos','sin','cauchy' 等 | 选择专门的加权积分算法               | 振荡积分、无穷区间带权重时必用 |
| wvar   | 频率ω 或位置c               | weight 的参数（如 cos(ωx) 的 ω） | 与 weight 配套     |

#### 典型使用场景

Obsidian中，使用python求数值积分，帮我给下面这段python代码的每一行补充详细英文注释。并介绍相关命令的完整语法。我使用的插件是Execute Code.

1. 普通有限区间积分

```run-python
# Import the quad function from scipy's integrate module
# quad is the most commonly used function for numerical quadrature (1D definite integration)
from scipy.integrate import quad

# Import numpy and give it the conventional alias 'np'
# We use numpy for mathematical functions like sin, pi, etc.
import numpy as np

# Define the function we want to integrate
# This is the integrand function f(x) that quad will numerically integrate
def f(x):
    # Return sin(x). Using np.sin instead of math.sin allows vectorized operation
    # (although quad calls the function scalarly, it's still good practice)
    return np.sin(x)

# Call quad to compute the definite integral of f(x) from 0 to π
# quad returns a tuple: (integral_value, estimated_absolute_error)
I, err = quad(f, 0, np.pi)
#              │   │   └───── upper limit of integration (can be number or np.inf)
#              │   └───────── lower limit of integration
#              └───────────── the callable function to integrate

# Print the result with high precision for the integral value
# and scientific notation for the error estimate
# :.10f → float with 10 digits after decimal point
# :.2e  → scientific notation with 2 digits after decimal
print(f"integrate = {I:.4f} ± {err:.2e}")
```

2. 带参数的函数

```run-python
# Import necessary libraries
import numpy as np
from scipy.integrate import quad

# Define the integrand function: g(x) = exp(-a x) * sin(b x)
def g(x, a, b):
    """
    The function to be integrated.
    
    Parameters:
    -----------
    x : float
        The independent variable (integration variable)
    a : float
        Decay constant (positive value makes it decay)
    b : float
        Angular frequency of the sine oscillation
    
    Returns:
    --------
    float
        Value of the function at point x
    """
    return np.exp(-a * x) * np.sin(b * x)


# ==================== Main integration part ====================

# Parameters of the function
a_value = 2.5    # decay rate
b_value = 3.0    # oscillation frequency

# Very important: control the accuracy of numerical integration
I, err = quad(
    func=g,                     # the function to integrate
    a=0,                        # lower limit of integration
    b=np.inf,                   # upper limit of integration (infinite)
    args=(a_value, b_value),    # extra arguments passed to func
    
    # ── Most important precision control parameters ──
    epsabs=1e-6,               # absolute error tolerance (try 1e-8 to 1e-14)
    epsrel=1e-6,               # relative error tolerance (usually same order as epsabs)
    
    # ── When the function oscillates a lot or has sharp peaks ──
    limit=1000,                 # maximum number of subintervals (default=50, increase if needed)
    
    # Optional: if you know there are singularities, you can tell quad
    # points=[...],             # list of points where function may be singular
    
    # For highly oscillatory integrals, you can use weight='sin' or 'cos'
    # weight='sin', wvar=b_value,   # <-- only if you really need it
)

# Print results with high precision formatting
print(f"Integral value   = {I:.3e}")
print(f"Estimated error  = {err:.3e}")
print(f"Error / |I|      = {err / abs(I):.3e}" if abs(I) > 1e-20 else "Error / |I|      = N/A (integral too small)")
```

3. 无限区间（最常见写法）

```run-python
# 导入必要的库
import numpy as np 
from scipy.integrate import quad 
# 计算定积分 ∫_0^∞ e^(-x²) dx 
# 这个积分的解析解是 √π /2 ≈ 0.886226925452758 
# 使用 scipy.integrate.quad 函数进行数值积分： 
# lambda x: ...`功能：定义一个匿名函数（inline function），常用于简单的一次性函数。
# lambda 参数: 表达式
# f = lambda x: x**2 + 1 
# 等价于 def f(x): return x**2 + 1
# - 第一个参数是一个可调用对象（这里是 lambda 表达式），表示被积函数 f(x) 
# - 第二个参数是积分下限 a = 0 
# - 第三个参数是积分上限 b = np.inf（表示正无穷） 
# quad 返回一个元组 (积分值, 估计误差) 
# absolute error tolerance (try 1e-8 to 1e-14)
# relative error tolerance (usually same order as epsabs)
I, err = quad(lambda x: np.exp(-x*x), 0, np.inf,epsabs=1e-11,epsrel=1e-11) 
# 可选：打印结果以验证 
print(f"积分值 I = {I:.12f}") 
print(f"估计误差 err = {err:.3e}")
print(f"解析解 √π/2 ≈ {np.sqrt(np.pi)/2:.12f}")
```

4. 已知奇点（points 参数）
Obsidian中，使用python求数值积分，帮我给下面这段python代码的每一行补充详细英文注释。并介绍相关命令的完整语法。我使用的插件是Execute Code.
```run-python
# 导入必要的科学计算库（虽然原代码没写，但实际运行必须导入） 
import numpy as np 
from scipy.integrate import quad 
# 定义被积函数 h(x) 
# 该函数在 x = 1 处存在对数型奇点（实际上是一个可积的代数奇点：1/sqrt(|x-1|)） 
# 当 x → 1 时，分母趋近于 0，函数值趋于无穷大，但积分仍收敛 
def h(x): 
# np.abs(x - 1)：计算 x 与 1 的绝对值距离，避免负数开平方 
# np.sqrt(...)：取平方根 # 1 / ... ：取倒数，形成 1/sqrt(|x - 1|) 的形式 
# 函数体内的 `return` 语句必须**缩进**（通常用 4 个空格或一个 Tab）。
	return 1 / np.sqrt(np.abs(x - 1)) 
# 使用 scipy.integrate.quad 对 h(x) 在区间 [0, 2] 上进行数值积分 
# 因为被积函数在 x=1 处不连续（有奇点），需通过 points=[1] 显式告知积分器该点 
I, err = quad( 
h, # 被积函数（callable） 
0, # 积分下限 a 
2, # 积分上限 b 
epsabs=1.49e-06, # 绝对误差容限 
epsrel=1.49e-06, # 相对误差容限 
limit=50, # 最大子区间数（用于自适应积分）
points=[1] # 可选参数：指定积分区间内已知的奇点或不连续点位置 
)
print(f"积分值 I = {I:.8f}") 
print(f"估计误差 err = {err:.3e}")
```

5. 振荡积分（weight + wvar）

```python
# ∫₀^∞ sin(50x)/x dx ≈ π/2 （Dirichlet积分）
I, err = quad(lambda x: np.sin(x)/x if x!=0 else 1,
              0, np.inf,
              weight='sin', wvar=50)
```

6. 返回更多诊断信息

```python
# 导入必要的模块（注意：在 Execute Code 插件中可能需要显式导入） 
import numpy as np 
from scipy.integrate import quad 
# 调用 scipy.integrate.quad 函数计算定积分： 
# 被积函数为 f(x) = 1 / sqrt(x)，积分区间为 [0, 1] 
# 注意：该函数在 x=0 处有可积奇点（瑕积分），quad 能自动处理此类情况 
res = quad( lambda x: 1/np.sqrt(x), 
# 被积函数：匿名函数，输入 x，返回 1/sqrt(x) 
0, # 积分下限 a = 0 
1, # 积分上限 b = 1 
full_output=1, # 设置为 True（或 1）时，返回额外信息字典 info 
epsabs=1e-10, # 绝对误差容限：要求 |真实值 - 计算值| < 1e-10 
epsrel=1e-10 # 相对误差容限：要求 |误差| / |积分值| < 1e-10 
) 
# 解包 quad 的返回结果： 
# 当 full_output=True 时，quad 返回一个三元组 (integral, error, info_dict) 
integral, err, info = res 
# 打印积分结果，保留12位小数 
print(f"积分 = {integral:.12f}") 
# 打印误差估计值，使用科学计数法（两位有效数字） 
print(f"误差估计 = {err:.2e}") 
# 打印被积函数实际被调用的次数（用于评估计算开销） 
print(f"函数调用次数 = {info['neval']}") 
# 打印自适应积分过程中使用的子区间数量（反映算法复杂度） 
print(f"子区间数 = {info['last']}")
```

#### 精度控制建议

| 目标精度    | epsabs        | epsrel      | limit 建议值 | 备注             |
| ------- | ------------- | ----------- | --------- | -------------- |
| 默认 / 常规 | 1.5e-8        | 1.5e-8      | 50        | 大多数科学计算够用      |
| 高精度     | 1e-10 ~ 1e-12 | 1e-10       | 100–500   | 物理量、参数拟合       |
| 极高精度    | 1e-13 ~ 1e-14 | 1e-12       | 1000+     | 需要配合 points 参数 |
| 积分值 ≈ 0 | 1e-12         | 1e-6 ~ 1e-8 | 50–200    | 相对误差主导         |

#### 总结

`quad` 是 SciPy 中“万能型”数值积分利器：只要不是极强振荡、极多奇点、极高维的积分问题，quad 通常都是首选，配合适当的 `points`、`weight`、`limit` 参数，绝大多数实际工程和科研中的一维定积分都能得到可靠结果。




### 微积分基本定理

更准确地说，这个结论涉及到了两个重要的数学性质：连续函数的可积性 以及 变限积分的连续性。

#### 连续函数的可积性
如果函数 $f(x)$ 在闭区间 $[a, b]$ 上是连续的。那么，可积性：$f(x)$ 在 $[a, b]$ 上是黎曼可积的。

#### 变限积分的连续性
如果函数 $f(x)$ 在闭区间 $[a, b]$ 上是连续的。原函数的存在性与连续性：定义一个变上限积分函数 $F(x) = \int_a^x f(t) \, dt$。这个函数 $F(x)$ 不仅在 $[a, b]$ 上是连续的，而且它是可导的，且满足 $F'(x) = f(x)$。

这个定理连接了微分和积分这两个看似无关的概念：
连续性保证了可积性：并不是所有的函数都能求积分，但只要函数是连续的（甚至只有有限个第一类间断点），它就是可积的。
光滑度的提升：这是一个非常有趣的现象。如果 $f(x)$ 只是连续的，它的积分 $F(x)$ 就会比它“更光滑”一步——即 $F(x)$ 是可导的。在数学上，这意味着积分过程具有某种“平滑化”的作用。

虽然你提到不定积分是连续的，但在数学严谨性上，我们通常讨论的是变限积分（定积分的一种形式）。
因为 $F(x)$ 是可导的（$F'(x) = f(x)$），根据“可导必连续”的原则，$F(x)$ 必然是连续的。
即便 $f(x)$ 在某些点是不连续的（例如有跳跃间断点），它的变限积分 $F(x)$ 往往仍然是连续的，只是在那些点上可能不可导。
    








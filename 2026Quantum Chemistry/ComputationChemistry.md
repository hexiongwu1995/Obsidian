---
math-engine: mathjax
---


### 波函数从符号到向量
波函数\psi，通常是一个符号表达式，物理含义是所有电子在三维笛卡尔坐标系统中可能出现的位置坐标，怎么会可以使用向量或矩阵来代替？
这是一个非常深刻且直指量子力学本质的问题！你感到困惑是非常正常的，因为这触及了量子力学的两种不同表述形式：波动力学（Wave Mechanics，薛定谔创立）与矩阵力学（Matrix Mechanics，海森堡创立）。简单来说，你所理解的“符号表达式”和代码中的“矩阵/向量”其实是同一个东西在不同“语言”下的描述。为了让你理解这一点，我们需要引入“基（Basis）”的概念。

波函数可以表示为一个向量
在经典物理或几何中，我们习惯了向量（Vector）的概念。试想一个二维平面上的向量 $\vec{v}$：抽象来看： 它是一个空间中的箭头，具有大小和方向。坐标表示： 如果我们选定一组基底（比如 $x$ 轴和 $y$ 轴单位向量 $\hat{i}, \hat{j}$），这个向量可以写成：$\vec{v} = 3\hat{i} + 4\hat{j}$。数组表示： 在计算机或线性代数中，我们通常只记录它的系数，把它写成列向量：$\begin{pmatrix} 3 \\ 4 \end{pmatrix}$。在量子力学中，波函数 $|\psi\rangle$ 本质上也是希尔伯特空间（Hilbert Space）中的一个抽象向量。

连续 vs 离散
你理解的 $\psi(x)$： 这是在连续的“位置基”下的表示。这就好比我们在无限维的空间里，列出了每个坐标点 $x$ 上的投影值。
代码中的 $\psi$（向量）： 这是在离散的“能量基”或“轨道基”下的表示。

**薛定谔方程的矩阵形式**
假设我们研究的系统不是在一个无限大的空间里自由运动，而是被限制在少数几个状态中（比如电子只能在两个特定的轨道之间跳跃，或者电子的自旋只有“上”和“下”）。这时，我们不需要无限多的坐标 $x$，我们只需要一组有限的基函数（Basis Functions），记为 $\phi_1, \phi_2, ..., \phi_n$。任意一个波函数 $\psi$ 都可以写成这些基函数的叠加：$\psi = c_1 \phi_1 + c_2 \phi_2 + ... + c_n \phi_n$
这里的 $c_1, c_2, ...$ 是复数系数（表示概率幅）。计算机里的“波函数向量”，存储的实际上就是这些系数 $c_i$。

回到你的代码：`eigenvectors` 里的每一列，比如 `[0.8, 0.6]`，意思并不是电子位于坐标 0.8 和 0.6。它的意思是：$\psi = 0.8 \times (\text{状态1}) + 0.6 \times (\text{状态2})$。

```python
# 求解本征值问题，在量子力学中，薛定谔方程 $\hat{H}\psi = E\psi$ 是一个本征值问题：
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")
import numpy as np

# 定义哈密顿矩阵：`H = np.array([[-1.0, 0.5], [0.5, 1.0]])`：创建一个2×2的实对称矩阵$H$。
#在量子力学中，这个矩阵代表哈密顿算符$\hat{H}$（Hamiltonian operator），用于描述系统的总能量。
# 矩阵的对称性确保它是Hermitian的（即$\hat{H}^\dagger = \hat{H}$），这在量子力学中是必需的，以保证本征值（能量）为实数，本征向量正交。

H = np.array([
    [-1.0,  0.5],
    [ 0.5,  1.0]
])
# 求解本征值和本征向量：
eigenvalues, eigenvectors = np.linalg.eigh(H)
# 打印能量本征值：
print("能量本征值（单位：eV）：")
for i, E in enumerate(eigenvalues):
    print(f"E{i+1} = {E:.4f} eV")
print() 
# 打印本征向量：
print("本征向量（已经归一化）：")
for i in range(len(eigenvalues)):
    print(f"ψ{i+1} = {eigenvectors[:, i]}")
# 检查归一化：验证范数接近1（由于数值精度，通常为1.0000），这确认本征向量已被归一化，在量子力学中对应波函数的概率解释（$\int |\psi|^2 dV = 1$）。
norm = np.linalg.norm(eigenvectors[:, 0])
print(f"\n第一个本征向量的模（应接近1）：{norm:.4f}")
```

代码的物理含义
这段代码的物理核心是求解时间独立的薛定谔方程$\hat{H} \psi = E \psi$，这是量子力学中描述定态（stationary states）的基本方程：
- $\hat{H}$ 是哈密顿算符，代表系统的总能量，包括动能、势能和相互作用。
- $E$ 是能量本征值，表示系统的可能能量水平（在测量时，系统会坍缩到其中一个$E_i$）。
- $\psi$ 是本征函数（在这里是向量），描述系统的量子态。归一化确保概率守恒。

具体到这个2×2矩阵：
- 对角元素（$-1.0$ 和 $1.0$）代表两个“基态”的固有能量（diagonal elements as site energies）。例如，如果没有耦合，非对角元素为0，则能量就是$-1$ eV 和 $1$ eV。
- 非对角元素（$0.5$）代表两个态之间的耦合强度（off-diagonal coupling），如隧道效应或相互作用，导致能量分裂（energy splitting）。本征值$\pm \sqrt{1.25} \approx \pm 1.118$ eV 显示了这种分裂：原本相差$2$ eV 的能级由于耦合而“混合”，形成新的能级。
- 本征向量表示混合态：每个$\psi_i$ 是两个基态的线性组合，系数反映了混合比例（例如，$\psi_1$ 中第一个基态的权重更大）。

在量子力学中，这种计算揭示系统的定态能量谱和波函数，用于预测光谱、跃迁概率等。单位eV暗示这是一个原子或分子尺度系统（如电子能级），但数值是任意的（可能是简化模型）。

对应的物理模型：这个2×2 Hermitian矩阵对应一个二能级系统（two-level system, TLS），这是量子力学中最简单的非平凡模型，常用于近似更复杂系统。可能的具体物理模型包括：量子比特（Qubit）或自旋1/2系统，分子中的隧道效应（Tunneling in molecules），紧束缚模型（Tight-binding model）中的双原子系统，Rabi振荡或光-物质相互作用。

总体上，代码是一个简单的数值模拟，演示如何用线性代数工具解决量子力学中的本征值问题。没有实际绘图或进一步分析，但注释明确指向薛定谔方程。


代码中的物理模型
你的代码中 $H$ 是一个 $2 \times 2$ 矩阵，这通常对应于二能级系统（Two-level System）。这是量子力学中最简单的模型，常见于：
电子自旋（Spin）： 电子只有“自旋向上 $\uparrow$”和“自旋向下 $\downarrow$”两个基态。
基底 $\phi_1 = |\uparrow\rangle$，基底 $\phi_2 = |\downarrow\rangle$。波函数就是一个二维复向量：$\begin{pmatrix} c_1 \\ c_2 \end{pmatrix}$。

紧束缚模型（Tight-binding Model）： 假设电子只能在两个原子 A 和 B 之间跳跃。
基底 $\phi_1$ = 电子在原子 A 上。基底 $\phi_2$ = 电子在原子 B 上。

薛定谔方程的转化：连续形式： $-\frac{\hbar^2}{2m}\nabla^2\psi + V\psi = E\psi$ （这是微分方程）。矩阵形式： $H \mathbf{c} = E \mathbf{c}$ （这是线性代数方程）。
你的代码正在做的，就是求解这个线性代数方程。

总结与对比：

| 特性    | 波动力学 (Wave Mechanics)   | 矩阵力学 (Matrix Mechanics)                |
| ----- | ----------------------- | -------------------------------------- |
| 主要人物  | 薛定谔 (Schrödinger)       | 海森堡 (Heisenberg)                       |
| 波函数形式 | 连续函数 $\psi(x)$          | 列向量 $\mathbf{c} = [c_1, c_2, \dots]^T$ |
| 算符形式  | 微分算符 (如 $\frac{d}{dx}$) | 矩阵 $H_{ij}$                            |
| 适用场景  | 粒子在空间中运动（如氢原子轨道）        | 离散系统（如自旋、量子计算、晶格模型）                    |
| 代码对应  | 需要数值积分求解微分方程            | `numpy.linalg.eig` 求解矩阵特征值             |

解释代码输出：代码中计算出的 `eigenvectors`（本征向量），假设输出是 $[0.707, 0.707]$ ，这意味着系统处于通过 $H$ 矩阵算出的那个能量级别时，电子处于“状态1”的概率幅是 0.707，处于“状态2”的概率幅也是 0.707。它不是位置坐标，而是状态叠加的权重。


### 波函数的向量表达形式
为了让你直观地看到“连续函数”是如何变成“矩阵”的，我们将使用量子力学中最经典的入门模型：一维无限深势阱（Particle in a Box）。这个过程在计算物理中被称为离散化（Discretization）。核心思路：像素化

想象你在纸上画了一条正弦波曲线 $\psi(x)$。解析（连续）视角：这是一条完美的、没有断点的线。矩阵（离散）视角：你在曲线上等距离取了 $N$ 个点（比如 100 个）。现在，你不需要记录整条线，只需要记录这 100 个点的纵坐标高度。这 100 个高度组成的数组，就是我们的“波函数向量”。

数学原理：从微分到差分
薛定谔方程中有一项是动能项，包含二阶导数：$\displaystyle -\frac{\hbar^2}{2m} \frac{d^2\psi}{dx^2}$ ，在计算机里，我们无法处理无限小的 $dx$，我们把它变成一个很小的有限距离 $\Delta x$。根据有限差分法，二阶导数可以近似为：$\displaystyle \frac{d^2\psi}{dx^2} \approx \frac{\psi_{i+1} - 2\psi_i + \psi_{i-1}}{(\Delta x)^2}$ ，这不仅是个公式，它告诉我们要计算第 $i$ 个点的情况，需要用到它左边 $i-1$ 和右边 $i+1$ 的点。这就形成了一种近邻联系。当我们把所有点的方程写在一起，就会形成一个三对角矩阵（Tridiagonal Matrix）。

```python
np.set_printoptions(
    precision=None,       # 浮点数显示的小数位数
    threshold=None,       # 数组元素超过多少时显示省略号 ...
    edgeitems=None,       # 省略时，两端各保留几个元素
    linewidth=None,       # 每行最多多少个字符
    suppress=None,        # 是否抑制科学计数法
    nanstr=None,          # NaN 的显示字符串
    infstr=None,          # inf 的显示字符串
    formatter=None,       # 自定义格式化字典
    sign=None,            # 数字前的符号（' ', '+', '-'）
    floatmode=None,       # 浮点显示模式 ('fixed', 'unique', 'maxprec' 等）
    *,                    # 以下为仅限关键字参数
    legacy=None,          # 兼容旧版输出格式
    override_repr=None    # 是否覆盖 __repr__ （较新版本才有）
)
```


Python 代码演示：这段代码将把一个连续的空间切成 $N$ 个点，构建哈密顿矩阵 $H$，并求解它的本征向量。请运行这段代码，通过生成的图像，你将彻底明白为什么“向量就是波函数”。

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt
np.set_printoptions(precision=5,threshold=10,edgeitems=4,linewidth=200,suppress=True)
# === 1. 参数设置 ===
# 为了简化，我们设 h_bar = 1, m = 1
L = 1.0           # 势阱宽度
N = 101           # 我们把空间切成 100 个离散点（像素）
x = np.linspace(0, L, N) # 生成 x 坐标点：0, 0.01, 0.02 ...
dx = x[1] - x[0]  # 网格间距

# === 2. 构建哈密顿矩阵 (矩阵力学部分) ===
# 动能部分：T = -1/2 * d^2/dx^2
# 使用有限差分公式构建三对角矩阵
# 主对角线系数为 2，次对角线为 -1
# 系数 factor = -0.5 / (dx^2) 实际上在差分公式里对应 -1/(2*dx^2)
# 但因为差分算子本身是 (psi[i+1] - 2psi[i] + psi[i-1]), 
# 结合动能算符前面的 -0.5，最终对角线是 1/(dx^2), 非对角线是 -0.5/(dx^2)

t0 = 1.0 / (dx**2)       # 主对角线元素
t1 = -0.5 / (dx**2)      # 次对角线元素

# 初始化为全0矩阵
H = np.zeros((N, N))

# 填充矩阵
for i in range(N):
    H[i, i] = t0
    if i > 0:
        H[i, i-1] = t1
    if i < N-1:
        H[i, i+1] = t1

# 边界条件：在无限深势阱中，两端波函数为0。
# 在这个矩阵模型中，我们不需要额外处理，因为矩阵边缘之外默认为0。
# 输出哈密顿矩阵
print("哈密顿矩阵为：")
print(H)
# === 3. 求解本征值 (Solver) ===
# 这就是你在上一个代码中做的事情，只是现在的矩阵是 100x100
eigenvalues, eigenvectors = np.linalg.eigh(H)
# === 4. 可视化结果 (连接 向量 与 函数) ===
plt.figure(figsize=(5, 3))

# 我们绘制前 3 个能级
for i in range(3):
    print(f"\n \n eigenvalues[{i}]为：{eigenvalues[i]:.5f}")
    print(f"\n \n eigenvectors[{i}]为：",eigenvectors[i])
    #print(eigenvectors[i])
    psi = eigenvectors[:, i] # 取出第 i 列向量

    # 归一化处理（为了和解析解对比幅值）
    # 离散归一化条件是 sum(|psi|^2 * dx) = 1
    psi = psi / np.sqrt(dx) 
    
    # 为了图像好看，可能需要调整正负号
    if psi[1] < 0: psi = -psi
    
    # 绘制“向量”（用散点表示，强调它是离散的）
    # plt.scatter(x, psi + eigenvalues[i], s=10, label=f'Matrix Vector (n={i+1})')
    plt.scatter(x, psi, label=f'Matrix Vector (n={i+1})')
    # 绘制“解析解”（连续的正弦函数，作为对比）
    # 理论解：sqrt(2/L) * sin(n * pi * x / L)
    psi_exact = np.sqrt(2/L) * np.sin((i+1) * np.pi * x / L)
    # plt.plot(x, psi_exact + eigenvalues[i], alpha=0.5, linestyle='--', color='black')
    plt.plot(x, psi_exact, alpha=0.5, linestyle='--', color='black')
    
plt.title("Wave Function: Matrix Vector vs Continuous Function")
plt.xlabel("Position x")
# plt.ylabel("Energy (shifted for visualization)")
plt.ylabel("Probability Amplitude")
plt.legend()
plt.grid(True)
plt.show()

print(f"\n\n基态能量 (解析解): {(np.pi**2)/(2*L**2):.4f}") # E = n^2 * pi^2 * h^2 / (2mL^2), h=1, m=1
print(f"基态能量 (矩阵解): {eigenvalues[0]:.4f}")
```


代码中的关键点解释
矩阵 $H$ 长什么样：如果你把 `H` 打印出来，它大概长这样（大部分是0）：

$$H = A \cdot \begin{pmatrix} 2 & -1 & 0 & \cdots \\ -1 & 2 & -1 & \cdots \\ 0 & -1 & 2 & \cdots \\ \vdots & \vdots & \vdots & \ddots \end{pmatrix}$$

每一行其实代表了一个位置点 $x_i$。矩阵乘法 $H \psi$ 的过程，就是在对每个点做“差分运算”，也就是在算“二阶导数”。

向量 `psi` 是什么：代码中的 `eigenvectors[:, 0]` 是一个长度为 100 的数组 `[0.0, 0.15, 0.30, ..., 0.0]`。
索引 $i$：代表位置 $x = i \cdot \Delta x$。数值 `psi[i]`：代表在这个位置发现电子的概率幅。
结果对比：当你运行代码后，你会看到彩色的散点（矩阵算出来的向量）完美地落在黑色的虚线（数学公式算出来的 $\sin$ 函数）上。散点就是矩阵力学。虚线就是波动力学。当点取得足够密（$N \to \infty$），它们就是完全一样的。现在你明白了空间可以被“切碎”变成矩阵。

**二阶导数近似公式的证明**
我们要证明的公式是：$\displaystyle f''(x) \approx \frac{f(x+\Delta x) - 2f(x) + f(x-\Delta x)}{(\Delta x)^2}$
证明的工具是泰勒展开（Taylor Expansion）。泰勒展开告诉我们，只要 $\Delta x$ 足够小，我们可以通过 $x$ 点的值和导数来预测 $x + \Delta x$ 处的值。

向右展开：我们将函数 $f(x + \Delta x)$ 在 $x$ 处展开：$\displaystyle f(x + \Delta x) = f(x) + f'(x)\Delta x + \frac{1}{2}f''(x)(\Delta x)^2 + \frac{1}{6}f'''(x)(\Delta x)^3 + O((\Delta x)^4)$ （注：$O((\Delta x)^4)$ 代表更高阶的无穷小量，我们可以暂时忽略）

向左展开：同样的，我们将函数 $f(x - \Delta x)$ 在 $x$ 处展开（注意 $\Delta x$ 变成了 $-\Delta x$）：$\displaystyle f(x - \Delta x) = f(x) - f'(x)\Delta x + \frac{1}{2}f''(x)(\Delta x)^2 - \frac{1}{6}f'''(x)(\Delta x)^3 + O((\Delta x)^4)$

两式相加：如果我们把两式相加，奇数项就会互相抵消（这一步非常巧妙，消掉了一阶导数，只留下了我们想要的二阶导数）： $\displaystyle f(x + \Delta x) + f(x - \Delta x) \approx 2f(x) + f''(x)(\Delta x)^2$

反解出二阶导数：现在我们要把 $f''(x)$ 孤立出来：
移项：$\displaystyle f''(x)(\Delta x)^2 \approx f(x + \Delta x) + f(x - \Delta x) - 2f(x)$ ，除以 $(\Delta x)^2$： $\displaystyle f''(x) \approx \frac{f(x + \Delta x) - 2f(x) + f(x - \Delta x)}{(\Delta x)^2}$
证毕。 这就是著名的中心差分公式（Central Difference Formula）。

#### 哈密顿矩阵的构建过程
有了上面的公式，我们就可以把薛定谔方程变成矩阵了。
一维定态薛定谔方程是：$\displaystyle -\frac{\hbar^2}{2m} \frac{d^2\psi}{dx^2} + V(x)\psi(x) = E\psi(x)$ ，为了简化书写，我们令常数系数 $A = -\frac{\hbar^2}{2m}$。
方程变为：$\displaystyle A \cdot \psi''(x) + V(x)\psi(x) = E\psi(x)$ 

我们把空间切成 $N$ 个离散点：$x_0, x_1, ..., x_i, ..., x_{N-1}$。对应的波函数值记为：$\psi_0, \psi_1, ..., \psi_i, ..., \psi_{N-1}$。

将差分公式代入第 $i$ 个点
对于任意第 $i$ 个点，我们将二阶导数替换为差分公式：$\displaystyle A \cdot \left[ \frac{\psi_{i+1} - 2\psi_i + \psi_{i-1}}{(\Delta x)^2} \right] + V_i \psi_i = E \psi_i$
为了方便构建矩阵，我们需要把含有相同 $\psi$ 的项合并。令 $\displaystyle t = \frac{A}{(\Delta x)^2} = -\frac{\hbar^2}{2m(\Delta x)^2}$。
方程展开整理为：$\displaystyle t \cdot \psi_{i+1} - 2t \cdot \psi_i + t \cdot \psi_{i-1} + V_i \psi_i = E \psi_i$
按 $\psi$ 的下标顺序排列（这是构建矩阵的关键一步）：$\displaystyle (t) \cdot \psi_{i-1} + (V_i - 2t) \cdot \psi_i + (t) \cdot \psi_{i+1} = E \psi_i$
请仔细看这个式子：这告诉我们，要计算第 $i$ 个点的能量贡献，我们需要用到：左边的点 $\psi_{i-1}$，系数是 $t$。自己的点 $\psi_i$，系数是 $(V_i - 2t)$。右边的点 $\psi_{i+1}$，系数是 $t$。

构建矩阵 $H$
矩阵方程的形式是 $H \vec{\psi} = E \vec{\psi}$。矩阵 $H$ 的第 $i$ 行，代表第 $i$ 个点的方程。矩阵的第 $j$ 列，代表 $\psi_j$ 的系数。让我们写出前几行：

第 0 行 ($i=0$)：方程涉及 $\psi_{-1}$（边界外，设为0）。系数：对角线 $H_{0,0} = (V_0 - 2t)$，右邻 $H_{0,1} = t$。
$\psi_0$、$\psi_1$。$\displaystyle H_{0,0}\psi_0 + H_{0,1}\psi_1 = E\psi_0$ 

第 1 行 ($i=1$)：方程涉及 $\psi_0, \psi_1, \psi_2$。
$\displaystyle t \cdot \psi_0 + (V_1 - 2t) \cdot \psi_1 + t \cdot \psi_2 = E \psi_1$
对应矩阵元素：
$H_{1,0} = t$ （左邻）
$H_{1,1} = V_1 - 2t$ （自己）
$H_{1,2} = t$ （右邻）

第 2 行 ($i=2$)：方程涉及 $\psi_1, \psi_2, \psi_3$。
对应矩阵元素：
$H_{2,1} = t$
$H_{2,2} = V_2 - 2t$
$H_{2,3} = t$

最终矩阵形态：三对角矩阵。把上面所有的行拼起来，矩阵 $H$ 就长这样：

$$H = \begin{pmatrix} (V_0 - 2t) & t & 0 & 0 & \cdots \\ t & (V_1 - 2t) & t & 0 & \cdots \\ 0 & t & (V_2 - 2t) & t & \cdots \\ 0 & 0 & t & (V_3 - 2t) & \cdots \\ \vdots & \vdots & \vdots & \vdots & \ddots \end{pmatrix}$$
为什么是三对角？
物理原因： 二阶导数描述的是“弯曲程度”，也就是局部曲率。要知道一个点弯不弯，只需要看它紧邻的左右两点。它不需要知道远处点的情况。
数学原因： 差分公式 $\psi_{i-1}, \psi_i, \psi_{i+1}$ 只包含 3 项。所以在矩阵的每一行里，只有 $i-1, i, i+1$ 这三个位置有非零元素，其他位置全是 0。
这就是为什么你在 Python 代码中看到了 `if i > 0: H[i, i-1] = t1` 和 `if i < N-1: H[i, i+1] = t1` 这样的逻辑。

注意系数符号：在之前的 Python 代码中，因为我们将动能项前面的负号放进了系数计算里，或者把项移到了等号右边，最终通常表现为：主对角线是正数（对应 $2t$ 和 $V$ 的组合）。次对角线是负数（对应 $-t$）。具体符号取决于你是写成 $H\psi = E\psi$ 还是 $-H\psi = -E\psi$，但在无限深势阱中，主对角线通常是绝对值最大的正值。



#### Hückel分子轨道理论示例

对于共轭体系（如丁二烯），我们可以用Hückel理论计算π电子能级：

```python
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")
import numpy as np

#    计算丁二烯 (butadiene, C4H6) 的Hückel分子轨道理论结果
#    物理背景：
#    丁二烯是典型的共轭π体系，含有4个π电子，分布在4个p轨道上。
#    Hückel方法只考虑相邻原子之间的共轭作用（即β积分），忽略远距离作用和σ骨架。
#    在Hückel近似中：
#        • α：Coulomb积分（单个碳原子2p轨道的能量），通常设为能量零点
#        • β：共振积分（相邻两个2p轨道之间的相互作用），β < 0，所以能量越低越稳定

def huckel_butadiene():
    # 构建4×4 Hückel哈密顿矩阵（能量单位以β为基准，α已设为0）
    # 矩阵元素含义：
    #   对角元 H_{ii} = 0     → 代表 α（已减去α，归零）
    #   相邻位置 H_{i,i+1} = 1 → 代表 β（实际是β，但在Hückel中常把β取为-1作单位）
    #   非相邻或同位 H_{ij} = 0
    #
    # 物理图像：这是一个链状共轭体系（碳1-2-3-4）
    H = np.array([
        [0, 1, 0, 0],    # 碳1 只与碳2相连
        [1, 0, 1, 0],    # 碳2 与碳1和碳3相连
        [0, 1, 0, 1],    # 碳3 与碳2和碳4相连
        [0, 0, 1, 0]     # 碳4 只与碳3相连
    ])
   
    # 求解Hückel矩阵的本征值和本征向量
    # 本征值 E_i（单位为β）代表第i个分子轨道的能量相对于α的偏移量
    # 因为β<0，E_i越负 → 轨道能量越低 → 越稳定
    eigenvalues, eigenvectors = np.linalg.eigh(H)
    
    # 打印四个π分子轨道的能量（从低到高排序）
    # 在丁二烯中，预期得到：
    # 两个成键轨道（能量低于α）、两个反键轨道（能量高于α）
    print("丁二烯的π分子轨道能级（单位：β）：")
    for i, E in enumerate(eigenvalues):
        # 注意：eigenvalues已按从小到大排序
        # 在化学中常把能量最低的轨道记为ψ1（最稳定）
        print(f"ψ{i+1}: E = α + {E:.4f}β")
        # 经典Hückel结果应接近： α+1.618β, α+0.618β, α-0.618β, α-1.618β
    
    # 计算总π电子能量（丁二烯有4个π电子）
    # 电子填充规则：每个分子轨道最多容纳2个电子（Pauli原理）
    # 丁二烯基态：前两个轨道（成键轨道）各填2个电子
    # 总π电子能量 = 2×E₁ + 2×E₂
    total_energy = 2 * eigenvalues[0] + 2 * eigenvalues[1]
    
    print(f"\n总π电子能量：E_π = 4α + {total_energy:.4f}β")
    # 经典值约为 4α + 4.472β，是衡量共轭稳定性的重要指标
    
    # 返回值供后续分析使用
    # eigenvalues: 四个轨道能量（单位β）
    # eigenvectors: 对应的分子轨道系数（LCAO系数）
    return eigenvalues, eigenvectors


# 执行计算并接收结果
energies, orbitals = huckel_butadiene()
```








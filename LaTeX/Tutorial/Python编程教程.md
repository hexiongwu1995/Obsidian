---
math-engine: mathjax
---


# Python编程教程

## 第一章：Python基础入门

### 1.1 为什么化学家需要学习Python？

在现代化学研究中，Python已经成为不可或缺的工具。无论是处理光谱数据、模拟分子结构、分析量子化学计算结果，还是可视化晶体结构，Python都能提供强大的支持。

Python在化学领域的优势：

- 丰富的科学计算库（NumPy, SciPy, Pandas）
- 专业的化学信息学工具（RDKit, ASE, PySCF）
- 强大的可视化能力（Matplotlib, Plotly）
- 开源免费，社区活跃
- 易学易用，代码简洁

### 1.2 Python环境配置

在Obsidian中使用Code Emitter插件运行Python代码非常方便。确保您已经安装了Python 3.8或更高版本。推荐安装的包：

```python
# 在 JupyterLite / Pyodide 环境中使用的微型包管理器
# micropip 是 Pyodide 提供的专用工具，用于在浏览器中动态安装 Python 包
import micropip

# 异步安装 numpy 包（因为 Pyodide 环境下的安装是异步的，必须使用 await）
await micropip.install("numpy")

# 异步安装 matplotlib 包（绘图用，常一起安装）
await micropip.install("matplotlib")


import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")
```


```bash
pip install numpy scipy matplotlib pandas
pip install ase rdkit-pypi
pip install pyscf
```

### 1.3 Python基本语法

#### 变量与数据类型

字典（Dictionary）定义

```python
# 基本语法
字典名 = {键1: 值1, 键2: 值2, ...}

# 嵌套字典语法
字典名 = {
    外层键1: {内层键1: 值1, 内层键2: 值2},
    外层键2: {内层键1: 值3, 内层键2: 值4}
}

# 访问字典值
值 = 字典名[键]
值 = 字典名[外层键][内层键]  # 嵌套字典访问
```
示例：
```python
person = {"name": "张三", "age": 25}
print(person["name"])  # 输出: 张三
```

函数定义（def）

```python
# 基本语法
def 函数名(参数1, 参数2, ...):
    """文档字符串（可选）"""
    函数体
    return 返回值  # 可选

# 带默认参数
def 函数名(参数1, 参数2=默认值):
    函数体

# 带类型注解（Python 3.5+）
def 函数名(参数1: 类型, 参数2: 类型) -> 返回类型:
    函数体
```

示例：

```python
def add(a, b):
    """计算两数之和"""
    return a + b
result = add(3, 5)  # result = 8
print({result},f'\n',f'{result:.2f},'f'\n',f'{result:.2e}',f'\n',add(2,7))
```

print() 函数与 f-string 格式化

```python
# print() 基本语法
print(值1, 值2, ..., sep=' ', end='\n', file=sys.stdout, flush=False)

# 参数说明：
#   值1, 值2, ...: 要打印的对象
#   sep: 分隔符，默认为空格
#   end: 结尾字符，默认为换行符
#   file: 输出目标，默认为标准输出
#   flush: 是否强制刷新缓冲区

# f-string 格式化语法（Python 3.6+）
f"文本{变量名}"                    # 基本插值
f"文本{变量名:格式说明符}"          # 带格式化
f"文本{表达式}"                    # 表达式求值
```

f-string 常用格式说明符：

```python
# 数值格式化
f"{变量:.2f}"     # 保留2位小数
f"{变量:10}"      # 字段宽度为10
f"{变量:>10}"     # 右对齐，宽度10
f"{变量:<10}"     # 左对齐，宽度10
f"{变量:^10}"     # 居中对齐，宽度10
f"{变量:,}"       # 千位分隔符
f"{变量:.2%}"     # 百分比格式（保留2位小数）
f"{变量:e}"       # 科学计数法
```

示例：

```python
name = "小明"
score = 95.678

print(f"姓名：{name}，分数：{score:.2f}")  
# 输出: 姓名：小明，分数：95.68

print(f"计算结果：{3 + 5}")  
# 输出: 计算结果：8
```


Python是动态类型语言，变量不需要声明类型：

```python
# 数值类型
atomic_number = 6  # 整数
atomic_mass = 12.011  # 浮点数
avogadro = 6.022e23  # 科学计数法

# 字符串
element = "Carbon"
formula = 'C6H12O6'

# 布尔值
is_metal = False
is_organic = True

# 打印变量
print(f"{element}的原子序数是{atomic_number}")
```

化学应用示例：

```python
# 计算葡萄糖（C6H12O6）的摩尔质量
# 摩尔质量单位：g/mol
def molar_mass_glucose():
    """
    函数功能：计算葡萄糖的摩尔质量
    返回值：浮点数，表示葡萄糖的摩尔质量（单位：g/mol）
    葡萄糖的化学式：C₆H₁₂O₆
    """
    
    # 各元素的相对原子质量（国际标准值，常用近似值）
    C = 12.011    # 碳元素的相对原子质量
    H = 1.008     # 氢元素的相对原子质量
    O = 15.999    # 氧元素的相对原子质量
    # 根据葡萄糖分子式 C6H12O6 计算摩尔质量
    # 公式：6×C + 12×H + 6×O
    glucose = 6 * C + 12 * H + 6 * O
    return glucose    # 返回计算结果（浮点数）
# 调用函数并格式化输出结果
# :.2f 表示保留两位小数
print(f"葡萄糖的摩尔质量：{molar_mass_glucose():.2f} g/mol")
```

#### 列表
列表（List）- 存储多个数据，列表是Python中最常用的数据结构，在化学中可以用来存储原子坐标、能量序列等：

```python
# 创建列表
elements = ["H", "C", "N", "O"]
atomic_numbers = [1, 6, 7, 8]

# 列表操作
elements.append("S")  # 添加元素
print(elements[0])  # 访问第一个元素（索引从0开始）
print(elements[-1])  # 访问最后一个元素

# 列表切片
first_three = elements[0:3]
print(first_three)  # ['H', 'C', 'N']

# 使用列表推导式生成一个包含1到5（含）每个整数平方的新列表（非常强大的特性）
# range(1, 6) 生成从1到5的整数序列（注意：range的结束值不包含） 
# x2 表示对每个整数x求平方 
squares = [x2 for x in range(1, 6)]
print(squares)  # [1, 4, 9, 16, 25]
```


化学应用：存储分子坐标

```python
# 定义水分子的笛卡尔坐标（单位：Å，埃）
# 每个子列表代表一个原子：[原子符号, x坐标, y坐标, z坐标]
water_coords = [
    ["O",  0.000,  0.000,  0.117],   # 氧原子，通常放在坐标系的近似中心
    ["H",  0.000,  0.757, -0.467],   # 第一个氢原子
    ["H",  0.000, -0.757, -0.467]    # 第二个氢原子（关于y轴对称）
]

# 遍历列表中的每一个原子（每一行）
for atom in water_coords:
    # 使用序列解包（unpacking）把列表中的4个元素分别赋值给4个变量
    # 左侧变量数量必须和右侧可迭代对象中的元素数量一致
    symbol, x, y, z = atom
    
    # 使用 f-string 格式化字符串输出（Python 3.6+）
    # :.3f 表示保留3位小数（fixed point）
    # 也可以写成 {:.3f}、{x:.3f} 等多种写法
    print(f"{symbol}: ({x:.3f}, {y:.3f}, {z:.3f})")
```

#### 元组
元组（Tuple）- 不可变序列，元组与列表类似，但创建后不能修改，适合存储常量：

```python
# 定义物理常数
PLANCK_CONSTANT = (6.62607015e-34, "J·s")
BOLTZMANN_CONSTANT = (1.380649e-23, "J/K")

h, unit = PLANCK_CONSTANT
print(f"普朗克常数：{h} {unit}")
```

#### 矩阵（数组）

```python
# np.array()数组的使用方法
numpy.array(object, dtype=None, copy=True, order='K', subok=False, ndmin=0)
# 最常用：
np.array([[1,2],[3,4]])          # 2×2 矩阵
np.array([1,2,3,4], dtype=float) # 指定数据类型
```


#### len() 函数

完整语法  
```python
len(s)
```

参数 s：可以是任何有长度的对象，常见类型包括：列表 list，元组 tuple，字符串 str，集合 set / frozenset，字典 dict，range 对象，numpy 数组（ndarray），pandas Series / DataFrame 等等

返回值：返回对象的长度（元素个数），类型为 `int`

常见用法举例

```python
# 列表
len([1, 2, 3, 4])          # 4

# 字符串（算字符数，不是字节数）
len("你好世界")             # 4
len("hello world")         # 11

# 空对象
len([])                    # 0
len("")                    # 0
len({})                    # 0

# numpy 数组（最常见用法之一）
import numpy as np
A = np.array([[1,2,3],[4,5,6]])
len(A)                     # 2    ← 返回的是行数（最外层维度）

# 在你的代码中
eigenvectors[:, i]         # 这是第 i 列，是一个向量（1维数组）
# len(eigenvectors)        # 会返回特征向量的个数（也就是有几个特征值/特征向量）
```

#### range() 函数

完整语法

```python
range(stop)
range(start, stop)
range(start, stop, step)
```

参数
start：开始值（包含），默认 = 0
stop：结束值（不包含），必须填写
step：步长（可正可负），默认 = 1

返回值：返回一个 range 对象（Python 3 中是惰性生成器，不是列表）

最常见的三种写法对比

写法               | 等价于实际生成的整数序列          | 说明
-------------------|-----------------------------------|---------------------
`range(5)`        | 0, 1, 2, 3, 4                    | 从 0 到 4
`range(1, 6)`     | 1, 2, 3, 4, 5                    | 从 1 到 5
`range(0, 10, 2)` | 0, 2, 4, 6, 8                    | 步长 2
`range(10, 0, -1)`| 10, 9, 8, ..., 2, 1              | 倒序
`range(10, 0, -2)`| 10, 8, 6, 4, 2                   | 倒序 + 步长 2


#### 字典
字典（Dictionary）- 键值对存储，字典非常适合存储元素性质等信息：

```python
# ========== 元素周期表数据 ==========
# 创建一个嵌套字典，用于存储元素周期表的信息
# 外层字典的键是元素符号(字符串)，值是包含元素详细信息的内部字典
periodic_table = {
    "H": {"name": "氢", "atomic_mass": 1.008, "group": 1},  # 氢元素的信息
    "C": {"name": "碳", "atomic_mass": 12.011, "group": 14},  # 碳元素的信息
    "O": {"name": "氧", "atomic_mass": 15.999, "group": 16}   # 氧元素的信息
}

# ========== 访问嵌套字典中的数据 ==========
# 使用两层索引访问嵌套字典：第一层索引获取元素符号对应的字典，第二层索引获取具体属性
print(periodic_table["C"]["name"])  # 输出: 碳
print(periodic_table["C"]["atomic_mass"])  # 输出: 12.011

# ========== 遍历字典的所有键值对 ==========
# items() 方法返回字典中所有的键值对，每次迭代返回一个(键, 值)元组
# symbol 变量存储元素符号(外层字典的键)
# properties 变量存储该元素的属性字典(外层字典的值)
for symbol, properties in periodic_table.items():
    # 使用 f-string 格式化字符串输出元素信息
    # properties['name'] 访问内层字典的 name 键
    # properties['atomic_mass'] 访问内层字典的 atomic_mass 键
    print(f"{symbol}: {properties['name']}, {properties['atomic_mass']} g/mol")
```


实用示例：构建完整的元素数据库
```python
elements_db = {
    "H": {"Z": 1, "mass": 1.008, "electroneg": 2.20},
    "C": {"Z": 6, "mass": 12.011, "electroneg": 2.55},
    "N": {"Z": 7, "mass": 14.007, "electroneg": 3.04},
    "O": {"Z": 8, "mass": 15.999, "electroneg": 3.44}
}

def get_electronegativity_diff(elem1, elem2):
    """计算两个元素的电负性差"""
    en1 = elements_db[elem1]["electroneg"]
    en2 = elements_db[elem2]["electroneg"]
    return abs(en1 - en2)

# 判断化学键类型
diff = get_electronegativity_diff("H", "O")
if diff > 1.7:
    bond_type = "离子键"
elif diff > 0.4:
    bond_type = "极性共价键"
else:
    bond_type = "非极性共价键"
    
print(f"H-O键的电负性差：{diff:.2f}，属于{bond_type}")
```

### 1.4 控制流程

#### 条件语句

```python
# 完整语法
if 条件1:
    代码块1
elif 条件2:
    代码块2
elif 条件3:
    代码块3
else:
    代码块4

# 简化形式
if 条件:
    代码块

# 三元表达式
变量 = 值1 if 条件 else 值2
```

```python
# 根据pH值判断溶液性质
pH = 7.4

if pH < 7:
    print("酸性溶液")
elif pH == 7:
    print("中性溶液")
else:
    print("碱性溶液")

# 化学应用：判断反应自发性
delta_G = -50.0  # kJ/mol

if delta_G < 0:
    spontaneity = "自发"
elif delta_G > 0:
    spontaneity = "非自发"
else:
    spontaneity = "平衡状态"
    
print(f"ΔG = {delta_G} kJ/mol，反应{spontaneity}")
```

#### 循环语句

for循环

```python
# for循环的完整语法格式
for 临时变量 in 可迭代对象:
    循环体...
```

```python
# 字典遍历的三种方式

# 只遍历key
for k in dict:
    ...

# 同时获取key和value（最常用）
for k, v in dict.items():
    ...

# 只遍历value
for v in dict.values():
    ...
```


#### 枚举/遍历
enumerate()，枚举/遍历，enumerate() 函数用于将一个可遍历的数据对象（如列表、元组或字符串）组合为一个索引-元素对的枚举对象，通常用于循环中同时获取元素的索引和值。

```python
enumerate(iterable, start=0)
```

参数：
  - `iterable`（必须）→ 任何可迭代对象（列表、元组、字符串、集合、range、numpy数组等）
  - `start`（可选，默认=0）→ 计数从几开始
返回值：返回一个 枚举迭代器（enumerate object），每次迭代会产生一个 元组：`(索引, 元素值)`

常用写法对比

| 写法                                      | 索引从哪里开始 | 说明                                | 推荐场景             |
|-------------------------------------------|----------------|-------------------------------------|----------------------|
| `for i, E in enumerate(eigenvalues):`     | 0              | 最常见写法                          | 绝大多数情况         |
| `for i, E in enumerate(eigenvalues, 1):`  | 1              | 序号从1开始（人类更习惯）           | 显示编号、排名等     |
| `for idx, val in enumerate(arr, start=0):`| 0              | 变量名更明确                        | 需要强调索引含义时   |
| `for i in range(len(eigenvalues)):`       | —              | 旧式写法（不推荐）                  | 基本被 enumerate 取代 |
小总结表（快速记忆）

| 需求                     | 推荐写法                              |
|--------------------------|---------------------------------------|
| 索引从 0 开始            | `enumerate(lst)`                      |
| 序号从 1 开始（最常用）  | `enumerate(lst, 1)`                   |
| 只要元素不要序号         | `for x in lst:`                       |
| 只要序号不要元素         | `for i, _ in enumerate(lst):`         |
| 同时要序号和元素         | `for i, x in enumerate(lst, 1):`      |


```python

for idx, value in enumerate(iterable, start=0):    # start默认为0
    ...

for i, item in enumerate(lst, 1):                 # lst=list ，从1开始编号
    ...

for num, char in enumerate("hello", start=1):
    ...
```

```python
# 遍历元素列表 - 普通for循环写法（使用index()方法获取索引）
elements = ["Li", "Na", "K", "Rb", "Cs"]           # 定义碱金属列表（第1族元素）

# 方法1：使用列表的index()方法来获取当前元素的序号（不推荐在循环中使用）
# 因为每次循环都会从头查找元素，效率较低（时间复杂度O(n²)）
for element in elements:
    # elements.index(element) 返回元素第一次出现的索引（从0开始）
    # +1 是为了让序号从1开始，更符合人类的阅读习惯
    print(f"第{elements.index(element)+1}族碱金属：{element}")


# 方法2：使用 enumerate() 函数（推荐写法）
# enumerate() 是专门用来在遍历可迭代对象时同时获取索引和值的内置函数
# 语法格式：
# for 索引变量, 元素变量 in enumerate(可迭代对象, start=起始序号):
for index, element in enumerate(elements, start=1):
    # index 现在直接就是我们想要的从1开始的序号
    # 格式化字符串中可以直接使用变量
    print(f"{index}. {element}")


# ────────────────────────────────────────────────
# 计算分子总质量（以葡萄糖 C6H12O6 为例）
# ────────────────────────────────────────────────

# 分子式中各元素的原子个数（化学计量数）
# 字典格式：元素符号 → 出现次数
molecule = {"C": 6, "H": 12, "O": 6}     # 葡萄糖的化学式：C₆H₁₂O₆

# 各元素的相对原子质量（2021年国际标准值，单位：g/mol）
# 实际应用中建议使用更精确或统一来源的原子量表
atomic_masses = {
    "C": 12.011,
    "H": 1.008,
    "O": 15.999
}

total_mass = 0.0    # 初始化总质量为0（建议使用浮点数0.0）

# 遍历分子式字典的每一对“元素-数量”
# items() 方法返回字典的 (key, value) 元组对
for element, count in molecule.items():
    # 计算该元素贡献的质量 = 原子个数 × 相对原子质量
    mass = count * atomic_masses[element]
    
    # 累加到总质量
    total_mass += mass
    
    # 打印中间结果，保留3位小数
    # :.3f 表示浮点数保留3位小数
    print(f"{count} × {element}: {mass:.3f} g/mol")


# 最后输出总摩尔质量，也保留3位小数
print(f"总摩尔质量：{total_mass:.3f} g/mol")
# 理论上葡萄糖的摩尔质量 ≈ 180.156 g/mol
```

while循环：
```python
# 模拟一级反应动力学（First-order reaction kinetics）
# 一级反应的特征：反应速率与反应物浓度成正比

concentration = 1.0    # 初始浓度，单位：mol/L（摩尔每升）
k = 0.1                # 反应速率常数（rate constant），单位：s⁻¹（每秒）
                       # 这是代码中最核心的参数，代表一级反应的特征速率

time = 0.0             # 当前模拟时间，单位：秒
dt = 1.0               # 时间步长（模拟的时间增量），单位：秒
                       # dt 越小，数值模拟越精确，但计算量越大

print("时间(s)\t \t \t \t 浓度(mol/L)")   # 打印表头

# 当浓度还没有衰减到 0.05 mol/L 以下时，继续模拟
while concentration > 0.05:
    # 输出当前时刻的时间和浓度（保留1位小数的时间，4位小数的浓度）
    print(f"{time:.1f}\t{concentration:.4f}");
  
    # 核心：一级反应的近似离散递推公式
    # 真实微分方程：dc/dt = -k·c
    # 使用最简单的显式欧拉法（前向差分）离散化后得到：
    # Δc ≈ -k·c·Δt
    # 因此：c(t+Δt) ≈ c(t) + Δc = c(t) - k·c(t)·Δt = c(t)·(1 - k·Δt)
    concentration = concentration * (1 - k * dt)
    # 时间前进一个步长
    time += dt
```

### 1.5 函数定义

函数是代码复用的基础，在化学计算中极其重要：

```python
def calculate_energy(wavelength):
    """
    根据波长计算光子能量
    
    参数：
        wavelength: 波长（单位：nm）
    
    返回：
        能量（单位：eV）
    """
    h = 6.62607015e-34  # J·s
    c = 2.99792458e8    # m/s
    e = 1.602176634e-19 # C
    
    wavelength_m = wavelength * 1e-9
    energy_J = h * c / wavelength_m
    energy_eV = energy_J / e
    
    return energy_eV

# 使用函数
uv_wavelength = 254  # nm
energy = calculate_energy(uv_wavelength)
print(f"波长{uv_wavelength} nm的光子能量：{energy:.2f} eV")
```

带默认参数的函数：

```python
def ideal_gas_pressure(n, V, T=298.15):
    """
    理想气体状态方程计算压强
    
    参数：
        n: 物质的量 (mol)
        V: 体积 (L)
        T: 温度 (K)，默认为298.15K
    
    返回：
        压强 (atm)
    """
    R = 0.08206  # L·atm/(mol·K)
    P = n * R * T / V
    return P

# 调用
p1 = ideal_gas_pressure(2, 10)  # 使用默认温度
p2 = ideal_gas_pressure(2, 10, 373.15)  # 指定温度

print(f"25°C时的压强：{p1:.2f} atm")
print(f"100°C时的压强：{p2:.2f} atm")
```

返回多个值：

```python
def solve_quadratic(a, b, c):
    """
    求解一元二次方程 ax^2 + bx + c = 0
    
    返回两个根（可能是复数）
    """
    discriminant = b**2 - 4*a*c
    
    if discriminant >= 0:
        x1 = (-b + discriminant**0.5) / (2*a)
        x2 = (-b - discriminant**0.5) / (2*a)
        return x1, x2
    else:
        real_part = -b / (2*a)
        imag_part = (-discriminant)**0.5 / (2*a)
        x1=complex(real_part,imag_part)
        x2=complex(real_part,-imag_part)
        return x1,x2
# 使用
root1, root2 = solve_quadratic(1, 1, 6)
print(f"方程的根：x1 = {root1}, x2 = {root2}")
```

```python
# 统一使用复数处理
def solve_quadratic(a, b, c):
    """
    求解一元二次方程 ax^2 + bx + c = 0
    返回两个根（实数或复数）
    """
    discriminant = b**2 - 4*a*c
    sqrt_d = complex(discriminant)**0.5          # 自动处理正负
    x1 = (-b + sqrt_d) / (2*a)
    x2 = (-b - sqrt_d) / (2*a)
    return x1, x2
    
root1, root2 = solve_quadratic(1, 1, 6)
print(f"方程的根：x1 = {root1}, x2 = {root2}")
```


```python
# 幂运算的使用方法
m=10**-1
n=-1**10
p=(-1)**10
q=(-1)**0.5
import cmath
s=cmath.sqrt(-1)
print(m)
print(n)
print(p)
print(q)
print(s)
```

```python
# 复数的使用方法
z=complex(3,4)
print(z)
print(type(z))
```


## 第二章：NumPy科学计算

### 2.1 NumPy简介

NumPy是Python科学计算的核心库，提供高效的数组操作。在量子化学和材料化学中，我们经常需要处理矩阵和向量运算。

```python
import micropip 
await micropip.install("numpy")
import numpy as np

# 创建数组
arr1 = np.array([1, 2, 3, 4, 5])
print(arr1)

# 创建特殊数组
zeros = np.zeros(5)  # 全零数组
ones = np.ones((3, 3))  # 3×3的全1矩阵
identity = np.eye(3)  # 3×3单位矩阵
print(zeros)
print(ones)
print(identity)
# 等间距数组（常用于绘图）
x = np.linspace(0, 10, 11)  # 0到10之间的10个点
print(x)

```

### 2.2 数组运算

基本运算：

```python
import micropip
await micropip.install("numpy")
import numpy as np

# 向量运算示例
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

# 逐元素运算（element-wise operation）
print("加法：", a + b)          # [5 7 9]
print("乘法：", a * b)          # [4 10 18]  ← 对应位置相乘
print("幂运算：", a**2)         # [1 4 9]    ← 每个元素平方

# ────────────────────────────────────────────────
#          向量点积（Dot Product / 内积）
# ────────────────────────────────────────────────
"""
数学定义：
两个向量 a = [a₁, a₂, ..., aₙ] 和 b = [b₁, b₂, ..., bₙ] 的点积是一个标量，计算公式为：
    a · b = a₁b₁ + a₂b₂ + ... + aₙbₙ
几何意义：
1. a · b = |a| |b| cosθ    （θ是两向量夹角）
"""

dot_product = np.dot(a, b)
print(f"点积：{dot_product}")        # 应输出 32
# ────────────────────────────────────────────────
#          向量叉积（Cross Product / 外积）
# ────────────────────────────────────────────────
"""
数学定义（仅在三维空间有定义）：
两个向量 a = [a₁, a₂, a₃] 和 b = [b₁, b₂, b₃] 的叉积是一个新的向量 c，满足：

    c = a × b = | i     j     k  |
                | a₁    a₂    a₃ |
                | b₁    b₂    b₃ |

展开后各分量为：
    cx = a₂b₃ - a₃b₂
    cy = a₃b₁ - a₁b₃
    cz = a₁b₂ - a₂b₁

几何意义：
1. |a × b| = |a| |b| sinθ     （面积大小）
2. a × b 的方向由右手定则决定：右手四指从a转到b，大拇指指向c方向
3. a × b 垂直于 a 和 b 所构成的平面
4. 最常见的用途：计算平行四边形面积（|a × b| 就是面积）
"""

cross_product = np.cross(a, b)
print(f"叉积：{cross_product}")      # 应输出 [-3  6 -3]
```

化学应用：分子几何计算

```python
import micropip
await micropip.install("numpy")
import numpy as np

# 定义三个原子的坐标（水分子）
O = np.array([0.000, 0.000, 0.117])
H1 = np.array([0.000, 0.757, -0.467])
H2 = np.array([0.000, -0.757, -0.467])

# 计算键长
def bond_length(atom1, atom2):
    """计算两原子间的距离"""
    vector = atom2 - atom1
    distance = np.linalg.norm(vector)
    return distance

# 计算键角
def bond_angle(atom1, atom2, atom3):
    """
    计算键角（atom2为中心原子）
    返回角度（度）
    """
    v1 = atom1 - atom2
    v2 = atom3 - atom2
    
    cos_angle = np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))
    angle_rad = np.arccos(cos_angle)
    angle_deg = np.degrees(angle_rad)
    
    return angle_deg

# 计算水分子的几何参数
oh1_distance = bond_length(O, H1)
oh2_distance = bond_length(O, H2)
hoh_angle = bond_angle(H1, O, H2)

print(f"O-H1键长：{oh1_distance:.3f} Å")
print(f"O-H2键长：{oh2_distance:.3f} Å")
print(f"H-O-H键角：{hoh_angle:.1f}°")
```

`numpy.linalg.norm()` 是 NumPy 中用来计算向量范数或矩阵范数的最常用函数。

```python
# 完整语法格式
numpy.linalg.norm(
    x, 
    ord=None, 
    axis=None, 
    keepdims=False
)
```

参数详细说明

| 参数         | 类型                                  | 是否必填 | 默认值     | 说明                                     |
| ---------- | ----------------------------------- | ---- | ------- | -------------------------------------- |
| `x`        | array_like                          | 必填   | —       | 输入数组（可以是向量、矩阵、多维数组）                    |
| `ord`      | int, float, inf, -inf, 'fro', 'nuc' | 选填   | `None`  | 范数的类型（阶数），决定计算哪一种范数，见下表                |
| `axis`     | None, int, 2-tuple of ints          | 选填   | `None`  | 沿着哪个轴（或哪两个轴）计算范数。常用于批量计算               |
| `keepdims` | bool                                | 选填   | `False` | 是否保留被缩减的维度（类似于 sum、mean 的 keepdims 参数） |

`ord` 参数最常用的取值及其含义（重点记忆）

| ord 值       | 适用对象     | 数学含义                              | 计算公式（简化）                              | 常用场景                     |
|--------------|--------------|---------------------------------------|-----------------------------------------------|------------------------------|
| `None`       | 向量/展平    | 默认 → L2 范数（欧几里得范数）        | √(∑xᵢ²)                                       | 最常用，默认行为             |
| `2`          | 向量/矩阵    | L2 范数 / 谱范数                      | 向量：同上；矩阵：最大奇异值                  | 欧氏距离、机器学习正则化     |
| `1`          | 向量/矩阵    | L1 范数 / 最大列和                    | 向量：∑\|xᵢ\|；矩阵：max(列绝对值和)          | 曼哈顿距离、稀疏促进         |
| `inf`        | 向量/矩阵    | ∞-范数 / 最大值范数                   | max(\|xᵢ\|)                                   | 最大分量关注                 |
| `-inf`       | 向量/矩阵    | -∞-范数                               | min(\|xᵢ\|)                                   | 最小非零分量关注             |
| `'fro'`      | 矩阵         | Frobenius 范数（Frobenius norm）      | √(∑∑\|aᵢⱼ\|²) = √(trace(AᴴA))                 | 矩阵的“欧氏范数”，很常用     |
| `'nuc'`      | 矩阵         | 核范数（Nuclear norm）                | 奇异值之和                                    | 矩阵低秩近似、压缩感知       |

典型用法举例

```python
import micropip
await micropip.install("numpy")
import numpy as np

x = np.array([3, -4, 5])

# L2 范数（默认） → 5√2 ≈ 7.071
print(np.linalg.norm(x))          

# L1 范数 → 3+4+5 = 12
print(np.linalg.norm(x, ord=1))   

# ∞ 范数 → max = 5
print(np.linalg.norm(x, ord=np.inf))

# 矩阵 Frobenius 范数
A = np.array([[1,2],[3,4]])
print(np.linalg.norm(A, 'fro'))   # ≈ 5.477

# 按行计算 L2 范数（很常见）
X = np.random.randn(100, 3)
row_norms = np.linalg.norm(X, axis=1)          # shape: (100,)
```

希望这个总结清晰明了～有需要哪种范数的详细数学推导也可以继续问我！


#### np.zeros_like()函数
在 Python 的数据科学和数值计算中，`np.zeros_like()` 是一个非常实用的函数。它的核心作用是：创建一个与给定数组具有相同形状（shape）和类型（dtype）的全零数组。

完整语法格式
```
numpy.zeros_like(a, dtype=None, order='K', subok=True, shape=None)
```

参数详解
`a` (必选)：输入的原型数组。新生成的数组将参考这个数组的属性（形状和数据类型）。
`dtype` (可选)：指定输出数组的数据类型。如果设为 `None`（默认），则新数组的类型将与输入数组 `a` 保持一致。你可以显式指定，如 `dtype=int` 或 `dtype=float`。
`order` (可选)：指定数组在内存中的存储顺序。`'C'`：C 语言风格（行优先）。`'F'`：Fortran 风格（列优先）。 `'A'`：如果 `a` 是 Fortran 连续的则为 `'F'`，否则为 `'C'`。`'K'`（默认）：尽量匹配 `a` 的内存布局。
`subok` (可选)：布尔值。如果为 `True`（默认），则新数组将使用 `a` 的子类（如果 `a` 是矩阵等）；如果为 `False`，则返回一个标准的 `numpy.ndarray`。
`shape` (可选)：这是 NumPy 1.17.0 版本新增的参数。 它允许你覆盖从 `a` 继承来的形状，但依然保留 `a` 的其他属性（如 `dtype`）。

代码实例解析
```python
import numpy as np
z = np.linspace(0, 1, 100)
E_y = np.zeros_like(z)
```

`z` 的状态：`np.linspace(0, 1, 100)` 创建了一个包含 100 个元素的一维数组，起始值为 0，终止值为 1，默认 `dtype` 是 `float64`。其形状为 $ (100,) $。
`E_y` 的结果：执行 `np.zeros_like(z)` 后，NumPy 会查看 `z` 的属性。Shape: 继承自 `z`，即 $ (100,) $。Dtype: 继承自 `z`，即 `float64`。内容: 全部填充为 $ 0 $。
这在物理仿真或信号处理（如你代码中的电场分量 $E_y$）中非常常见，通常用于初始化一个与自变量数组长度完全匹配的结果容器。

为什么要用 `zeros_like` 而不是 `zeros`？
虽然你也可以使用 `np.zeros(z.shape)`，但 `np.zeros_like(z)` 更有优势：
简洁性：代码更短，可读性更高。
安全性：它会自动处理 `dtype`。如果 `z` 是复合类型或特殊精度，`zeros_like` 能确保 $E_y$ 与其完全兼容，避免后续运算出现类型不匹配的错误。

### 2.3 矩阵运算

在量子化学中，矩阵运算无处不在（哈密顿矩阵、重叠矩阵等）：

```python
import micropip
await micropip.install("numpy")
import numpy as np

# 创建矩阵
A = np.array([[1, 2], [3, 4]])
B = np.array([[5, 6], [7, 8]])
print("矩阵A为：")
print(A)
print("矩阵B为：")
print(B)
# 矩阵乘法
C = np.matmul(A, B)  # 或使用 A @ B
print("矩阵乘法C=A×B：")
print(C)

# 矩阵转置
print("转置矩阵A⊺：")
print(A.T)

# 矩阵的迹（对角线元素之和）
trace = np.trace(A)
print(f"A矩阵的迹（对角线元素之和）：{trace}")

# 行列式
det = np.linalg.det(A)
print(f"A的行列式：{det}")

# 矩阵的逆
A_inv = np.linalg.inv(A)
print("A的逆矩阵：")
print(A_inv)

# 验证 A × A^(-1) = I
identity_check = A @ A_inv
print("验证验证 A × A^(-1) = I为单位矩阵：")
print(identity_check)
```


#### 量子化学应用
求解本征值问题，在量子力学中，薛定谔方程 $\hat{H}\psi = E\psi$ 是一个本征值问题：

```python
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")
import numpy as np

H = np.array([
    [-1.0,  0.5],    # H_{00} = -1.0 eV, H_{01} = 0.5 eV
    [ 0.5,  1.0]     # H_{10} = 0.5 eV,  H_{11} = 1.0 eV
])
# 使用 np.linalg.eigh() 求解 Hermitian (厄米) 矩阵的本征值和本征向量
# 特别适合求解量子力学中的哈密顿矩阵（实对称或复 Hermitian 矩阵）
# 返回值：
#   eigenvalues : 一维数组，按从小到大排序的本征值
#   eigenvectors: 列向量矩阵，每一列是一个归一化的本征向量
eigenvalues, eigenvectors = np.linalg.eigh(H)

# 打印标题
print("能量本征值（单位：eV）：")

# 循环输出每个本征值，保留4位小数
for i, E in enumerate(eigenvalues):
    print(f"E{i+1} = {E:.4f} eV")

print()  # 空行，美观分隔

# 打印本征向量部分标题
print("本征向量（已经归一化）：")

# 遍历每个本征向量（eigenvectors 的每一列）
for i in range(len(eigenvalues)):
    # eigenvectors[:, i] 取出第 i 个本征向量（列向量）
    print(f"ψ{i+1} = {eigenvectors[:, i]}")

# 验证第一个本征向量是否确实归一化
# np.linalg.norm() 默认计算 2-范数（欧几里得范数）
# 对于归一化的量子态，应有 ||ψ||₂ = 1
norm = np.linalg.norm(eigenvectors[:, 0])
print(f"\n第一个本征向量的模（应接近1）：{norm:.4f}")
```


#### 常用函数完整语法说明

`np.linalg.eigh` 的完整英文名称是 Linear algebra library: Eigenvalues of a Hermitian matrix。
简单来说，它的命名逻辑如下：
- `eig`：代表 Eigenvalues 和 Eigenvectors（特征值与特征向量）。
- `h`：后缀 `h` 代表 Hermitian（埃尔米特矩阵，在实数领域即对称矩阵）。
所以，这个函数专门用于计算复埃尔米特矩阵或实对称矩阵的特征值和特征向量。

```python
# np.linalg.eigh()的使用方法

numpy.linalg.eigh(a, UPLO='L', eigvals_only=False)
# 参数说明：
# a         : 必须是 Hermitian 或实对称矩阵（可以是 2d array）
# UPLO      : 只使用矩阵的哪一半（因为是对称的）, 'U' 使用上三角，'L' 使用下三角（默认 'L'）
# eigvals_only : 如果为 True，只返回本征值，不计算本征向量（更快）

# 返回：
# w : 本征值（从小到大排序）
# v : 本征向量矩阵（列向量形式，已归一化）
```
与 np.linalg.eig 的主要区别（很关键）
只要你确定矩阵是对称的（或 Hermitian 的），优先使用 np.linalg.eigh，它更快、数值更稳定、特征值自动排序。

| 函数     | 适用矩阵           | 特征值是否排序    | 速度（对称矩阵时） | 推荐场景          |
| ------ | -------------- | ---------- | --------- | ------------- |
| `eig`  | 任意方阵           | 不保证排序      | 较慢        | 一般矩阵、非对称      |
| `eigh` | 必须对称/Hermitian | 保证从小到大 | 明显更快  | 对称矩阵（物理、PCA等） |

```python
# np.linalg.norm()的使用方法

numpy.linalg.norm(x, ord=None, axis=None, keepdims=False)
# 最常用用法：
np.linalg.norm(vec)             # 默认 ord=2 → 欧几里得范数 √(x·x)
np.linalg.norm(vec, ord=2)      # 明确写 2-范数
np.linalg.norm(vec, ord=np.inf) # 最大值范数
np.linalg.norm(A, ord='fro')    # 矩阵 Frobenius 范数
```


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





### 2.4 数组索引和切片

```python
import numpy as np

# 创建2D数组（矩阵）
matrix = np.array([
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12]
])

# 索引
print(matrix[0, 0])  # 第一行第一列：1
print(matrix[1, 2])  # 第二行第三列：7

# 切片
print(matrix[0, :])  # 第一行
print(matrix[:, 1])  # 第二列
print(matrix[0:2, 1:3])  # 子矩阵

# 布尔索引（非常有用！）
mask = matrix > 6
print(matrix[mask])  # 所有大于6的元素
```

化学数据筛选示例：

```python
import numpy as np

# 模拟一组分子的能量和偶极矩数据
molecules = np.array([
    [-100.5, 1.2],  # [能量(kcal/mol), 偶极矩(Debye)]
    [-95.3, 2.5],
    [-102.1, 0.8],
    [-98.7, 1.9],
    [-101.3, 1.5]
])

# 筛选能量低于-100 kcal/mol的分子
low_energy = molecules[molecules[:, 0] < -100]
print("低能量构象：")
print(low_energy)

# 筛选偶极矩在1.0-2.0 Debye范围内的分子
moderate_dipole = molecules[(molecules[:, 1] >= 1.0) & (molecules[:, 1] <= 2.0)]
print("\n中等偶极矩的分子：")
print(moderate_dipole)
```

### 2.5 NumPy在化学中的高级应用

拟合光谱数据：

```python
import numpy as np

# 模拟UV-Vis吸收光谱数据
wavelength = np.array([200, 220, 240, 260, 280, 300, 320, 340])  # nm
absorbance = np.array([0.05, 0.12, 0.35, 0.68, 0.45, 0.18, 0.08, 0.03])

# 多项式拟合
coefficients = np.polyfit(wavelength, absorbance, 3)
polynomial = np.poly1d(coefficients)

# 生成拟合曲线
wavelength_fit = np.linspace(200, 340, 100)
absorbance_fit = polynomial(wavelength_fit)

print("拟合多项式系数：", coefficients)
print(f"在280nm处的拟合吸光度：{polynomial(280):.3f}")
```

计算统计参数：

```python
import numpy as np

# 一组反应速率常数的实验测量值
rate_constants = np.array([2.3e-3, 2.5e-3, 2.1e-3, 2.4e-3, 2.6e-3])

mean_k = np.mean(rate_constants)
std_k = np.std(rate_constants, ddof=1)  # 样本标准差
relative_std = (std_k / mean_k) * 100

print(f"平均速率常数：{mean_k:.2e} s^-1")
print(f"标准差：{std_k:.2e}")
print(f"相对标准偏差：{relative_std:.1f}%")
```

## 第三章：数据处理与可视化

### 3.1 Matplotlib绘图基础

Matplotlib是Python中最常用的绘图库，对于化学数据可视化至关重要。

###### plt.figure()创建画布

```python
plt.figure(
    num=None,               # 画布编号或标签（很重要！）
    figsize=None,           # 画布尺寸 (宽, 高) 单位：英寸
    dpi=None,               # 分辨率（每英寸点数）
    facecolor=None,         # 画布背景颜色
    edgecolor=None,         # 画布边缘颜色
    frameon=True,           # 是否显示画布外框
    FigureClass=None,       # 高级用法：自定义 Figure 类
    clear=False,            # 如果画布已存在，是否先清空
    layout=None,            # 布局引擎：'constrained' / 'tight' / None，自动避免标签重叠
    kwargs                # 其他传递给 Figure 类的参数
)
```

最常用的几种写法对比

| 写法                                                | 说明                         | 推荐场景            |
| ------------------------------------------------- | -------------------------- | --------------- |
| `plt.figure()`                                    | 使用默认尺寸和编号                  | 最简单、临时画图        |
| `plt.figure(figsize=(10,6))`                      | 指定宽高（最常用）                  | 报告、论文、做图尺寸要求明确时 |
| `plt.figure(figsize=(8,4.5), dpi=150)`            | 高清输出用                      | 保存图片给PPT、论文     |
| `plt.figure(num=1)`                               | 指定画布编号（可重复使用同一窗口）          | 需要反复更新同一张图时     |
| `plt.figure("我的实验结果")`                            | 用字符串做窗口标题和编号               | 多窗口区分很方便        |
| `plt.figure(figsize=(12,8), facecolor="#f8f9fa")` | 浅灰背景，比较高级美观                | 做展示用图           |
| `plt.figure(layout="constrained")`                | 自动避免标签重叠（matplotlib≥3.3推荐） | 子图较多时强烈推荐       |

记忆口诀：“先定画布大小，再画内容”  


###### add_subplot
在 Matplotlib 库中，`add_subplot` 是 `Figure` 对象的一个核心方法，用于在画布（Figure）上创建并添加子图（Axes）。
`add_subplot` 的标准调用方式有以下几种：

```python
# 方式 A: 传入三个整数 (常用)
ax = fig.add_subplot(nrows, ncols, index, kwargs)
# 方式 B: 传入一个三位数整数 (简写)
ax = fig.add_subplot(pos, kwargs)
# 方式 C: 传入子图实例
ax = fig.add_subplot(ax_obj)
```

参数详解
`nrows`: 网格的行数。 `ncols`: 网格的列数。`index`: 子图的索引位置。索引从 $1$ 开始，按从左到右、从上到下的顺序排列。
`pos`: 一个三位数的整数（如 $231$），等价于 $nrows=2, ncols=3, index=1$。注意：这种简写只有在三个数字都小于 $10$ 时才有效。 `kwargs`: 其他绘图属性，如投影方式（`projection='3d'`）、背景颜色等。

布局逻辑
当你调用 `fig.add_subplot(nrows, ncols, index)` 时，Matplotlib 会逻辑上将画布划分为 $nrows \times ncols$ 的网格。
例如，执行 `fig.add_subplot(2, 2, 3)`：它将画布平分为 $2$ 行 $2$ 列，共计 $4$ 个区域。它在第 $3$ 个位置（即第二行第一列）创建一个坐标系。

常用关键字参数 (kwargs)
除了位置参数，`add_subplot` 还支持丰富的配置：

|参数|说明|示例|
|---|---|---|
|projection|指定坐标系类型|`projection='3d'` (需导入 mplot3d) 或 `'polar'` (极坐标)|
|sharex / sharey|与另一个子图共享坐标轴|`sharex=ax1`|
|label|给子图设置标签，方便后续识别|`label='main_plot'`|
|facecolor|设置子图区域的背景颜色|`facecolor='lightgray'`|

实例演示：混合使用不同的子图布局
```python
import micropip
await micropip.install("matplotlib")
import matplotlib.pyplot as plt
fig = plt.figure(figsize=(8, 6))
# 创建一个 2x2 网格中的第一个子图 (左上角)
ax1 = fig.add_subplot(2, 2, 1)
ax1.set_title("Plot 1")
# 使用三位数简写创建第二个子图 (右上角)
ax2 = fig.add_subplot(222)
ax2.set_title("Plot 2")
# 创建一个横跨底部的子图
# 逻辑：我们将底部视为 2行1列 布局中的第2个区域
ax3 = fig.add_subplot(2, 1, 2)
ax3.set_title("Plot 3 (Wide)")
plt.tight_layout()
plt.show()
```

与 `plt.subplots()` 的区别
这是一个常见的易混淆点：`add_subplot`: 属于 Figure 对象 的方法。通常用于在一个已有的画布上一层一层、或者非对称地手动添加子图。`plt.subplots(nrows, ncols)`: 是一次性创建画布和所有子图的便捷函数。它返回的是一个包含所有子图对象的数组（NumPy array）。你想让我为你演示如何利用 `add_subplot` 创建一个 3D 散点图，还是尝试复杂的非对称布局代码？


###### 非对称布局
在 Matplotlib 中，如果你想实现非对称布局（即每个子图的宽度、高度各不相同），单纯依靠 `add_subplot` 的基本索引方式会变得非常复杂。

通常有三种进阶方案来实现这种灵活性：
方法一：利用 `add_subplot` 的几何重叠（逻辑切分）。`add_subplot` 本质上是在画布上“划拨”网格。你可以通过在同一个 `figure` 上使用不同的行列比例来手动拼凑布局。

```python
import micropip
await micropip.install("matplotlib")
import matplotlib.pyplot as plt

fig = plt.figure(figsize=(6,6))
# 逻辑：第一行分成 3 份，取第 1 份（左上角小图）
ax1 = fig.add_subplot(2, 3, 1)
# 逻辑：第一行分成 3 份，取后 2 份（右上角长图）
# 注意：这里 index 可以传入一个元组，表示占据的范围
ax2 = plt.subplot2grid((2, 3), (0, 1), colspan=2) 
# 逻辑：第二行分成 1 份（底部大长图）
ax3 = fig.add_subplot(2, 1, 2)
plt.show()
```

方法二：使用 `GridSpec` (最推荐的专业做法)
`GridSpec` 允许你精确定义行与行、列与列之间的 宽度比 (width_ratios) 和 高度比 (height_ratios)。

```python
import micropip
await micropip.install("matplotlib")
import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec

fig = plt.figure(figsize=(6, 4))

# 定义一个 2x2 的网格
# 第一行与第二行高度比为 1:2
# 第一列与第二列宽度比为 3:1
gs = gridspec.GridSpec(2, 2, width_ratios=[3, 1], height_ratios=[1, 2])

ax1 = fig.add_subplot(gs[0, 0]) # 左上
ax2 = fig.add_subplot(gs[0, 1]) # 右上
ax3 = fig.add_subplot(gs[1, :]) # 占据整个第二行（切片操作）

ax1.set_title("3:1 Width Ratio")
ax3.set_title("Height Ratio 2 & Full Width")

plt.tight_layout()
plt.show()
```

方法三：使用 `add_axes` (绝对定位)
如果你需要完全自由地控制子图在画布上的坐标和大小（不受网格限制），可以使用 `fig.add_axes([left, bottom, width, height])`。这里的参数是 归一化百分比，即范围在 $0$ 到 $1$ 之间。

```python
import micropip
await micropip.install("matplotlib")
import matplotlib.pyplot as plt

fig = plt.figure()
# 参数格式：[左边距, 底边距, 宽度, 高度]
# 创建一个主图
ax1 = fig.add_axes([0.1, 0.1, 0.8, 0.8])
# 在主图内部嵌入一个小图 (图中图)
ax2 = fig.add_axes([0.6, 0.6, 0.2, 0.2]) 
plt.show()
```

方案对比

|方法|灵活性|适用场景|
|---|---|---|
|GridSpec|极高|最常用。适合比例明确的非对称布局（如热图旁附带侧边条）。|
|subplot2grid|中|适合简单的跨行、跨列布局。|
|add_axes|最高|适合“图中图”或完全不规则的特殊设计。|

小提示：如果你使用的是较新版本的 Matplotlib，还可以尝试 `fig.subplot_mosaic()`，它允许你用“字符画”的形式定义布局（例如 `[['A', 'A', 'B'], ['C', 'D', 'D']]`），非常直观。

###### plt.plot()折线图

```python
plt.plot(
    *args,               # arguments（有时也称为 _positional arguments_），最核心：可以是 1~多个 (x,y,fmt) 组合
    scalex=True,         # 是否根据x自动调整x轴范围
    scaley=True,         # 是否根据y自动调整y轴范围
    data=None,           # pandas.DataFrame 或 dict 时可以用列名绘图
    kwargs             # keyword arguments（关键字参数），最重要的部分：线的各种属性
)
```

最常见的几种调用方式（按使用频率排序）

写法                                  | 含义                                   | 备注
-------------------------------------|----------------------------------------|---------------------
`plt.plot(y)`                        | 只给y，x自动用 0,1,2,...,n-1           | 最快画序列
`plt.plot(x, y)`                     | 最标准用法                             | ★★★ 日常用最多
`plt.plot(x, y, 'r-o')`              | 红色 + 圆点 + 实线                     | 快捷格式写法
`plt.plot(x, y, 'b--', linewidth=2)` | 蓝色虚线，加粗                         | 常用组合
`plt.plot(x, y1, 'o', x, y2, '^')`   | 同时画两条曲线                         | 多组数据快速对比
`plt.plot(x, y, label="实验组A")`  | 加图例标签                             | 必须配合 plt.legend()
`plt.plot(..., color='tab:orange')`  | 使用 matplotlib 推荐的颜色表            | 颜色更专业统一

在 Python 中，`*args` 和 `kwargs` 是函数定义中用于接收可变数量参数的特殊语法。它们的完整英文名称和含义如下：

###### args
完整英文名称：arguments（有时也称为 _positional arguments_）
含义：`*args` 用于接收任意数量的位置参数（positional arguments），这些参数在函数内部会被打包成一个 元组（tuple）。
在你给出的 `plt.plot(*args, ...)` 示例中，`*args` 允许用户传入多个 `(x, y, fmt)` 组合，例如：
        
```python
plt.plot(x1, y1, 'r-', x2, y2, 'b--')
# 这些参数会以元组形式传入函数内部。
```

###### kwargs
完整英文名称：keyword arguments（关键字参数）
含义：`kwargs` 用于接收任意数量的关键字参数（keyword arguments），这些参数在函数内部会被打包成一个字典（dict），键是参数名，值是对应的值。同样，`kwargs` 也不是关键字，只是惯例写法；你可以用 `options`、`properties` 等，但 `kwargs` 最常见。在 `plt.plot(..., kwargs)` 中，`kwargs` 通常用于设置线条样式，比如：

```python
plt.plot(x, y, color='red', linewidth=2, linestyle='--')
# 这些关键字参数会被收集到 `kwargs` 字典中，然后传递给底层绘图逻辑。
```

注意：在函数调用时，`*` 和 `**` 也可用于解包（unpacking）：
```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

plt.figure(figsize=(5,5))
x=np.linspace(0,10,11)
y=x
args = (x, y, 'r-')
kwargs = {'linewidth': 2}
plt.plot(*args, *kwargs)  # 等价于 plt.plot(x, y, 'r-', linewidth=2)
plt.show()
```


plt.plot() 中最常用的 kwargs 参数

| 参数                        | 常用写法示例                          | 说明             |
| ------------------------- | ------------------------------- | -------------- |
| `color` 或 `c`             | 'red', '#FF4500', 'tab:blue'    | 线条/标记颜色        |
| `linewidth` 或 `lw`        | 1.5, 2.5, 0.8                   | 线粗细            |
| `linestyle` 或 `ls`        | '-', '--', '-.', ':', 'None'    | 线型             |
| `marker`                  | 'o','^','s','*','+','x','D','.' | 数据点形状          |
| `markersize` 或 `ms`       | 6, 8, 4.5                       | 标记点大小          |
| `markeredgecolor` 或 `mec` | 'black', 'w'                    | 标记点边缘颜色        |
| `markerfacecolor` 或 `mfc` | 'None', 'white'                 | 标记点填充颜色（可做空心点） |
| `markevery=10`            |                                 | 每10个点显示一个标记    |
| `alpha`                   | 0.8, 0.3                        | 透明度            |
| `label`                   | "训练集", "验证集"                    | 图例文字           |
| `zorder`                  | 10, 5, 1                        | 图层顺序（越大越在上层）   |


###### plt.title()
```python
plt.title(
    label,                   # 必须：标题文字（字符串）
    fontsize=12,             # 字体大小（数字或 'small','medium','large' 等）
    fontweight='normal',     # 'normal', 'bold', 'semibold' 等
    color='black',           # 标题颜色
    pad=6,                   # 标题与图形顶部的距离（点数），默认约 6
    loc='center',            # 'center'（默认） / 'left' / 'right'
    y=None,                  # 标题的纵向位置（0~1之间，1在最上面）
    kwargs                 # 其他 Text 属性，如 fontfamily, rotation 等
)
```

###### plt.axhline()
###### plt.axvline()
使用plt.axhline()函数绘制horizontal line；使用plt.axvline()函数绘制vertical line；
```python
plt.axhline(y=100, color='r', linestyle='--', alpha=0.3, label='Dissociation Energy')
plt.axvline(x=1.0, color='g', linestyle='--', alpha=0.3, label='Equillibrium bond length')
```


###### plt.xlabel() 
```python
plt.xlabel(
    xlabel,                 # 必须：标签文字
    fontsize=12,            # 字体大小（数字或 'small','medium','large' 等）
    fontweight='normal',    # 'normal', 'bold', 'semibold' 等
    color=None,
    labelpad=None,          # 标签与刻度文字的距离（默认由 rcParams 控制）
    loc='center',           # x轴可用：'left', 'center', 'right'
                            # y轴可用：'bottom', 'center', 'top'
    kwargs                  # 其他 Text 属性
)
```

###### plt.xticks()
plt.xticks() 是 Matplotlib 中最常用的设置/获取 x轴刻度 的函数之一。
```python
matplotlib.pyplot.xticks(
    ticks=None,           # 位置（必看）
    labels=None,          # 刻度标签（最常用）
    *,                    # 强制关键字参数分隔符（Python 3.8+ 风格）
    minor=False,          # 是否设置次刻度（非常重要但用得少）
    **kwargs              # 所有 Text 对象的属性（字体、颜色、旋转等）
) → tuple 或 None
```

| 写法                                      | 功能说明               | 返回值                             | 常见场景            |
| --------------------------------------- | ------------------ | ------------------------------- | --------------- |
| `plt.xticks()`                          | 只查询当前 x 轴主刻度的位置和标签 | `(array of locs, list of Text)` | 调试时想知道当前刻度值     |
| `plt.xticks([1,3,5,7])`                 | 只设置刻度位置（标签自动用位置数值） | `(locs, labels)`                | 想要特定位置出现刻度      |
| `plt.xticks([1,2,3], ['A','B','C'])`    | 同时设置位置 + 自定义标签     | `(locs, labels)`                | 最常见的用法          |
| `plt.xticks([])`                        | 移除所有 x 轴主刻度（传空列表）  | `(array([]), [])`               | 想要干净的图没有 x 刻度   |
| `plt.xticks(minor=True, ticks=[...])`   | 设置**次刻度**位置        | `(locs, labels)`                | 需要显示次刻度（比如对数坐标） |
| `plt.xticks(rotation=45, ha='right')`   | 只改刻度标签的显示样式，不动位置   | `(locs, labels)`                | 长标签倾斜显示最常用      |
| `plt.xticks(fontsize=14, color='navy')` | 修改刻度标签的字体、大小、颜色等   | `(locs, labels)`                | 美化图表            |

###### np.arrange()
np.arrange的完整函数签名如下：
```python
numpy.arange([start, ]stop, [step, ]dtype=None, *, like=None)
```

start (可选): 数列的起点。默认值为 $0$。生成的数列包含此值。
stop (必选): 数列的终点。生成的数列不包含此值（左闭右开区间 $[start, stop)$）。
step (可选): 数列的步长（两个相邻数字之间的间隔）。默认值为 $1$。
 dtype (可选): 输出数组的数据类型。如果不指定，将根据输入参数自动推断。
like (可选): 参考对象，用于创建非 NumPy 后端的数组（通常在高级开发中使用）。

| **调用方式**                       | **说明**                        | **示例**                                         |
| ------------------------------ | ----------------------------- | ---------------------------------------------- |
| `np.arange(stop)`              | 生成 $[0, stop)$，步长为 $1$        | `np.arange(5)` $\to [0, 1, 2, 3, 4]$           |
| `np.arange(start, stop)`       | 生成 $[start, stop)$，步长为 $1$    | `np.arange(2, 6)` $\to [2, 3, 4, 5]$           |
| `np.arange(start, stop, step)` | 生成 $[start, stop)$，步长为 $step$ | `np.arange(1, 10, 2)` $\to [1, 3, 5, 7, 9]$    |
| `np.arange(..., dtype=float)`  | 强制指定数据类型                      | `np.arange(3, dtype=float)` $\to [0., 1., 2.]$ |

###### plt.ylim()
`plt.ylim()` 的调用方式非常灵活，主要分为“获取模式”和“设置模式”。
设置模式 (Setting)：用于手动指定 y 轴的显示上限和下限：

```python
plt.ylim(bottom, top)  # bottom: y 轴的最小值（下限）。top: y 轴的最大值（上限）。
# 或者使用关键字参数
plt.ylim(bottom=None, top=None)
# 或者传递一个元组/列表
plt.ylim( (ymin, ymax) )
```
  
常见使用方法：限定显示范围。假设你有一组波动很大的数据，但你只想观察 $y \in [0, 10]$ 这一区间。

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import matplotlib.pyplot as plt
import numpy as np
plt.figure(figsize=(5,3))
x = np.linspace(0, 10, 100)
y = x**2
plt.plot(x, y)
# 设置 y 轴范围从 0 到 50
plt.ylim(0, 50) 
plt.show()
```

单侧限制：如果你只想固定下限，而让上限根据数据自动伸缩，可以将另一侧设为 `None`：
```
# 确保 y 轴从 0 开始，上限自适应
plt.ylim(bottom=0) 
```

反转坐标轴：这是一个很有意思的技巧，如果 `bottom` 大于 `top`，y 轴会反转（常见于气象学或深度相关的图表）：
```
# y 轴数值从大到小排列
plt.ylim(100, 0) 
```

进阶：与面向对象 API 的区别
在 Matplotlib 中，如果你使用的是 `fig, ax = plt.subplots()` 这种面向对象的写法，对应的函数名称会稍有不同：

| 模式  | pyplot 接口 (快速绘图)  | Axes 接口 (推荐用于复杂绘图)   |
| --- | ----------------- | -------------------- |
| 设置  | `plt.ylim(0, 10)` | `ax.set_ylim(0, 10)` |
| 获取  | `plt.ylim()`      | `ax.get_ylim()`      |


###### plt.grid()
```python
plt.grid(
    visible=True,          # True / False / None（None时有其他参数就自动True）
    which='major',         # 'major'（默认） / 'minor' / 'both'
    axis='both',           # 'both'（默认） / 'x' / 'y'
    color='gray',
    linestyle='--',
    linewidth=0.8,
    alpha=0.3,             # 透明度 0~1
    kwargs               # 其他 Line2D 属性
)
```

###### plt.legend() 图例 
```python
plt.legend()                             # 自动使用 label 参数最简单
plt.legend(fontsize=9)                   # 调整字体大小
plt.legend(loc='upper right')            # 位置最常用写法
plt.legend(frameon=False)                # 去掉边框（很流行）
plt.legend(title="图例标题", title_fontsize=10)
```

更多实用参数组合：

| 参数              | 常用值示例                        | 说明                              |
|-------------------|------------------------------------|------------------------------------|
| `loc`             | 'best', 'upper right', 'lower left', 'center' | 位置（'best' 会自动找空位） |
| `fontsize`        | 8, 9, 10, 'small', 'medium'       | 图例文字大小                      |
| `frameon`         | True / False                      | 是否画边框（False 更简洁）        |
| `framealpha`      | 0.9, 0.8, 1.0                     | 边框背景透明度                    |
| `edgecolor`       | 'gray', 'black', 'none'           | 边框颜色                          |
| `facecolor`       | 'white', '0.95', 'none'           | 背景颜色                          |
| `ncol` / `ncols`  | 2, 3                              | 图例分几列显示                    |
| `title`           | "图例说明"                        | 图例上方加小标题                  |
| `bbox_to_anchor`  | (1.02, 1.0), (0.5, -0.15)         | 精细控制图例位置（常用于放外面）  |


###### np.random.rand() 
np.random.rand() 函数是 NumPy 库中用于生成均匀分布随机数的函数。返回值：返回一个在区间 $[0, 1)$ 上服从均匀分布的随机浮点数或随机数组。

完整语法格式
```python
numpy.random.rand(d0, d1, ..., dn)
```

参数说明：d0, d1, ..., dn：整数，可选参数。表示生成随机数组的维度（shape）。可以传入0个、1个或多个参数。每个参数代表对应维度的大小。

使用示例
```python
# np.random.rand() 函数是 NumPy 库中用于生成均匀分布随机数的函数。返回值：返回一个在区间 $[0, 1)$ 上服从均匀分布的随机浮点数或随机数组。
import numpy as np

# 1. 不传参数：返回一个随机浮点数
x = np.random.rand()
# 输出示例: 0.5488135039273248

# 2. 传入一个参数：返回一维数组
arr1 = np.random.rand(5)
# 输出示例: [0.71518937 0.60276338 0.54488318 0.4236548  0.64589411]

# 3. 传入两个参数：返回二维数组
arr2 = np.random.rand(3, 4)
# 输出示例: 3行4列的随机数矩阵

# 4. 传入多个参数：返回多维数组
arr3 = np.random.rand(2, 3, 4)
# 输出示例: 形状为(2, 3, 4)的三维数组
```

重要特性
分布范围：生成的随机数范围是 $[0, 1)$，即包含0但不包含1
均匀分布：每个值在该区间内出现的概率相等
浮点类型：返回的数据类型为 `float64`

与其他函数的区别
`np.random.random(size)`: 功能类似，但参数是元组形式
`np.random.uniform(low, high, size)`: 可以指定范围的均匀分布
`np.random.randn()`: 生成标准正态分布（均值0，标准差1）


###### 综合例子

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 10, 51)
y1 = np.sin(x)
y2 = np.cos(x)

# ------------------ 推荐的现代写法 ------------------
plt.figure(figsize=(5, 3), dpi=120, layout="constrained")

plt.plot(x, y1, 
         color='tab:blue', 
         linewidth=1.5, 
         label='sin(x)')

plt.plot(x, y2, 
         linestyle='--', 
         color='#ff6600', 
         marker='o', 
         markersize=3, 
         markevery=2,          # 每10个点显示一个标记
         label='cos(x)')

plt.title("Comparison of sine and cosine function", fontsize=10, pad=12)
plt.xlabel("$x$", loc='right',fontsize=10)
plt.ylabel("$y$", loc='top',fontsize=10)
plt.grid(True, alpha=0.3, linestyle='--')
plt.legend(frameon=False, fontsize=5)

# plt.savefig("sin_cos.png", dpi=200, bbox_inches='tight')
plt.show()
```


绘制化学动力学曲线：

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt

# 一级反应动力学：[A] = [A]0 * exp(-kt)
t = np.linspace(0, 50, 100)
k1 = 0.1
k2 = 0.05
k3 = 0.02

c1 = np.exp(-k1 * t)
c2 = np.exp(-k2 * t)
c3 = np.exp(-k3 * t)

plt.figure(figsize=(5, 3),clear=True)
plt.plot(t, c1, 'r-', label=f'k = {k1} s⁻¹', linewidth=1)
plt.plot(t, c2, 'g-', label=f'k = {k2} s⁻¹', linewidth=1)
plt.plot(t, c3, 'b-', label=f'k = {k3} s⁻¹', linewidth=1)

plt.xlabel('t(s)',loc='right', fontsize=10)
plt.ylabel(r'$\frac{[A]}{[A]_0}$',loc='center',rotation=0,labelpad=10,fontweight='bold',fontsize=10)
plt.xticks(np.arange(0,51,5))
plt.yticks(np.arange(0,max(y)+0.2,0.2))
plt.title('First-order kinetic curve', fontsize=12, fontweight='semibold')
plt.legend(frameon=False,fontsize=6)
plt.grid(True,which='both',alpha=0.3)
plt.tight_layout()
plt.show()
```

Morse势能曲线：

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt

# 创建Morse势能曲线：V(r) = De * (1 - exp(-a(r-re)))^2
def morse_potential(r, De=100, a=1.5, re=1.0):
    """
    Morse势能函数
    De: 解离能 (kcal/mol)
    a: 势阱宽度参数
    re: 平衡键长 (Å)
    """
    return De * (1 - np.exp(-a * (r - re)))**2

r = np.linspace(0.5, 4.0, 100)
V = morse_potential(r)

plt.figure(figsize=(5, 3))
plt.plot(r, V, 'b-', linewidth=1.5)
plt.axhline(y=0, color='k', linestyle='--', alpha=0.3)
plt.axhline(y=100, color='r', linestyle='--', alpha=0.3, label='Dissociation Energy')
plt.axvline(x=1.0, color='g', linestyle='--', alpha=0.3, label='Equillibrium bond length')

plt.xlabel('Bond Length r (Å)', fontsize=8)
plt.ylabel('Potential Energy V (kcal/mol)', fontsize=8)
plt.title('Curve of Morse Potential Energy', fontsize=10, fontweight='semibold')
plt.legend(fontsize=5)
plt.grid(True, alpha=0.3)
plt.xlim(0.5, 4.0)
plt.ylim(-20, 120)
plt.tight_layout()
plt.show()
```



### 3.2 多子图绘制

#### plt.subplots()函数
在 Matplotlib 中，`plt.subplots()` 是最常用的函数之一，它通过创建一个 Figure（画布） 和一个或一组 Axes（坐标轴/子图），让你能以面向对象的方式高效绘图。

plt.subplots()函数的完整语法格式：
```python
fig, ax = plt.subplots(nrows=1, ncols=1, *, sharex=False, sharey=False, squeeze=True, width_ratios=None, height_ratios=None, subplot_kw=None, gridspec_kw=None, fig_kw)
```

核心参数详解

| 参数名            | 类型         | 说明                                                                       |
| -------------- | ---------- | ------------------------------------------------------------------------ |
| nrows, ncols   | int        | 子图网格的行数和列数。默认为 $1$。                                                      |
| sharex, sharey | bool / str | 是否共享 X 轴或 Y 轴。可选：`True`, `False`, `'row'`, `'col'`。                      |
| squeeze        | bool       | 默认为 `True`。如果为 `True`，返回的 `axes` 会根据形状压缩（单子图返回对象，单行/列返回一维数组，多行多列返回二维数组）。 |
| width_ratios   | array-like | 设置各列的相对宽度比例（需 Matplotlib 3.6+）。                                          |
| height_ratios  | array-like | 设置各行的相对高度比例（需 Matplotlib 3.6+）。                                          |
| subplot_kw     | dict       | 传递给 `add_subplot` 的关键字参数（如 `projection='3d'`）。                           |
| gridspec_kw    | dict       | 传递给 `GridSpec` 的参数，用于控制子图间的间距等。                                          |
| fig_kw         | -          | 所有其他关键字参数将传递给 `plt.figure()`，如 `figsize=(w, h)`。                         |

plt.subplots()函数返回一个元组：fig (`Figure`): 代表整个画布。ax (`Axes` 或 `ndarray`)。
如果只有 1 个子图，返回一个 `matplotlib.axes.Axes` 对象。如果有多个子图，返回一个包含 `Axes` 对象的 NumPy 数组。

场景 A：创建一个简单的单子图

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import matplotlib.pyplot as plt

# 创建画布并设置大小
fig, ax = plt.subplots(figsize=(6, 4))

ax.plot([1, 2, 3], [4, 5, 6], label='Line A')
ax.set_title("Single Subplot")
ax.legend()

plt.show()
```

场景 B：创建 $2 \times 2$ 的多子图并共享坐标轴

```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0, 2 * np.pi, 400)
y = np.sin(x**2)

# 创建 2x2 网格，共享所有子图的 X 和 Y 轴
fig, axes = plt.subplots(2, 2, sharex=True, sharey=True, figsize=(8, 6))

# axes 是一个 2x2 的 NumPy 数组
axes[0, 0].plot(x, y)
axes[0, 0].set_title('Top Left')

axes[0, 1].scatter(x, y, color='red', s=1) # s的含义是size，代表散点的尺寸
axes[0, 1].set_title('Top Right')

axes[1, 0].plot(x, -y, color='green')
axes[1, 1].fill(x, y)

# 自动调整布局，防止标签重叠
plt.tight_layout()
plt.show()
```

Squeeze 参数的影响，当 `squeeze=True`（默认）时：
`subplots`(1, 1) $\rightarrow$ `ax` 是一个 Axes 对象。
`subplots(1, 2)` $\rightarrow$ `ax` 是一个 一维数组 `[ax1, ax2]`。
`subplots(2, 2)` $\rightarrow$ `ax` 是一个 二维数组 `[[ax1, ax2], [ax3, ax4]]`。
    
如果你在写循环绘图脚本，建议设置 `squeeze=False`，这样无论你创建多少个子图，`axes` 永远是二维数组，方便统一索引：
```python
fig, axes = plt.subplots(2, 1, squeeze=False)
# 永远使用 axes[row, col] 访问
axes[0, 0].plot(data) 
```

#### Axes 对象
在 Matplotlib 的世界里，你可以把 Figure 想象成一张“画布”，而 Axes（坐标轴对象） 就是画在画布上的那一个“具体的图表”。
它是 Matplotlib 中最核心的对象，你平时进行的大部分绘图操作（画线、设标题、加标签）其实都是在调用 `Axes` 对象的方法。

Axes 对象的组成部分：
一个 `Axes` 对象不仅仅是两条线，它是一个复杂的容器，包含：
Axis 对象：即具体的 $X$ 轴和 $Y$ 轴，负责处理刻度（Ticks）和刻度标签（Tick Labels）。
Artists：所有你在图上看到的东西，比如 `Line2D`（线）、`Text`（文本）、`Polygon`（多边形）都是 `Axes` 的一部分。
坐标系：它定义了数据如何映射到屏幕位置。

为什么要用 Axes 对象绘图？（面向对象接口）
Matplotlib 有两种绘图方式，使用 `Axes` 是更专业、更推荐的面向对象（Object-Oriented）方式。

方式 A：快捷方式 (plt.plot)
这种方式适合简单的草图，它会自动寻找“当前”的子图进行操作。

```python
import micropip
await micropip.install("matplotlib")

import matplotlib.pyplot as plt
plt.plot([1, 2], [3, 4])
plt.title("Simple Plot")
plt.show()
```

方式 B：面向对象方式 (ax.plot)
当你处理多个子图或者复杂的图表定制时，这种方式更清晰。
```python
import micropip
await micropip.install("matplotlib")
import matplotlib.pyplot as plt

fig, ax = plt.subplots()
ax.plot([1, 2], [3, 4]) # 明确告诉程序：在这个 ax 上画线
ax.set_title("Object Oriented Plot") # 明确告诉程序：给这个 ax 设标题
plt.show()
```

常见的 Axes 方法对照表
当你从 `plt` 切换到 `ax` 时，有些方法名称会稍有变化（通常会多一个 `set_` 前缀）：

|功能|快捷方式 (plt)|面向对象方式 (ax)|
|---|---|---|
|画折线图|`plt.plot()`|`ax.plot()`|
|设置标题|`plt.title()`|`ax.set_title()`|
|设置 X 轴标签|`plt.xlabel()`|`ax.set_xlabel()`|
|设置 X 轴范围|`plt.xlim()`|`ax.set_xlim()`|
|设置刻度|`plt.xticks()`|`ax.set_xticks()`|

随机散点图
```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import matplotlib.pyplot as plt
import numpy as np

# 1. 创建 2行 1列的布局
fig, axes = plt.subplots(2, 1, figsize=(4, 3))

x = np.linspace(0, 10, 100)
y = np.sin(x)

# 2. 在第一个子图画折线
axes[0].plot(x, y, color='blue', label='Sine Wave')
axes[0].set_title("Line Plot")

# 3. 在第二个子图画散点
# 随机生成 50 个点，颜色和大小随机
# np.random.rand() 函数是 NumPy 库中用于生成均匀分布随机数的函数。返回值：返回一个在区间 [0, 1) 上服从均匀分布的随机浮点数或随机数组。
x_rand = np.random.rand(50)
y_rand = np.random.rand(50)
colors = np.random.rand(50)
sizes = 200 * np.random.rand(50)

axes[1].scatter(x_rand, y_rand, c=colors, s=sizes, alpha=0.5, cmap='viridis')
axes[1].set_title("Scatter Plot")

plt.tight_layout() # 自动调整间距
plt.show()
```


#### Axes3D

在 Matplotlib 中，`Axes3D` 是实现三维可视化的核心类。当你通过 `subplot_kw={'projection': '3d'}` 或 `ax = fig.add_subplot(projection='3d')` 创建子图时，返回的 `ax` 对象就是 `Axes3D` 的实例。它继承自普通的 2D `Axes`，但扩展了处理 $Z$ 轴数据和三维投影的能力。

Axes3D 的核心属性与空间结构
`Axes3D` 创建了一个包含 $X, Y, Z$ 三个正交轴的虚拟空间。坐标轴 (Axes)：除了 `xaxis` 和 `yaxis`，它多了一个 `zaxis`。你可以独立设置每个轴的标签、范围和缩放。视角 (View Control)：它拥有 `view_init(elev, azim)` 方法，用于控制相机的观察角度。$elev$ (Elevation)：仰角。从 $X-Y$ 平面向上看的角度（单位：度）。$azim$ (Azimuth)：方位角。绕 $Z$ 轴旋转的角度（单位：度）。

`Axes3D` 提供了多种方法将数据从三维映射到二维屏幕：
基础线与点
`ax.plot(xs, ys, zs)`：绘制三维空间中的折线。常用于表示质点运动轨迹或波的传播。
`ax.scatter(xs, ys, zs)`：绘制三维散点图。支持为每个点设置不同的颜色或大小。

曲面与网格
`ax.plot_surface(X, Y, Z)`：绘制实心曲面。通常配合 `cmap`（颜色映射）来表现高度。
`ax.plot_wireframe(X, Y, Z)`：绘制网格线框架，不填充表面，适合查看数据结构。
`ax.contour(X, Y, Z)` / `ax.contourf()`：在三维空间中绘制等高线，可以投影到特定平面上。

矢量与体数据
`ax.quiver(X, Y, Z, U, V, W)`：绘制三维矢量场（如电场、磁场）。
`ax.voxels(x, y, z, filled)`：绘制三维体素（类似我的世界 Minecraft 的方块效果）。

关键交互参数：`view_init`
理解 `Axes3D` 的关键在于掌握视角切换。通过调整这些参数，你可以从不同的侧面观察波形的相位和偏振状态。例如：
```python
# 设置从上方俯视
ax.view_init(elev=90, azim=-90)
# 设置倾斜的透视效果
ax.view_init(elev=20, azim=45)
```

与 2D Axes 的主要区别

|功能|2D Axes|3D Axes (Axes3D)|
|---|---|---|
|坐标输入|传入 $(x, y)$|必须传入 $(x, y, z)$|
|网格线|只有平面网格|拥有三个背景平面 (Pane)|
|鼠标交互|支持缩放和平移|默认支持 3D 旋转|
|计算复杂度|较低|较高（需进行投影矩阵变换）|

注意：在处理非常庞大的数据集时，`Axes3D` 的渲染速度会显著慢于 2D 绘图。

简单示例：绘制螺旋线

```python
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")

import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.add_subplot(projection='3d')

theta = np.linspace(-4 * np.pi, 4 * np.pi, 100)
z = np.linspace(-2, 2, 100)
r = z**2 + 1
x = r * np.sin(theta)
y = r * np.cos(theta)

ax.plot(z,x, y,label='3D Spiral')
ax.set_xlabel('Z axis')
ax.set_ylabel('X axis')
ax.set_zlabel('Y axis')
plt.show()
```

你想学习如何调整 `Axes3D` 的背景面板颜色（Pane color）或改变坐标轴的比例（Aspect ratio）吗？

#### projection : 3d

```python
import micropip 
await micropip.install("numpy", deps=False) 
await micropip.install("matplotlib", deps=False)

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
plt.rcParams['font.size']=5
# 下面是一段python代码，请你详细解释subplot_kw={'projection':'3d'}和ax.quiver( )和z[::step]这三个命令的完整语法格式

# Wave number k (rad/m)
k = 1
wavelength = 2 * np.pi / k
z = np.linspace(0, 2.5 * wavelength, 100)
E_x = np.cos(k * z)
E_y = np.zeros_like(z)
E_z = np.zeros_like(z)
fig,ax=plt.subplots(figsize=(5,3),dpi=120,subplot_kw={'projection':'3d'})
# Plot propagation axis (Z axis)
ax.plot(z, np.zeros_like(z), np.zeros_like(z), 'k--', lw=1, alpha=0.9, label='Propagation (z)')

# Plot electric field E (red, x direction)
# Use plot to draw the envelope
ax.plot(z, E_x, E_y, 'r-', linewidth=1.5, label='Electric Field (V/m)')
# Use quiver to draw vector arrows (downsampled to avoid overcrowding)
step = 10
ax.quiver(z[::step], np.zeros_like(z)[::step], np.zeros_like(z)[::step], np.zeros_like(z)[::step], E_x[::step], np.zeros_like(z)[::step], color='r', alpha=0.6, linewidth=0.5,arrow_length_ratio=0.01)
plt.legend()
plt.show()
```

这段代码展示了如何使用 Matplotlib 绘制电磁波在三维空间中的矢量场。为了满足你在 Obsidian 中查看公式的需求，我将统一使用 $inline$ 格式。

subplot_kw={'projection':'3d'}，这是 `plt.subplots()` 函数的一个关键字参数，用于控制子图的属性。
语法格式：`subplot_kw` 接受一个字典，其中的键值对会传递给创建子图的底层构造函数（通常是 `add_subplot`）。
详细解析：'projection':'3d'：这是核心部分。它告诉 Matplotlib 不要创建普通的 2D 笛卡尔坐标系，而是调用 `mpl_toolkits.mplot3d` 模块来创建一个 三维坐标系对象（类型为 `Axes3D`）。如果不加这个参数，后续调用 `ax.quiver` 时如果传入三个坐标参数，代码会报错。

ax.quiver()，在 3D 图形中，`quiver` 用于绘制矢量箭头（常用于表示场强、流向等）。
完整语法格式：`ax.quiver(X, Y, Z, U, V, W, kwargs)`

参数详解
$X, Y, Z$：箭尾（起点）所在的坐标位置。$U, V, W$：分量方向。它们决定了箭头的指向和长度，即矢量为 $(U, V, W)$。
在你的代码中：起点：`z[::step] * 1e9` (Z 轴位置), `0` (X 轴位置), `0` (Y 轴位置)。方向分量：`0` (沿 Z 方向长度), `E_x[::step]` (沿 X 方向长度), `0` (沿 Y 方向长度)。结果：在传播轴上，每隔一段距离画一个垂直于轴线、长度为 $E_x$ 的红色箭头。常用修饰参数：`arrow_length_ratio`：箭头尖端占整个长度的比例（默认 0.3）。

$z[::step]$，这是 Python/NumPy 中的 切片（Slicing） 操作，用于对数组进行“降采样”。
语法格式：`array[start:stop:step]`
详细解析：第一个 `:` 留空表示从索引 $0$ 开始。第二个 `:` 留空表示直到数组结束。`step`：步长。

为什么在这里使用？
你的 `z` 轴有 500 个点。如果你在每个点都画一个 `quiver` 箭头，图形会非常拥挤，变成一团色块。通过 `step = 20`，代码只在第 0, 20, 40... 个位置画箭头。数学等式示例：如果数组长度为 $N$，则切片后的元素个数为 $\lceil N / step \rceil$。

总结与建议
这段代码的核心逻辑是：先开启 3D 投影模式。用 `plot` 画出电场的包络线（连续的曲线）。用 `quiver` 配合 步长切片 画出 离散的矢量箭头，使电场方向的可视化更直观。需要我帮你调整代码，实现圆偏振波或者增加颜色映射（Cmap）的效果吗？



#### 相关性分析
相关性分析（子图4）
```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt
# rcParams是 runtime configuration parameters的缩写。含义是：在运行时（runtime）控制 (configuration)行为的参数（parameters）。
# `matplotlib.rcParams` 是一个字典，用于控制 Matplotlib 的默认配置，例如图形大小、字体、颜色、线宽等。
plt.rcParams['font.size']=8
# 创建2×2子图
fig, axes = plt.subplots(2, 2, figsize=(6, 5))
size=5
# 子图1：指数衰减
t = np.linspace(0, 5, 100)
axes[0, 0].plot(t, np.exp(-t), 'r-', linewidth=2)
axes[0, 0].set_title('Exponential Decay')
axes[0, 0].set_xlabel('Time')
axes[0, 0].set_ylabel('Concentration')
axes[0, 0].grid(True, alpha=0.3)

# 子图2：振荡
axes[0, 1].plot(t, np.sin(2*np.pi*t) * np.exp(-0.5*t), 'b-', linewidth=2)
axes[0, 1].set_title('Damped Oscillation')
axes[0, 1].set_xlabel('Time')
axes[0, 1].set_ylabel('Displacement')
axes[0, 1].grid(True, alpha=0.3)

# 子图3：高斯分布
x = np.linspace(-5, 5, 200)
y = np.exp(-x**2/2) / np.sqrt(2*np.pi)
axes[1, 0].plot(x, y, 'g-', linewidth=2)
axes[1, 0].fill_between(x, y, alpha=0.3)
axes[1, 0].set_title('Gaussian Distribution \n (Normal Distribution)',)
axes[1, 0].set_xlabel('x')
axes[1, 0].set_ylabel('Probability Density')
axes[1, 0].grid(True, alpha=0.3)

# 子图4：相关性分析
x_data = np.random.randn(50)
y_data = 2*x_data + np.random.randn(50)*0.5
axes[1, 1].scatter(x_data, y_data, c='purple', alpha=0.6, s=50)
axes[1, 1].set_title('Correlation Analysis')
axes[1, 1].set_xlabel('Variable_1')
axes[1, 1].set_ylabel('Variable_2')
axes[1, 1].grid(True, alpha=0.3)

plt.tight_layout()
plt.show()
```

#### ax.text()
在 Matplotlib 中，`fig.text()` 和 `ax.text()` 都是用于在图形中添加文本标注的函数，但它们的坐标参考系完全不同。以下是这两个函数的详细语法和对比说明：

ax.text() — 基于坐标轴标注
这是最常用的函数，文本的位置是相对于数据坐标系（Data Coordinates）的。如果你想在某个特定的数据点（如 $x=5, y=10$）旁边写字，就用这个。
```python
# ax.text()的完整语法
ax.text(x, y, s, fontdict=None, kwargs)
```
`x, y`: 文本在数据坐标系中的位置。`s`: 要写入的字符串内容。`fontdict`: 一个字典，用于定义字体属性（如 `{'fontsize': 12, 'fontweight': 'bold'}`）。`kwargs`: 常用参数包括：`ha` / `horizontalalignment`: 水平对齐方式（'center', 'left', 'right'）。`va` / `verticalalignment`: 垂直对齐方式（'center', 'top', 'bottom', 'baseline'）。`fontsize` / `size`: 字体大小。
 `color`: 字体颜色。`rotation`: 旋转角度（如 $90$ 表示逆时针旋转 90 度）。`bbox`: 给文字加边框（例如 `bbox=dict(facecolor='red', alpha=0.5)`）。`transform`: 变换对象。虽然默认是 `ax.transData`（数据坐标），但可以更改为 `ax.transAxes`（轴百分比坐标，范围 $0$ 到 $1$）。
 
#### fig.text()
fig.text() — 基于画布标注。该函数将文本放置在整个 Figure（画布）的相对位置上，通常用于添加总标题、水印或跨子图的说明。
```python
# fig.text()的完整语法格式
fig.text(x, y, s, fontdict=None, kwargs)
```
`x, y`: 文本在画布上的位置。范围是 $0$ 到 $1$。$(0, 0)$ 是画布左下角。$(1, 1)$ 是画布右上角。`s`: 字符串内容。`kwargs`: 与 `ax.text()` 基本一致，包括 `ha`, `va`, `fontsize`, `color` 等。

核心差异对比

|特性|ax.text()|fig.text()|
|---|---|---|
|主要用途|标注具体的数据点、趋势或局部说明。|添加全局标题、页脚、水印。|
|默认坐标系|数据坐标系。随 $x, y$ 轴范围变化而移动。|画布坐标系。无论子图如何变，位置相对固定。|
|范围限制|理论上无限制，但超出轴范围可能不可见（除非关闭剪裁）。|严格控制在 $0$ 到 $1$ 之间。|

示例代码，下面的代码展示了两者在同一张图中的表现：
```python
import micropip
await micropip.install("matplotlib")
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(6, 4))
ax.set_xlim(0, 10)
ax.set_ylim(0, 10)
# 使用 ax.text: 锁定在数据坐标 (5, 5)
ax.text(5, 5, "Data Point (5,5)", color="blue", ha="center")
# 使用 fig.text: 锁定在画布的正上方中央
fig.text(0.5, 0.95, "This is a Figure Title", fontsize=14, ha="center", color="red")
# 使用 transform 参数让 ax.text 表现得像相对坐标
ax.text(0.02, 0.95, "Top Left of Axis", transform=ax.transAxes, verticalalignment='top')
plt.show()
```
进阶小贴士。如果你希望文本在缩放图形时保持在固定位置（例如左上角），即使数据范围发生了变化，建议在 `ax.text` 中设置 `transform=ax.transAxes`。这样坐标 $(0, 0)$ 到 $(1, 1)$ 就代表了当前子图的四个角。

### 3.3 Pandas数据处理

Pandas是处理表格数据的强大工具，非常适合处理实验数据。

```python
import pandas as pd
import numpy as np

# 创建DataFrame（类似Excel表格）
data = {
    '化合物': ['苯', '甲苯', '乙苯', '二甲苯'],
    '沸点(°C)': [80.1, 110.6, 136.2, 144.4],
    '密度(g/mL)': [0.879, 0.867, 0.867, 0.880],
    '折光率': [1.501, 1.497, 1.496, 1.505]
}

df = pd.DataFrame(data)
print(df)

# 数据选择
print(df['沸点(°C)'])  # 选择列
print(df.iloc[0])  # 选择第一行
print(df[df['沸点(°C)'] > 100])  # 条件筛选

# 统计分析
print(df.describe())  # 描述性统计
print(df['沸点(°C)'].mean())  # 平均值
print(df['密度(g/mL)'].std())  # 标准差
```

处理实验数据示例：

```python
import pandas as pd
import numpy as np

# 模拟滴定实验数据
titration_data = pd.DataFrame({
    '体积(mL)': [0, 5, 10, 15, 20, 25, 30, 35, 40],
    'pH': [1.2, 1.5, 2.0, 2.8, 4.5, 10.2, 11.5, 12.0, 12.3]
})

# 计算pH变化率
titration_data['ΔpH/ΔV'] = titration_data['pH'].diff() / titration_data['体积(mL)'].diff()

print(titration_data)

# 找到等当点（pH变化率最大处）
equivalence_point_idx = titration_data['ΔpH/ΔV'].idxmax()
equivalence_volume = titration_data.loc[equivalence_point_idx, '体积(mL)']
print(f"\n等当点体积：{equivalence_volume} mL")

# 保存数据
titration_data.to_csv('titration_results.csv', index=False)
```

读取和处理CSV文件：

```python
import pandas as pd

# 假设有一个包含光谱数据的CSV文件
# wavelength,absorbance
# 200,0.05
# 220,0.12
# ...

# 读取数据
# spectrum_data = pd.read_csv('spectrum.csv')

# 数据清洗
# spectrum_data = spectrum_data.dropna()  # 删除缺失值
# spectrum_data = spectrum_data[spectrum_data['absorbance'] > 0]  # 筛选正值

# 数据转换
# spectrum_data['wavelength_m'] = spectrum_data['wavelength'] * 1e-9
# spectrum_data['energy_eV'] = 1240 / spectrum_data['wavelength']  # 转换为能量
```

### 3.4 绘制专业化学图表

红外光谱图：

```python
import numpy as np
import matplotlib.pyplot as plt

# 模拟红外光谱数据
wavenumber = np.linspace(4000, 400, 500)
transmittance = 100 - 20*np.exp(-((wavenumber-3000)2)/100000) \
                - 30*np.exp(-((wavenumber-1700)2)/50000) \
                - 25*np.exp(-((wavenumber-1200)2)/80000)

plt.figure(figsize=(12, 6))
plt.plot(wavenumber, transmittance, 'b-', linewidth=1.5)
plt.xlabel('波数 (cm⁻¹)', fontsize=13)
plt.ylabel('透过率 (%)', fontsize=13)
plt.title('红外光谱图', fontsize=15, fontweight='bold')
plt.xlim(4000, 400)
plt.ylim(0, 105)
plt.gca().invert_xaxis()  # 反转x轴
plt.grid(True, alpha=0.3)

# 标注特征峰
plt.annotate('O-H伸缩', xy=(3000, 80), xytext=(3300, 60),
            arrowprops=dict(arrowstyle='->', color='red'),
            fontsize=11, color='red')
plt.annotate('C=O伸缩', xy=(1700, 70), xytext=(2000, 50),
            arrowprops=dict(arrowstyle='->', color='red'),
            fontsize=11, color='red')

plt.tight_layout()
plt.show()
```

反应能量图（势能面）：

```python
import numpy as np
import matplotlib.pyplot as plt

# 定义反应坐标和能量
reaction_coord = np.array([0, 1, 2, 3, 4])
energy = np.array([0, 15, 25, 10, -5])

# 使用样条插值使曲线平滑
from scipy.interpolate import make_interp_spline
coord_smooth = np.linspace(0, 4, 300)
spl = make_interp_spline(reaction_coord, energy, k=3)
energy_smooth = spl(coord_smooth)

plt.figure(figsize=(10, 7))
plt.plot(coord_smooth, energy_smooth, 'b-', linewidth=3)
plt.scatter(reaction_coord, energy, c='red', s=100, zorder=5)

# 标注关键点
plt.text(0, 0, '反应物', ha='center', va='top', fontsize=12, fontweight='bold')
plt.text(2, 25, '过渡态', ha='center', va='bottom', fontsize=12, fontweight='bold')
plt.text(4, -5, '产物', ha='center', va='top', fontsize=12, fontweight='bold')

# 绘制能量标注
plt.plot([0, 2], [0, 0], 'k--', alpha=0.5)
plt.plot([2, 2], [0, 25], 'k--', alpha=0.5)
plt.annotate('', xy=(2.2, 25), xytext=(2.2, 0),
            arrowprops=dict(arrowstyle='<->', lw=2, color='green'))
plt.text(2.5, 12.5, r'$E_a$ = 25 kcal/mol', fontsize=11, color='green')

plt.xlabel('反应坐标', fontsize=13)
plt.ylabel('能量 (kcal/mol)', fontsize=13)
plt.title('反应能量图', fontsize=15, fontweight='bold')
plt.grid(True, alpha=0.3)
plt.axhline(y=0, color='k', linestyle='-', alpha=0.3)
plt.tight_layout()
plt.show()
```

## 第四章：量子化学计算应用

### 4.1 分子轨道可视化基础

使用NumPy创建简单的原子轨道函数：

```python
import numpy as np
import matplotlib.pyplot as plt

def hydrogen_1s(x, y, z, a0=1.0):
    """
    氢原子1s轨道波函数
    ψ_1s = (1/√π) * (1/a0)^(3/2) * exp(-r/a0)
    """
    r = np.sqrt(x2 + y2 + z2)
    psi = (1/np.sqrt(np.pi)) * (1/a0)(1.5) * np.exp(-r/a0)
    return psi

def hydrogen_2pz(x, y, z, a0=1.0):
    """
    氢原子2pz轨道波函数
    """
    r = np.sqrt(x2 + y2 + z2)
    psi = (1/(4*np.sqrt(2*np.pi))) * (1/a0)(2.5) * r * np.exp(-r/(2*a0)) * (z/r)
    return psi

# 创建网格
x = np.linspace(-5, 5, 100)
y = 0  # 在y=0平面上可视化
X, Z = np.meshgrid(x, x)
Y = np.zeros_like(X)

# 计算1s轨道
psi_1s = hydrogen_1s(X, Y, Z)

# 绘制
plt.figure(figsize=(10, 8))
plt.contourf(X, Z, psi_1s, levels=20, cmap='RdBu_r')
plt.colorbar(label='波函数 ψ')
plt.xlabel('x (a₀)')
plt.ylabel('z (a₀)')
plt.title('氢原子1s轨道 (y=0平面)')
plt.axis('equal')
plt.tight_layout()
plt.show()
```

### 4.2 变分法求解基态能量

使用变分原理估算氢原子基态能量：

```python
import numpy as np
from scipy.integrate import quad

def variational_hydrogen(alpha):
    """
    使用试探波函数 ψ = N * exp(-alpha*r) 
    计算氢原子的变分能量
    
    参数：
        alpha: 变分参数
    
    返回：
        能量（原子单位）
    """
    # 归一化常数
    N = (alpha3 / np.pi)0.5
    
    # 计算动能积分 <T>
    T = alpha2 / 2
    
    # 计算势能积分 <V>
    V = -alpha
    
    # 总能量
    E = T + V
    
    return E

# 寻找最优alpha值
alphas = np.linspace(0.5, 2.0, 100)
energies = [variational_hydrogen(a) for a in alphas]

# 找到最小能量
min_idx = np.argmin(energies)
optimal_alpha = alphas[min_idx]
min_energy = energies[min_idx]

print(f"最优α值：{optimal_alpha:.4f}")
print(f"变分能量：{min_energy:.4f} a.u.")
print(f"精确能量：-0.5000 a.u.")
print(f"误差：{abs(min_energy + 0.5):.6f} a.u.")

# 绘制能量随alpha变化
plt.figure(figsize=(10, 6))
plt.plot(alphas, energies, 'b-', linewidth=2, label='变分能量')
plt.axhline(y=-0.5, color='r', linestyle='--', label='精确能量', linewidth=2)
plt.axvline(x=optimal_alpha, color='g', linestyle='--', alpha=0.5)
plt.xlabel('变分参数 α', fontsize=12)
plt.ylabel('能量 (a.u.)', fontsize=12)
plt.title('氢原子变分法计算', fontsize=14, fontweight='bold')
plt.legend(fontsize=11)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.show()
```

### 4.3 Hartree-Fock自洽场简化示例

这是一个高度简化的HF概念演示：

```python
import numpy as np

def simple_hf_h2():
    """
    H2分子的最小基组Hartree-Fock计算（概念演示）
    使用STO-3G基组的简化版本
    """
    # 重叠矩阵 S
    S = np.array([
        [1.0, 0.6593],
        [0.6593, 1.0]
    ])
    
    # 核心哈密顿矩阵 Hcore
    Hcore = np.array([
        [-1.1204, -0.9584],
        [-0.9584, -1.1204]
    ])
    
    # 电子排斥积分（简化）
    g = np.zeros((2, 2, 2, 2))
    g[0,0,0,0] = 0.7746
    g[1,1,1,1] = 0.7746
    g[0,0,1,1] = 0.5697
    g[0,1,0,1] = 0.4441
    # 使用对称性填充其他元素
    
    # 初始密度矩阵（猜测）
    P = np.zeros((2, 2))
    
    # 自洽场迭代
    max_iter = 50
    conv_threshold = 1e-6
    
    print("开始SCF迭代...")
    for iteration in range(max_iter):
        P_old = P.copy()
        
        # 构建Fock矩阵
        F = Hcore.copy()
        for i in range(2):
            for j in range(2):
                for k in range(2):
                    for l in range(2):
                        F[i,j] += P[k,l] * (2*g[i,j,k,l] - g[i,k,j,l])
        
        # 求解广义本征值问题 FC = SCE
        eigenvalues, eigenvectors = np.linalg.eigh(F)
        
        # 构建新的密度矩阵（2个电子占据最低轨道）
        C_occupied = eigenvectors[:, 0].reshape(-1, 1)
        P = 2 * C_occupied @ C_occupied.T
        
        # 检查收敛
        delta_P = np.max(np.abs(P - P_old))
        
        # 计算总能量
        E_elec = np.sum(P * (Hcore + F)) / 2
        E_nuc = 0.7151  # 核-核排斥能（R = 1.4 bohr）
        E_total = E_elec + E_nuc
        
        if iteration % 10 == 0:
            print(f"迭代 {iteration}: E = {E_total:.6f} a.u., ΔP = {delta_P:.2e}")
        
        if delta_P < conv_threshold:
            print(f"\nSCF收敛！共{iteration+1}次迭代")
            print(f"总能量：{E_total:.6f} a.u.")
            print(f"电子能量：{E_elec:.6f} a.u.")
            print(f"核排斥能：{E_nuc:.6f} a.u.")
            break
    
    return E_total, eigenvalues

# 运行计算
energy, orbital_energies = simple_hf_h2()
```

### 4.4 密度泛函理论（DFT）概念

虽然完整的DFT实现非常复杂，但我们可以演示一些核心概念：

```python
import numpy as np
import matplotlib.pyplot as plt

def lda_exchange_energy(rho):
    """
    局域密度近似（LDA）的交换能
    Ex^LDA = -Cx * ∫ρ^(4/3) dr
    """
    Cx = (3/4) * (3/np.pi)(1/3)
    ex = -Cx * rho(4/3)
    return ex

def lda_correlation_energy_vwn(rho):
    """
    VWN (Vosko-Wilk-Nusair) 相关能（简化版本）
    """
    rs = (3/(4*np.pi*rho))(1/3)
    # 这里使用简化的参数化
    A = 0.0621814
    x0 = -0.409286
    b = 13.0720
    c = 42.7198
    
    x = np.sqrt(rs)
    X = x2 + b*x + c
    X0 = x02 + b*x0 + c
    Q = np.sqrt(4*c - b2)
    
    ec = A * (np.log(x2/X) + 2*b/Q * np.arctan(Q/(2*x+b)) 
              - b*x0/X0 * (np.log((x-x0)2/X) + 2*(b+2*x0)/Q * np.arctan(Q/(2*x+b))))
    
    return ec

# 绘制交换-相关能密度
rho_range = np.linspace(0.01, 2.0, 100)
ex_values = lda_exchange_energy(rho_range)
ec_values = lda_correlation_energy_vwn(rho_range)
exc_values = ex_values + ec_values

plt.figure(figsize=(10, 6))
plt.plot(rho_range, ex_values, 'b-', linewidth=2, label='交换能 (LDA)')
plt.plot(rho_range, ec_values, 'r-', linewidth=2, label='相关能 (VWN)')
plt.plot(rho_range, exc_values, 'g-', linewidth=2, label='交换-相关能')
plt.xlabel('电子密度 ρ (a.u.)', fontsize=12)
plt.ylabel('能量密度 (a.u.)', fontsize=12)
plt.title('DFT交换-相关能密度', fontsize=14, fontweight='bold')
plt.legend(fontsize=11)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.show()
```

## 第五章：材料科学应用

### 5.1 晶体结构计算

```python
import numpy as np

class CrystalStructure:
    """简单的晶体结构类"""
    
    def __init__(self, lattice_vectors, atomic_positions, elements):
        """
        初始化晶体结构
        
        参数：
            lattice_vectors: 3×3矩阵，晶格矢量（行向量）
            atomic_positions: N×3矩阵，原子分数坐标
            elements: 元素符号列表
        """
        self.lattice = np.array(lattice_vectors)
        self.positions = np.array(atomic_positions)
        self.elements = elements
    
    def get_volume(self):
        """计算晶胞体积"""
        return abs(np.linalg.det(self.lattice))
    
    def get_density(self, atomic_masses):
        """
        计算晶体密度
        
        参数：
            atomic_masses: 原子质量字典
        """
        total_mass = sum(atomic_masses[elem] for elem in self.elements)
        volume_cm3 = self.get_volume() * 1e-24  # Å³ to cm³
        mass_g = total_mass / 6.022e23  # amu to g
        density = mass_g / volume_cm3
        return density
    
    def get_cartesian_coords(self):
        """将分数坐标转换为笛卡尔坐标"""
        return self.positions @ self.lattice
    
    def get_interatomic_distances(self):
        """计算所有原子间距离"""
        cart_coords = self.get_cartesian_coords()
        n_atoms = len(cart_coords)
        distances = np.zeros((n_atoms, n_atoms))
        
        for i in range(n_atoms):
            for j in range(i+1, n_atoms):
                dist = np.linalg.norm(cart_coords[i] - cart_coords[j])
                distances[i, j] = dist
                distances[j, i] = dist
        
        return distances

# 示例：金刚石结构（简化）
diamond_lattice = [
    [3.567, 0, 0],
    [0, 3.567, 0],
    [0, 0, 3.567]
]

diamond_positions = [
    [0.0, 0.0, 0.0],
    [0.25, 0.25, 0.25],
    [0.5, 0.5, 0.0],
    [0.75, 0.75, 0.25],
    [0.5, 0.0, 0.5],
    [0.75, 0.25, 0.75],
    [0.0, 0.5, 0.5],
    [0.25, 0.75, 0.75]
]

diamond_elements = ["C"] * 8

diamond = CrystalStructure(diamond_lattice, diamond_positions, diamond_elements)

print(f"晶胞体积：{diamond.get_volume():.3f} Å³")

atomic_masses = {"C": 12.011}
print(f"晶体密度：{diamond.get_density(atomic_masses):.3f} g/cm³")

distances = diamond.get_interatomic_distances()
print(f"\n最近邻距离：")
non_zero_distances = distances[distances > 0]
print(f"最短距离：{np.min(non_zero_distances):.3f} Å")
```

### 5.2 能带结构概念

```python
import numpy as np
import matplotlib.pyplot as plt

def tight_binding_1d(k, t=1.0, a=1.0):
    """
    一维紧束缚模型的能带
    E(k) = -2t*cos(ka)
    
    参数：
        k: 波矢
        t: 跃迁积分
        a: 晶格常数
    """
    return -2 * t * np.cos(k * a)

def free_electron_1d(k, m=1.0, hbar=1.0):
    """
    自由电子模型
    E(k) = ℏ²k²/(2m)
    """
    return (hbar2 * k2) / (2 * m)

# 创建k空间网格
k = np.linspace(-np.pi, np.pi, 200)

# 计算能带
E_tb = tight_binding_1d(k)
E_free = free_electron_1d(k)

# 绘制能带图
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(14, 5))

# 紧束缚模型
ax1.plot(k/np.pi, E_tb, 'b-', linewidth=2.5)
ax1.axhline(y=0, color='k', linestyle='--', alpha=0.3)
ax1.axvline(x=0, color='k', linestyle='--', alpha=0.3)
ax1.set_xlabel('k (单位：π/a)', fontsize=12)
ax1.set_ylabel('E (单位：t)', fontsize=12)
ax1.set_title('一维紧束缚模型能带', fontsize=13, fontweight='bold')
ax1.grid(True, alpha=0.3)
ax1.set_xlim(-1, 1)

# 自由电子模型
ax2.plot(k/np.pi, E_free, 'r-', linewidth=2.5)
ax2.axhline(y=0, color='k', linestyle='--', alpha=0.3)
ax2.axvline(x=0, color='k', linestyle='--', alpha=0.3)
ax2.set_xlabel('k (单位：π/a)', fontsize=12)
ax2.set_ylabel('E (单位：ℏ²/(2ma²))', fontsize=12)
ax2.set_title('自由电子模型能带', fontsize=13, fontweight='bold')
ax2.grid(True, alpha=0.3)
ax2.set_xlim(-1, 1)

plt.tight_layout()
plt.show()

# 计算态密度（简化版本）
def density_of_states_1d(E, t=1.0):
    """
    一维紧束缚模型的态密度
    """
    # 避免除以零
    E_safe = np.clip(E, -2*t + 1e-10, 2*t - 1e-10)
    dos = 1 / (np.pi * np.sqrt(4*t2 - E_safe2))
    return dos

E_range = np.linspace(-1.99, 1.99, 500)
dos = density_of_states_1d(E_range)

plt.figure(figsize=(8, 6))
plt.plot(E_range, dos, 'g-', linewidth=2)
plt.xlabel('能量 E (单位：t)', fontsize=12)
plt.ylabel('态密度 DOS', fontsize=12)
plt.title('一维紧束缚模型态密度', fontsize=14, fontweight='bold')
plt.grid(True, alpha=0.3)
plt.xlim(-2, 2)
plt.tight_layout()
plt.show()
```

### 5.3 相图计算

```python
import numpy as np
import matplotlib.pyplot as plt

def regular_solution_free_energy(x, T, omega=5000):
    """
    正规溶液模型的自由能
    ΔGmix = RT[x*ln(x) + (1-x)*ln(1-x)] + ωx(1-x)
    
    参数：
        x: 组分摩尔分数
        T: 温度 (K)
        omega: 相互作用参数 (J/mol)
    """
    R = 8.314  # J/(mol·K)
    
    # 避免对数发散
    x_safe = np.clip(x, 1e-10, 1-1e-10)
    
    # 理想混合熵
    S_ideal = -R * (x_safe * np.log(x_safe) + (1-x_safe) * np.log(1-x_safe))
    
    # 过剩焓
    H_excess = omega * x * (1-x)
    
    # 总自由能变化
    deltaG = H_excess - T * S_ideal
    
    return deltaG

# 温度范围
temperatures = [300, 500, 700, 900]
x = np.linspace(0, 1, 200)

plt.figure(figsize=(10, 7))

for T in temperatures:
    G = regular_solution_free_energy(x, T)
    plt.plot(x, G/1000, linewidth=2, label=f'T = {T} K')

plt.xlabel('组分A的摩尔分数 x', fontsize=12)
plt.ylabel('ΔGmix (kJ/mol)', fontsize=12)
plt.title('正规溶液模型：混合自由能', fontsize=14, fontweight='bold')
plt.legend(fontsize=11)
plt.grid(True, alpha=0.3)
plt.axhline(y=0, color='k', linestyle='--', alpha=0.3)
plt.tight_layout()
plt.show()
```

## 第六章：实用技巧与最佳实践

### 6.1 代码组织与模块化

将功能封装成模块：

```python
# chemistry_tools.py

"""
化学计算工具模块
"""

import numpy as np

# 物理常数
AVOGADRO = 6.022e23
PLANCK = 6.62607015e-34
LIGHT_SPEED = 2.99792458e8
BOLTZMANN = 1.380649e-23
GAS_CONSTANT = 8.314

class Molecule:
    """分子类"""
    
    def __init__(self, formula, atoms, coordinates):
        self.formula = formula
        self.atoms = atoms  # 原子符号列表
        self.coordinates = np.array(coordinates)  # N×3坐标数组
    
    def center_of_mass(self, masses):
        """计算质心"""
        total_mass = sum(masses[atom] for atom in self.atoms)
        com = np.zeros(3)
        
        for i, atom in enumerate(self.atoms):
            com += masses[atom] * self.coordinates[i]
        
        return com / total_mass
    
    def moment_of_inertia(self, masses):
        """计算惯性张量"""
        com = self.center_of_mass(masses)
        coords_centered = self.coordinates - com
        
        I = np.zeros((3, 3))
        for i, atom in enumerate(self.atoms):
            r = coords_centered[i]
            m = masses[atom]
            
            I[0, 0] += m * (r[1]2 + r[2]2)
            I[1, 1] += m * (r[0]2 + r[2]2)
            I[2, 2] += m * (r[0]2 + r[1]2)
            I[0, 1] -= m * r[0] * r[1]
            I[0, 2] -= m * r[0] * r[2]
            I[1, 2] -= m * r[1] * r[2]
        
        # 利用对称性
        I[1, 0] = I[0, 1]
        I[2, 0] = I[0, 2]
        I[2, 1] = I[1, 2]
        
        return I

def arrhenius_rate(A, Ea, T):
    """
    Arrhenius速率方程
    k = A * exp(-Ea/RT)
    """
    return A * np.exp(-Ea / (GAS_CONSTANT * T))

def wavelength_to_energy(wavelength_nm):
    """波长转换为能量（eV）"""
    wavelength_m = wavelength_nm * 1e-9
    energy_J = PLANCK * LIGHT_SPEED / wavelength_m
    energy_eV = energy_J / 1.602176634e-19
    return energy_eV
```

### 6.2 错误处理

```python
def safe_division(a, b):
    """安全除法"""
    try:
        result = a / b
        return result
    except ZeroDivisionError:
        print("错误：除数不能为零")
        return None
    except TypeError:
        print("错误：输入必须是数值类型")
        return None

def read_xyz_file(filename):
    """
    读取XYZ格式的分子坐标文件
    """
    try:
        with open(filename, 'r') as f:
            lines = f.readlines()
        
        # 第一行：原子数
        n_atoms = int(lines[0].strip())
        
        # 第二行：注释
        comment = lines[1].strip()
        
        # 后续行：原子坐标
        atoms = []
        coordinates = []
        
        for line in lines[2:2+n_atoms]:
            parts = line.split()
            atoms.append(parts[0])
            coordinates.append([float(x) for x in parts[1:4]])
        
        return atoms, np.array(coordinates), comment
        
    except FileNotFoundError:
        print(f"错误：文件 {filename} 不存在")
        return None, None, None
    except (ValueError, IndexError):
        print("错误：文件格式不正确")
        return None, None, None

# 使用示例
# atoms, coords, comment = read_xyz_file("molecule.xyz")
# if atoms is not None:
#     print(f"成功读取{len(atoms)}个原子")
```

### 6.3 性能优化技巧

```python
import numpy as np
import time

# 示例1：使用NumPy向量化代替循环

# 低效方法
def calculate_distances_slow(coords1, coords2):
    """使用Python循环计算距离"""
    n = len(coords1)
    distances = []
    for i in range(n):
        dist = np.sqrt(sum((coords1[i] - coords2[i])2))
        distances.append(dist)
    return distances

# 高效方法
def calculate_distances_fast(coords1, coords2):
    """使用NumPy向量化计算距离"""
    return np.linalg.norm(coords1 - coords2, axis=1)

# 性能测试
n = 10000
coords1 = np.random.rand(n, 3)
coords2 = np.random.rand(n, 3)

start = time.time()
dist_slow = calculate_distances_slow(coords1, coords2)
time_slow = time.time() - start

start = time.time()
dist_fast = calculate_distances_fast(coords1, coords2)
time_fast = time.time() - start

print(f"循环方法耗时：{time_slow:.4f}秒")
print(f"向量化方法耗时：{time_fast:.4f}秒")
print(f"加速比：{time_slow/time_fast:.1f}x")
```

### 6.4 单位转换工具

```python
class UnitConverter:
    """单位转换工具类"""
    
    # 能量转换（相对于Hartree）
    ENERGY_UNITS = {
        'hartree': 1.0,
        'eV': 27.211386245988,
        'kcal/mol': 627.5094740631,
        'kJ/mol': 2625.4996394799,
        'cm^-1': 219474.6313632
    }
    
    # 长度转换（相对于Bohr）
    LENGTH_UNITS = {
        'bohr': 1.0,
        'angstrom': 0.529177210903,
        'nm': 0.0529177210903,
        'pm': 52.9177210903
    }
    
    @classmethod
    def convert_energy(cls, value, from_unit, to_unit):
        """能量单位转换"""
        if from_unit not in cls.ENERGY_UNITS or to_unit not in cls.ENERGY_UNITS:
            raise ValueError("不支持的能量单位")
        
        # 先转换为Hartree，再转换为目标单位
        value_hartree = value / cls.ENERGY_UNITS[from_unit]
        return value_hartree * cls.ENERGY_UNITS[to_unit]
    
    @classmethod
    def convert_length(cls, value, from_unit, to_unit):
        """长度单位转换"""
        if from_unit not in cls.LENGTH_UNITS or to_unit not in cls.LENGTH_UNITS:
            raise ValueError("不支持的长度单位")
        
        value_bohr = value / cls.LENGTH_UNITS[from_unit]
        return value_bohr * cls.LENGTH_UNITS[to_unit]

# 使用示例
energy_ev = 13.6  # eV
energy_kcal = UnitConverter.convert_energy(energy_ev, 'eV', 'kcal/mol')
print(f"{energy_ev} eV = {energy_kcal:.2f} kcal/mol")

length_angstrom = 1.5  # Å
length_bohr = UnitConverter.convert_length(length_angstrom, 'angstrom', 'bohr')
print(f"{length_angstrom} Å = {length_bohr:.4f} bohr")
```

## 第七章：综合应用案例

### 7.1 案例1：紫外-可见光谱分析

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import find_peaks

class UVVisSpectrum:
    """UV-Vis光谱分析类"""
    
    def __init__(self, wavelength, absorbance):
        self.wavelength = np.array(wavelength)
        self.absorbance = np.array(absorbance)
    
    def find_lambda_max(self):
        """找到最大吸收波长"""
        max_idx = np.argmax(self.absorbance)
        return self.wavelength[max_idx], self.absorbance[max_idx]
    
    def find_peaks(self, prominence=0.1):
        """找到所有峰值"""
        peaks, properties = find_peaks(self.absorbance, prominence=prominence)
        return self.wavelength[peaks], self.absorbance[peaks]
    
    def calculate_molar_absorptivity(self, concentration, path_length=1.0):
        """
        根据Beer-Lambert定律计算摩尔吸光系数
        A = ε * c * l
        
        参数：
            concentration: 浓度 (mol/L)
            path_length: 光程 (cm)
        
        返回：
            ε: 摩尔吸光系数 (L/(mol·cm))
        """
        lambda_max, A_max = self.find_lambda_max()
        epsilon = A_max / (concentration * path_length)
        return epsilon, lambda_max
    
    def plot(self, title="UV-Vis吸收光谱"):
        """绘制光谱"""
        plt.figure(figsize=(10, 6))
        plt.plot(self.wavelength, self.absorbance, 'b-', linewidth=2)
        
        # 标注λmax
        lambda_max, A_max = self.find_lambda_max()
        plt.plot(lambda_max, A_max, 'ro', markersize=10)
        plt.annotate(f'λmax = {lambda_max:.0f} nm', 
                    xy=(lambda_max, A_max),
                    xytext=(lambda_max+30, A_max-0.1),
                    arrowprops=dict(arrowstyle='->', color='red'),
                    fontsize=11, color='red')
        
        plt.xlabel('波长 (nm)', fontsize=12)
        plt.ylabel('吸光度', fontsize=12)
        plt.title(title, fontsize=14, fontweight='bold')
        plt.grid(True, alpha=0.3)
        plt.tight_layout()
        plt.show()

# 模拟数据
wavelength = np.linspace(200, 600, 200)
# 模拟两个高斯峰
absorbance = 0.8 * np.exp(-((wavelength-280)/30)2) + \
             0.5 * np.exp(-((wavelength-350)/40)2)

# 创建光谱对象
spectrum = UVVisSpectrum(wavelength, absorbance)

# 分析
lambda_max, A_max = spectrum.find_lambda_max()
print(f"最大吸收波长：{lambda_max:.1f} nm")
print(f"最大吸光度：{A_max:.3f}")

# 计算摩尔吸光系数
concentration = 1e-5  # mol/L
epsilon, lambda_max = spectrum.calculate_molar_absorptivity(concentration)
print(f"\n摩尔吸光系数 ε({lambda_max:.0f} nm) = {epsilon:.0f} L/(mol·cm)")

# 绘图
spectrum.plot()
```

### 7.2 案例2：化学反应动力学拟合

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

class ReactionKinetics:
    """化学反应动力学分析"""
    
    @staticmethod
    def first_order(t, C0, k):
        """一级反应：C = C0 * exp(-kt)"""
        return C0 * np.exp(-k * t)
    
    @staticmethod
    def second_order(t, C0, k):
        """二级反应：C = C0 / (1 + C0*k*t)"""
        return C0 / (1 + C0 * k * t)
    
    @staticmethod
    def arrhenius(T, A, Ea):
        """Arrhenius方程：k = A * exp(-Ea/RT)"""
        R = 8.314  # J/(mol·K)
        return A * np.exp(-Ea / (R * T))
    
    def fit_reaction_order(self, time, concentration):
        """
        拟合反应级数
        
        返回：
            order: 反应级数（1或2）
            parameters: 拟合参数
            r_squared: R²值
        """
        # 尝试一级反应拟合
        popt_1, _ = curve_fit(self.first_order, time, concentration,
                             p0=[concentration[0], 0.1])
        pred_1 = self.first_order(time, *popt_1)
        ss_res_1 = np.sum((concentration - pred_1)2)
        ss_tot = np.sum((concentration - np.mean(concentration))2)
        r2_1 = 1 - (ss_res_1 / ss_tot)
        
        # 尝试二级反应拟合
        popt_2, _ = curve_fit(self.second_order, time, concentration,
                             p0=[concentration[0], 0.1])
        pred_2 = self.second_order(time, *popt_2)
        ss_res_2 = np.sum((concentration - pred_2)2)
        r2_2 = 1 - (ss_res_2 / ss_tot)
        
        # 选择R²值更高的模型
        if r2_1 > r2_2:
            return 1, popt_1, r2_1
        else:
            return 2, popt_2, r2_2

# 模拟实验数据（一级反应）
time_exp = np.array([0, 5, 10, 15, 20, 25, 30, 40, 50])
C0_true = 1.0
k_true = 0.08
concentration_exp = C0_true * np.exp(-k_true * time_exp)
# 添加噪声
concentration_exp += np.random.normal(0, 0.02, size=concentration_exp.shape)

# 创建动力学分析对象
kinetics = ReactionKinetics()

# 拟合反应级数
order, params, r2 = kinetics.fit_reaction_order(time_exp, concentration_exp)

print(f"反应级数：{order}")
print(f"拟合参数：C0 = {params[0]:.3f}, k = {params[1]:.4f}")
print(f"R² = {r2:.4f}")

# 绘制拟合结果
time_fit = np.linspace(0, 50, 200)
if order == 1:
    concentration_fit = kinetics.first_order(time_fit, *params)
    equation = f'C = {params[0]:.2f} × exp(-{params[1]:.3f}t)'
else:
    concentration_fit = kinetics.second_order(time_fit, *params)
    equation = f'C = {params[0]:.2f} / (1 + {params[0]*params[1]:.3f}t)'

plt.figure(figsize=(10, 6))
plt.scatter(time_exp, concentration_exp, c='red', s=80, 
           label='实验数据', zorder=3)
plt.plot(time_fit, concentration_fit, 'b-', linewidth=2,
        label=f'{order}级反应拟合 (R² = {r2:.4f})')

plt.xlabel('时间 (s)', fontsize=12)
plt.ylabel('浓度 (mol/L)', fontsize=12)
plt.title(f'化学反应动力学分析\n{equation}', 
         fontsize=13, fontweight='bold')
plt.legend(fontsize=11)
plt.grid(True, alpha=0.3)
plt.tight_layout()
plt.show()
```

### 7.3 案例3：分子对接评分函数（简化版）

```python
import numpy as np

class SimpleDocking:
    """简化的分子对接评分"""
    
    def __init__(self, ligand_atoms, protein_atoms):
        """
        初始化
        
        参数：
            ligand_atoms: 配体原子列表 [(element, x, y, z), ...]
            protein_atoms: 蛋白原子列表 [(element, x, y, z), ...]
        """
        self.ligand = ligand_atoms
        self.protein = protein_atoms
        
        # 范德华半径（Å）
        self.vdw_radii = {
            'H': 1.20, 'C': 1.70, 'N': 1.55,
            'O': 1.52, 'S': 1.80, 'P': 1.80
        }
    
    def lennard_jones(self, r, r_min, epsilon):
        """
        Lennard-Jones势能
        V(r) = ε[(r_min/r)^12 - 2(r_min/r)^6]
        """
        ratio = r_min / r
        return epsilon * (ratio12 - 2 * ratio6)
    
    def electrostatic(self, r, q1, q2):
        """
        静电相互作用（简化）
        V = k * q1 * q2 / r
        """
        k = 332.0  # kcal·Å/(mol·e²)
        return k * q1 * q2 / r
    
    def calculate_score(self):
        """
        计算对接分数
        这是一个高度简化的版本
        """
        total_vdw = 0
        total_elec = 0
        
        # 假设的电荷（实际应从分子拓扑获取）
        charges = {'C': 0.0, 'N': -0.3, 'O': -0.4, 'H': 0.1}
        
        for lig_atom in self.ligand:
            lig_elem, lig_x, lig_y, lig_z = lig_atom
            lig_pos = np.array([lig_x, lig_y, lig_z])
            
            for prot_atom in self.protein:
                prot_elem, prot_x, prot_y, prot_z = prot_atom
                prot_pos = np.array([prot_x, prot_y, prot_z])
                
                # 计算距离
                r = np.linalg.norm(lig_pos - prot_pos)
                
                # 跳过太远的相互作用
                if r > 10.0:
                    continue
                
                # 计算LJ势
                r_min = self.vdw_radii[lig_elem] + self.vdw_radii[prot_elem]
                epsilon = 0.1  # 简化值
                vdw = self.lennard_jones(r, r_min, epsilon)
                total_vdw += vdw
                
                # 计算静电势
                q1 = charges.get(lig_elem, 0)
                q2 = charges.get(prot_elem, 0)
                elec = self.electrostatic(r, q1, q2)
                total_elec += elec
        
        total_score = total_vdw + total_elec
        
        return {
            'total': total_score,
            'vdw': total_vdw,
            'electrostatic': total_elec
        }

# 示例：简单的配体和蛋白位点
ligand = [
    ('C', 0.0, 0.0, 0.0),
    ('C', 1.5, 0.0, 0.0),
    ('O', 2.0, 1.2, 0.0),
    ('N', 0.5, -1.0, 0.5)
]

protein = [
    ('C', 3.0, 0.0, 0.0),
    ('C', 3.5, 1.5, 0.0),
    ('N', 2.5, -0.5, 1.0),
    ('O', 1.0, -2.0, -0.5),
    ('C', 4.0, 0.5, 1.0)
]

# 计算对接分数
docking = SimpleDocking(ligand, protein)
scores = docking.calculate_score()

print("对接评分结果：")
print(f"总分：{scores['total']:.2f} kcal/mol")
print(f"范德华作用：{scores['vdw']:.2f} kcal/mol")
print(f"静电作用：{scores['electrostatic']:.2f} kcal/mol")
```

## 第八章：学习资源与进阶方向

### 8.1 推荐的Python库

科学计算基础：

- NumPy：数组和矩阵运算
- SciPy：科学计算算法（优化、积分、插值等）
- Matplotlib：数据可视化
- Pandas：数据处理和分析

化学信息学：

- RDKit：化学信息学和药物设计
- Open Babel：化学文件格式转换
- MDAnalysis：分子动力学轨迹分析
- PyMOL：分子可视化（Python API）

量子化学：

- PySCF：量子化学计算
- ASE（Atomic Simulation Environment）：原子模拟
- GPAW：DFT计算
- Psi4：量子化学软件包（Python接口）

机器学习（材料/化学）：

- Scikit-learn：传统机器学习
- PyTorch/TensorFlow：深度学习
- SchNetPack：分子性质预测
- DeepChem：药物发现的深度学习

### 8.2 学习路线建议

阶段1：Python基础（1-2个月）

- 掌握变量、数据类型、控制流程
- 熟练使用列表、字典等数据结构
- 学会定义和使用函数
- 理解面向对象编程基础

阶段2：科学计算（2-3个月）

- 精通NumPy数组操作
- 学习Matplotlib绘图
- 掌握Pandas数据处理
- 了解SciPy科学算法

阶段3：化学应用（3-6个月）

- 学习化学信息学库（RDKit）
- 实践分子结构处理
- 进行数据分析和可视化
- 编写实用的化学计算脚本

阶段4：专业方向（持续深入）

- 量子化学方向：PySCF、ASE等
- 材料模拟方向：LAMMPS、VASP的Python接口
- 机器学习方向：将ML应用于化学问题
- 高性能计算：并行计算、GPU加速

### 8.3 实践项目建议

1. 分子性质计算器：编写一个程序，输入分子式计算摩尔质量、不饱和度等
    
2. 光谱数据处理工具：自动化处理UV-Vis、IR、NMR数据
    
3. 晶体结构分析器：读取CIF文件，计算晶胞参数、键长键角
    
4. 反应动力学拟合程序：自动拟合实验数据，确定反应级数和速率常数
    
5. 分子可视化工具：使用Matplotlib或更专业的库绘制分子结构
    
6. 量子化学计算流程：自动化设置和运行量子化学计算
    

### 8.4 调试技巧

```python
# 1. 使用print调试
def complex_calculation(x):
    print(f"输入：x = {x}")  # 调试输出
    result = x  2 + 2*x + 1
    print(f"结果：{result}")  # 调试输出
    return result

# 2. 使用assert验证假设
def divide_numbers(a, b):
    assert b != 0, "除数不能为零"
    return a / b

# 3. 使用try-except捕获错误
try:
    result = divide_numbers(10, 0)
except AssertionError as e:
    print(f"错误：{e}")

# 4. 检查数组形状
import numpy as np
A = np.array([[1, 2], [3, 4]])
print(f"矩阵A的形状：{A.shape}")
print(f"矩阵A的数据类型：{A.dtype}")
```

## 总结

本教程涵盖了Python在材料化学和量子化学领域的核心应用。从基础语法到专业计算，从数据处理到可视化，希望能帮助您在科研道路上更加高效。

关键要点回顾：

1. Python基础：掌握变量、数据结构、函数、控制流程
2. NumPy：高效的数组和矩阵运算，化学计算的基石
3. 可视化：使用Matplotlib绘制专业的科学图表
4. 数据处理：利用Pandas处理实验数据
5. 专业应用：量子化学、材料模拟、分子对接等

学习建议：

- 多动手编写代码，实践是最好的老师
- 从简单问题开始，逐步解决复杂的科研问题
- 阅读优秀的开源代码，学习最佳实践
- 加入Python化学社区，与同行交流

持续学习： Python生态系统不断发展，新的库和工具层出不穷。保持学习热情，关注领域最新动态，将编程能力转化为科研生产力！

祝您在Python学习和化学研究中取得丰硕成果！


















```typ
#import "@preview/plotsy-3d:0.2.1": plot-3d-parametric-surface
#set align(left)
#set text(font: "New Computer Modern")

#let R = 4.0  // major radius
#let r = 1.5  // minor radius

// Parametric equations of a torus
#let x(u, v) = (R + r * calc.cos(v)) * calc.cos(u)
#let y(u, v) = (R + r * calc.cos(v)) * calc.sin(u)
#let z(u, v) = r * calc.sin(v)

#grid( columns:(2fr,1fr,), rows:(auto,), inset: 10pt, stroke:gray+1pt,
align(center+horizon)[
#figure(
  caption: [3D Torus rendered with `plotsy-3d` ],
  plot-3d-parametric-surface(
    x, y, z,
    udomain: (0, 2 * calc.pi),
    vdomain: (0, 2 * calc.pi),
    xaxis:(-6,6) ,
    yaxis:(-6,6) ,
    zaxis:(-2,2) ,   
    subdivisions: 5, 
    scale-dim: (0.05, 0.05, 0.05),
    axis-step: (1, 1, 1),
    dot-thickness: 0.04em,
    front-axis-thickness: 0.12em,
    rear-axis-text-size: 0.6em,
    axis-labels: ($x$, $y$, $z$),
    axis-label-size: 1.8em,
    rotation-matrix: ((-2, 2, 4), (0, -1, 0)),
    xyz-colors: (rgb("#e74c3c"), rgb("#2ecc71"), rgb("#3498db")),
  )
)],
align(left+horizon)[
*Parametric equations of a torus* #linebreak()
$x(u, v) = (R + r * cos(v)) * cos(u)$ #linebreak()
$y(u, v) = (R + r * cos(v)) * sin(u)$  #linebreak()
$z(u, v) = r * sin(v)$], )
```





```python

# 在 JupyterLite / Pyodide 环境中使用的微型包管理器
# micropip 是 Pyodide 提供的专用工具，用于在浏览器中动态安装 Python 包
# 异步安装 numpy 包（因为 Pyodide 环境下的安装是异步的，必须使用 await）
# 异步安装 matplotlib 包（绘图用，常一起安装）

import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 参数设置
r = 1.0   # 管半径（tube radius）
R = 3.0   # 中心到管中心的距离（major radius）

# 生成参数网格
angle = np.linspace(0, 2 * np.pi, 100)
theta, phi = np.meshgrid(angle, angle)

# Torus 参数方程
x = (R + r * np.cos(phi)) * np.cos(theta)
y = (R + r * np.cos(phi)) * np.sin(theta)
z = r * np.sin(phi)

# 创建图形
fig = plt.figure(figsize=(8, 8))
ax = fig.add_subplot(111, projection='3d')

# 绘制曲面
ax.plot_surface(x, y, z, cmap='viridis', alpha=0.9)

# 设置坐标轴标签
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# 计算统一的坐标轴范围
max_range = R + r
ax.set_xlim([-max_range, max_range])
ax.set_ylim([-max_range, max_range])
ax.set_zlim([-max_range, max_range])

# 可选：关闭自动缩放以避免 matplotlib 自动调整比例
ax.auto_scale_xyz([-max_range, max_range],
                  [-max_range, max_range],
                  [-max_range, max_range])

plt.tight_layout()
plt.show()
```




请生成一个包含 CeTZ 代码的单一 Markdown 文档，用于直观地演示以下列出的每个线性代数主题，每个主题都需要介绍相应的数学背景或相关的知识，所有数学公式全部使用CeTZ内置的行内数学公式格式，CeTZ 代码块使用cetz:0.4.2版本。文档使用全英文编写。请你自行决定篇幅。
需要可视化的内容：矩阵乘法，特征值 / 特征向量，SVD（奇异值分解），变换矩阵（平移、旋转、缩放、透视），四元数，投影矩阵。





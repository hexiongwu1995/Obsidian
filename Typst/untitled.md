




```python
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
# polar角 映射内管周长
# theta角映射方位角
angle = np.linspace(0, 2 * np.pi, 100)
polar,phi = np.meshgrid(angle, angle) 

# Torus 参数方程
x = (R + r * np.cos(polar)) * np.cos(phi) 
y = (R + r * np.cos(polar)) * np.sin(phi) 
z = r * np.sin(polar) 

# 创建图形
fig = plt.figure(figsize=(6, 6))
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





```python

import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

import matplotlib.pyplot as plt

from mpl_toolkits.mplot3d import axes3d

plt.style.use('_mpl-gallery')

# Make data
X, Y, Z = axes3d.get_test_data(0.05)

# Plot
fig, ax = plt.subplots(subplot_kw={"projection": "3d"})
ax.plot_wireframe(X, Y, Z, rstride=10, cstride=10)

ax.set(xticklabels=[],
       yticklabels=[],
       zticklabels=[])

plt.show()
```


















请生成一个包含 CeTZ 代码的单一 Markdown 文档，用于直观地演示以下列出的每个线性代数主题，每个主题都需要介绍相应的数学背景或相关的知识，所有数学公式全部使用CeTZ内置的行内数学公式格式，CeTZ 代码块使用cetz:0.4.2版本。文档使用全英文编写。请你自行决定篇幅。
需要可视化的内容：矩阵乘法，特征值 / 特征向量，SVD（奇异值分解），变换矩阵（平移、旋转、缩放、透视），四元数，投影矩阵。





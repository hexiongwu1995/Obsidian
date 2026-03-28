

```python

import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")

# Create a 3D Torus
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LightSource
# from mpl_toolkits.mplot3d import Axes3D

R, r = 3, 0.8
polar = np.linspace(0, 2*np.pi, num=40, endpoint=True)
phi   = np.linspace(0, 2*np.pi, num=40, endpoint=True)
Polar, Phi= np.meshgrid(polar, phi)
x= (R + r* np.cos(Polar))* np.cos(Phi)
y= (R+ r* np.cos(Polar))* np.sin(Phi)
z= r* np.sin(Polar)

xticks= np.linspace(-R-r, R+r, num=3)
yticks= np.linspace(-R-r, R+r, num=3)
zticks= np.linspace(-r,r, num=3)
xticklabels=(r'$-(R+r)$', '0', r'$(R+r)$')
yticklabels=(r'$-(R+r)$', '0', r'$(R+r)$')
zticklabels=(r'$-(R+r)$', '0', r'$(R+r)$')

lim=(-(R+r), (R+r))
margin= 1.5
fig= plt.figure(figsize=(6,4))
ax= fig.add_subplot(1, 1, 1, projection= '3d', frame_on=True, xlabel='x', ylabel='y', zlabel='z', xlim=lim, ylim=lim, zlim=lim, xticks=xticks, xticklabels=xticklabels, yticks=yticks, yticklabels=yticklabels, zticks=zticks, zticklabels=zticklabels, xmargin=margin, title='3D Torus')
ax.plot_surface(x, y, z, color= 'blue', shade=True, lightsource= LightSource(azdeg=270, altdeg=10) )
plt.show()
```





```python
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")

# Create a professional 3D Torus
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LightSource
import matplotlib.cm as cm  # for potential future extensions

# Parameters
R, r = 3.0, 0.8

# Higher-resolution angular grids
polar = np.linspace(0, 2 * np.pi, num=30, endpoint=True)
phi   = np.linspace(0, 2 * np.pi, num=30, endpoint=True)
Polar, Phi = np.meshgrid(polar, phi)

# Parametric equations (unchanged)
x = (R + r * np.cos(Polar)) * np.cos(Phi)
y = (R + r * np.cos(Polar)) * np.sin(Phi)
z = r * np.sin(Polar)

# Tick settings
xticks = np.linspace(-(R + r), R + r, num=3)
yticks = np.linspace(-(R + r), R + r, num=3)
zticks = np.linspace(-r, r, num=3)

xticklabels = (r'$-(R+r)$', '0', r'$(R+r)$')
yticklabels = (r'$-(R+r)$', '0', r'$(R+r)$')
zticklabels = (r'$-r$', '0', r'$r$')

# Figure and 3D axes
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Axis labels, limits, and ticks
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
ax.set_title('3D Torus', fontsize=16, pad=20)

ax.set_xlim(-(R + r), R + r)
ax.set_ylim(-(R + r), R + r)
ax.set_zlim(-r, r)

ax.set_xticks(xticks)
ax.set_xticklabels(xticklabels)
ax.set_yticks(yticks)
ax.set_yticklabels(yticklabels)
ax.set_zticks(zticks)
ax.set_zticklabels(zticklabels)

# Correct aspect ratio so the minor radius looks circular
ax.set_box_aspect([1, 1, r / (R + r)])

# Nice viewing angle
ax.view_init(elev=35, azim=45)

# Modern clean look: transparent panes
ax.xaxis.pane.fill = False
ax.yaxis.pane.fill = False
ax.zaxis.pane.fill = False

# High-quality surface with improved lighting and shading
ax.plot_surface(
    x, y, z,
    color='dodgerblue',
    alpha=0.92,
    shade=True,
    lightsource=LightSource(azdeg=315, altdeg=45),
    rstride=1,
    cstride=1,
    antialiased=True,
    linewidth=0
)

plt.tight_layout()
plt.show()
```







```python
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt

polar = np.linspace(start=0, stop=5, num=6, endpoint=True, dtype=int)
phi   = np.linspace(start=0, stop=5, num=6, endpoint=True, dtype=int)
Polar, Phi= np.meshgrid(polar, phi)
z=Polar*Phi

print("Polar: ")
print(Polar)
print("Phi: ")
print(Phi)
print("z: ")
print(z)


fig= plt.figure(figsize=(6,4))
ax= fig.add_subplot(1,3,(2,3), projection='3d')

ax.plot_surface(Polar, Phi, z)
ax.set_xlabel('Polar')
ax.set_ylabel('Phi')
ax.set_zlabel('z')
plt.show()
```






















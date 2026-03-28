





```python
import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LightSource

R, r= 3, 0.8
polar, phi= np.meshgrid( np.linspace(start=0, stop= 2* np.pi, num=40, endpoint=True), np.linspace(start=0, stop= 2* np.pi, num=40, endpoint=True) )
x= (R + r* np.cos(polar))* np.cos(phi)
y= (R + r* np.cos(polar))* np.sin(phi)
z= r* np.sin(polar)

fig= plt.figure(figsize=(8,6))
ax= fig.add_subplot(111, projection='3d') 

ax.plot_surface(x, y, z, rstride=1, cstride=1, color=(0, 0.6, 0.9, 0.9), linewidth=0, shade = True, lightsource= LightSource(azdeg=0, altdeg=-20, hsv_min_val=0.2, hsv_max_val=0.9), antialiased=True )
ax.set_box_aspect(aspect=(R+r, R+r, r), zoom=1.0)
ax.set_title(label='3D Torus')
ax.set_xlim(xmin= -(R + r), xmax=(R + r))
ax.set_ylim(ymin= -(R + r), ymax=(R + r))
ax.set_zlim(zmin= - r, zmax= r)

ax.set_xticks((-(R+r), 0, R+r),(" ", "0", "R+r"))
ax.set_yticks((-(R+r), 0, R+r),(" ", "0", "R+r"))
ax.set_zticks((-r, 0, r),(" ", "0", "r"))
ax.tick_params(axis='both', which='both', direction='in', labelsize=7, grid_alpha=0)
ax.set_xlabel(xlabel='x', labelpad=1)
ax.set_ylabel(ylabel='y', labelpad=1)
ax.set_zlabel(zlabel='z', labelpad=1)
ax.grid(visible=None)
ax.view_init(elev= 25, azim=-45, vertical_axis='z')

# 可选：关闭自动缩放以避免 matplotlib 自动调整比例???
ax.auto_scale_xyz([-(R+r), R+r], [-(R+r), R+r], [-r, r]  )

plt.show()
```
















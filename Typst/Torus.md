





```python

import micropip
await micropip.install("numpy")
await micropip.install("matplotlib")

# Create a 3D Torus
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LightSource
from mpl_toolkits.mplot3d import Axes3D

R, r = 3, 0.8
polar= np.linspace(0, 2*np.pi, num=40, endpoint=True)
phi= np.linspace(0, 2*np.pi, num=40, endpoint=True)
Polar, Phi= np.meshgrid(polar, phi)
x= (R + r* np.cos(Polar))* np.cos(Phi)
y= (R+ r* np.cos(Polar))* np.sin(Phi)
z= r* np.sin(Polar)

fig= plt.figure(figsize=(6,4))
ax= fig.add_subplot(111, projection= '3d')

ax.plot_surface(x, y, z, color= 'blue', shade=True, lightsource= LightSource(azdeg=270, altdeg=10) )

ax.set(zlim=(-4,4))
ax.set_title('3D Torus')
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
plt.show()
```




























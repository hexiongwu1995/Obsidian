

普朗克分布（Planck distribution）的黑体辐射谱态密度公式： $\displaystyle \rho(\lambda, T) = \frac{8\pi hc}{\lambda^5} \frac{1}{e^{hc/\lambda kT} - 1}$ 



```python
import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import scipy.constants as const
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FuncFormatter

h = const.physical_constants['Planck constant'][0]
c = const.physical_constants['speed of light in vacuum'][0]
k = const.physical_constants['Boltzmann constant'][0]
# lambda_ is wavelength in micrometer
lambda_ = np.linspace(start=0.1, stop=15, num=400, endpoint=True)
lam= lambda_ * 1e-6
T_list = np.array([800, 1000, 1500, 2000])

fig, ax = plt.subplots(figsize=(7,5), nrows=1, ncols=1)
for T in T_list: 
    rho = 8 * np.pi * h * c/( lam**5)   * 1/( np.exp(h *c/ (lam * k * T)) - 1 )
    ax.scatter(lambda_, rho, s=1, label= f'T={T} K', zorder=2)

ax.set_xlabel(xlabel=r"Wavelength in micrometer")
ax.set_ylabel(ylabel= r"Spectra energy density ( $J \cdot m^{-3}m^{-1}$ )")
ax.set_title("Blackbody spectra energy density (Planck's law)", fontsize=8)


# === Tick settings ===
# Major ticks with labels, every 5 μm
ax.xaxis.set_major_locator(MultipleLocator(5.0)) 
# Minor ticks without labels, every 0.5 μm
ax.xaxis.set_minor_locator(MultipleLocator(0.5))

ax.grid(visible=True, which='both', axis='both', color=(0.95, 0.95, 0.95, 0.9), zorder=0)
ax.legend()

fig.text(0.05, 0.8, r'$\rho(\lambda, T) = \frac{8 \pi h c}{\lambda^5} \frac{1}{ e^{h c / \lambda k T} - 1 }$', fontsize=12)
fig.text(0.05, 0.6, rf"h= {const.physical_constants['Planck constant'][0]:.3e} Js")
fig.text(0.05, 0.5, rf"c= {const.physical_constants['speed of light in vacuum'][0]:.3e} m/s")
fig.text(0.05, 0.4, rf"k= {const.physical_constants['Boltzmann constant'][0]:.3e} J/K")
fig.text(0.05, 0.3, rf"T= {T_list} K")

fig.subplots_adjust(left=0.5, right=0.95, bottom=0.2, top=0.9)
plt.show()
```













普朗克分布（Planck distribution）的黑体辐射谱态密度公式： $\displaystyle \rho_R(\lambda) = \frac{8\pi hc}{\lambda^5} \frac{1}{e^{hc/\lambda kT} - 1}$ 














































```run-python
import numpy as np
import matplotlib.pyplot as plt
import scipy.constants as const

h = const.physical_constants['Planck constant'][0]
c = const.physical_constants['speed of light in vacuum'][0]
k = const.physical_constants['Boltzmann constant'][0]
# lambda is wavelength in micrometer
lambda_ = np.linspace(start=0.1, stop=20, num=400, endpoint=True)
lam= lambda_ * 1e-6
T = 1000
rho = 8 * np.pi * h * c/( lam**5)   * 1/( np.exp(h *c/ (lam * k * T)) - 1 )

fig, ax = plt.subplots(figsize=(8,4), nrows=1, ncols=2, width_ratios=[1,2],)

ax[0].text(0.1, 0.9, r'$\rho(\lambda) = \frac{8 \pi h c}{\lambda^5} \frac{1}{ e^{h c / \lambda k T} - 1 }$', fontsize=12)
ax[0].text(0.1, 0.8, rf"h= {const.physical_constants['Planck constant'][0]:.3e} Js")
ax[0].text(0.1, 0.7, rf"c= {const.physical_constants['speed of light in vacuum'][0]:.3e} m/s")
ax[0].text(0.1, 0.6, rf"k= {const.physical_constants['Boltzmann constant'][0]:.3e} J/K")


ax[1].scatter(lambda_, rho, s=1)
ax[1].set_ylabel(ylabel= r"Spectra energy density ( $J \cdot m^{-3}m^{-1}$ )")
ax[1].text(-10, 200, r'$\rho(\lambda) = \frac{8 \pi h c}{\lambda^5} \frac{1}{ e^{h c / \lambda k T} - 1 }$', fontsize=12)


print("Planck constant: \t  h= ", const.physical_constants['Planck constant'])
print("Speed of light in vacuum: \t  c=", const.physical_constants['speed of light in vacuum'])
print("Boltzmann constant: \t k=", const.physical_constants['Boltzmann constant'])

plt.show()
```



































```run-python
import scipy.constants as const

print('\n Plank constant:', const.physical_constants['Planck constant'])

print('\n Planck constant in eV/Hz:', const.physical_constants['Planck constant in eV/Hz'])

print('\n speed of light in vacuum:', const.physical_constants['speed of light in vacuum'])

print('\n Boltzmann constant:', const.physical_constants['Boltzmann constant'])

print('\n Boltzmann constant in eV/K', const.physical_constants['Boltzmann constant in eV/K'])
```



```run-python
import scipy.constants as const

value, unit, uncertainty= const.physical_constants['Planck constant']
print('Planck constant: \t h=', const.h, 'J⋅s')
```





```run-python
import scipy.constants as const

# 获取电子摩尔质量
value, unit, uncertainty = const.physical_constants['electron molar mass']

print(f"Electron molar mass = {value} {unit}")
print(f"Relative uncertainty ≈ {uncertainty/value*100:.2e}%")

# 与电子质量对比（可选）
electron_mass = const.physical_constants['electron mass'][0]
N_A = const.N_A
print(f"电子质量 m_e = {electron_mass} kg")
print(f"验证: m_e * N_A ≈ {electron_mass * N_A:.10f} kg/mol")
```










```run-python
from scipy.constants import h, c, k
print(h)
```



















```run-python
import numpy as np
import matplotlib.pyplot as plt
import scipy.constants as const

print(const.h)
print(const.c)
print(const.k)
print(const.hbar)
print(const.physical_constants['Planck constant'])
print(const.physical_constants['Boltzmann constant'])
```








```run-python

import numpy as np
import matplotlib.pyplot as plt
from scipy.constants import h, c, k  # Planck's h, speed of light c, Boltzmann constant k

# Planck's law for spectral radiance in terms of wavelength (in SI units)
def planck_lambda(lam, T):
    """ρ_R(λ) = 8πhc / λ⁵  / (exp(hc/(λkT)) - 1)"""
    exponent = h * c / (lam * k * T)
    return (8 * np.pi * h * c / lam**5) / (np.exp(exponent) - 1)

# Wavelength range: 100 nm to 3000 nm (covers visible and near-IR)
lam_nm = np.linspace(100, 3000, 2000)          # wavelength in nm
lam = lam_nm * 1e-9                            # convert to meters for calculation

# Choose several temperatures (in Kelvin)
temperatures = [3000, 4000, 5000, 5800, 7000]

plt.figure(figsize=(8, 5))

for T in temperatures:
    rho = planck_lambda(lam, T)
    plt.plot(lam_nm, rho, linewidth=2, label=f'T = {T} K')

plt.xlabel('Wavelength λ (nm)')
plt.ylabel(r'$Spectral Radiance ρ_R(λ)  [W·m⁻²·sr⁻¹·m⁻¹]$')
plt.title("Blackbody Spectral Radiance (Planck's Law) at Different Temperatures")
plt.legend()
plt.grid(True, alpha=0.3)

# Highlight the visible light region (approximately 380–780 nm)
plt.axvspan(380, 780, color='yellow', alpha=0.1, label='Visible light')

plt.xlim(100, 3000)
plt.ylim(bottom=0)

plt.tight_layout()
plt.show()
```

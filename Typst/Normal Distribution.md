




```run-python
import matplotlib.pyplot as plt
import numpy as np

mosaic=[['PDF','B'],['C','D']]
fig , ax = plt.subplot_mosaic(mosaic, figsize=(6,5), layout="constrained", width_ratios=[1.5,1], height_ratios=[1.2,1])

mu, sigma = 1.2, 2.3
x_PDF = np.linspace(start=mu- 4*sigma, stop=mu+ 4*sigma, num=200, endpoint=True)
y_PDF = 1/(sigma * np.sqrt(2*np.pi)) * np.exp( (-(x_PDF-mu)**2)/(2*sigma**2) )
ax['PDF'].plot(x_PDF, y_PDF, color="blue", linewidth=1, linestyle="solid", label="PDF")
ax['PDF'].set_xlabel(r'$x$')
ax['PDF'].set_ylabel(r'$Probability \  density$')
ax['PDF'].set_title("Normal Distribution")
ax['PDF'].axis([mu-4.5*sigma, mu+4.5*sigma, 0, 0.25])
ax['PDF'].set_xticks([mu-3*sigma, mu-2*sigma, mu- sigma, mu, mu+ sigma, mu+ 2*sigma, mu+3*sigma], [r"$\mu -3 \sigma$", r"$\mu -2 \sigma$", r"$\mu - \sigma$", r"$\mu$", r"$\mu + \sigma$", r"$\mu +2 \sigma$", r"$\mu +3 \sigma$"])
ax['PDF'].tick_params(axis="x", labelsize=7, labelrotation=-90)

ax['PDF'].fill_between(x_PDF, y_PDF, 0, where=((x_PDF > mu- 1*sigma) & (x_PDF < mu+ 1* sigma)), color="blue", alpha=0.1, label= r"$\mu \pm 1 \sigma$(68.27%)" )
ax['PDF'].fill_between(x_PDF, y_PDF, 0, where=((x_PDF > mu- 2*sigma) & (x_PDF < mu+ 2* sigma)), color="blue", alpha=0.1, label= r"$\mu \pm 2 \sigma$(95.45%)" )
ax['PDF'].fill_between(x_PDF, y_PDF, 0, where=((x_PDF > mu- 3*sigma) & (x_PDF < mu+ 3* sigma)), color="blue", alpha=0.1, label= r"$\mu \pm 3 \sigma$(99.73%)" )

ax['PDF'].text(mu-4.2*sigma, 0.22, r'$P(x)= \frac{1}{\sqrt{2 \pi  \sigma^2} } exp(-\frac{(x- \mu)^2}{2 \sigma^2} )$', fontsize=8)
ax['PDF'].legend(fontsize=6, loc='upper right')
plt.show()
```




```
import matplotlib.pyplot as plt
import numpy as np

mu, sigma= 1.2, 2.3


```










```run-python
import matplotlib.pyplot as plt
import numpy as np

mosaic=[['PDF','Hist'],['PDF','Hist']]
fig , ax = plt.subplot_mosaic(mosaic, figsize=(7,3), layout= None, width_ratios=[1.1,1])
mu, sigma = 1.2, 2.3

# Probability Density Function
x_PDF = np.linspace(start=mu- 4*sigma, stop=mu+ 4*sigma, num=200, endpoint=True)
y_PDF = 1/(sigma * np.sqrt(2*np.pi)) * np.exp( (-(x_PDF-mu)**2)/(2*sigma**2) )
ax['PDF'].plot(x_PDF, y_PDF, color="blue", linewidth=1, linestyle="solid", label="PDF")
ax['PDF'].set_xlabel(r'$x$', fontsize=8)
ax['PDF'].set_ylabel('Probability  density', fontsize=8)
ax['PDF'].set_title("PDF of Normal Distribution", fontsize=8)
ax['PDF'].axis([mu-4.5*sigma, mu+4.5*sigma, 0, 0.25])
ax['PDF'].set_xticks([mu-3*sigma, mu-2*sigma, mu- sigma, mu, mu+ sigma, mu+ 2*sigma, mu+3*sigma], [r"$\mu -3 \sigma$", r"$\mu -2 \sigma$", r"$\mu - \sigma$", r"$\mu$", r"$\mu + \sigma$", r"$\mu +2 \sigma$", r"$\mu +3 \sigma$"])
ax['PDF'].tick_params(axis="x", labelsize=7, labelrotation=-90)

ax['PDF'].fill_between(x_PDF, y_PDF, 0, where=((x_PDF > mu- 1*sigma) & (x_PDF < mu+ 1* sigma)), color="blue", alpha=0.1, label= r"$\mu \pm 1 \sigma$(68.27%)" )
ax['PDF'].fill_between(x_PDF, y_PDF, 0, where=((x_PDF > mu- 2*sigma) & (x_PDF < mu+ 2* sigma)), color="blue", alpha=0.1, label= r"$\mu \pm 2 \sigma$(95.45%)" )
ax['PDF'].fill_between(x_PDF, y_PDF, 0, where=((x_PDF > mu- 3*sigma) & (x_PDF < mu+ 3* sigma)), color="blue", alpha=0.1, label= r"$\mu \pm 3 \sigma$(99.73%)" )

ax['PDF'].text(mu-4.2*sigma, 0.22, r'$P(x)= \frac{1}{\sqrt{2 \pi  \sigma^2} } exp(-\frac{(x- \mu)^2}{2 \sigma^2} )$', fontsize=8)
ax['PDF'].legend(fontsize=6, loc='upper right')

# Histogram of Normal Distribution

norm_samples=np.random.normal(loc=mu, scale=sigma, size=1000)
ax['Hist'].hist(norm_samples, bins=15, density=True, cumulative=False, histtype='bar', orientation='vertical', color=(0,0,1, 0.2), label='histogram', edgecolor=(1,1,1))
ax['Hist'].set_xticks([mu - 3*sigma, mu - 2*sigma, mu - 1*sigma, mu, mu + 1*sigma, mu + 2*sigma, mu + 3*sigma],[r'$\mu - 3 \sigma$', r'$\mu - 2 \sigma$', r'$\mu - 1 \sigma$', r'$\mu$', r'$\mu + 1 \sigma$', r'$\mu + 2 \sigma$', r'$\mu + 3 \sigma$'])
ax['Hist'].tick_params(axis='x', pad= 2, labelsize=8, labelrotation=-90)
ax['Hist'].set_xlim(left=mu - 4* sigma, right= mu + 4* sigma)
ax['Hist'].set_xlabel(r'normal samples', fontsize=8)
ax['Hist'].set_ylabel('Probability density', fontsize=8)
ax['Hist'].set_title('Histogram of Normal Samples', fontsize=8)
ax['Hist'].legend(fontsize=6, loc='best')

fig.subplots_adjust(left=0.1, wspace=0.5, right=0.95, bottom=0.2, top=0.9)
plt.show()
```



















































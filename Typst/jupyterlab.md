---
jupyter:
  jupytext:
    cell_metadata_filter: -all
    formats: ipynb,md
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.19.1
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---

In probability theory and statistics, a normal distribution or Gaussian distribution is a type of continuous probability distribution for a real-valued random variable. The general form of its probability density function is $f (x)= frac(1, sqrt(2 pi sigma^(2)))exp (- frac((x - mu)^(2), 2 sigma^(2))) thin$ 

The parameter ⁠$mu$ is the mean or expectation of the distribution (and also its median and mode), while the parameter  $sigma^2$ 
 is the variance. The standard deviation of the distribution is the positive value ⁠$sigma$. A random variable with a Gaussian distribution is said to be normally distributed and is called a normal deviate.  

Normal distributions are important in statistics and are often used in the natural and social sciences to represent real-valued random variables whose distributions are not known. Their importance is partly due to the central limit theorem.

Creating a `DataFrame` by passing a dictionary of objects where the keys are the column labels and the values are the column values: 


```python
# Create an interactive 3D Torus
import numpy as np
import plotly.graph_objects as go
from ipywidgets import interact, FloatSlider, IntSlider

def plot_torus(
    R: float = 2.0,
    r: float = 0.5,
    num_u: int = 60,
    num_v: int = 60
):
    """
    Generate and display an interactive 3D torus.
    - R: major radius (distance from center of tube to center of torus)
    - r: minor radius (radius of the tube)
    - num_u: number of segments around the torus (u direction)
    - num_v: number of segments around the tube (v direction)
    """
    # Parametric equations
    u = np.linspace(0, 2 * np.pi, num_u)
    v = np.linspace(0, 2 * np.pi, num_v)
    U, V = np.meshgrid(u, v)

    X = (R + r * np.cos(V)) * np.cos(U)
    Y = (R + r * np.cos(V)) * np.sin(U)
    Z = r * np.sin(V)

    fig = go.Figure(
        data=[
            go.Surface(
                x=X,
                y=Y,
                z=Z,
                colorscale="Viridis",
                showscale=False,
                hoverinfo="x+y+z"
            )
        ]
    )

    fig.update_layout(
        title="Interactive 3D Torus",
        scene=dict(
            xaxis_title="X Axis",
            yaxis_title="Y Axis",
            zaxis_title="Z Axis",
            aspectmode="data",
            camera=dict(
                eye=dict(x=1.5, y=1.5, z=1.0)
            )
        ),
        width=900,
        height=700,
        margin=dict(l=0, r=0, t=40, b=0)
    )

    fig.show()

# Real-time interactive sliders
interact(
    plot_torus,
    R=FloatSlider(
        min=0.5, max=5.0, step=0.1, value=2.0,
        description="Major Radius R"
    ),
    r=FloatSlider(
        min=0.1, max=2.0, step=0.05, value=0.5,
        description="Minor Radius r"
    ),
    num_u=IntSlider(
        min=10, max=200, step=10, value=60,
        description="Segments U"
    ),
    num_v=IntSlider(
        min=10, max=200, step=10, value=60,
        description="Segments V"
    )
)

```












```python
import numpy as np
import matplotlib.pyplot as plt

# Adjustable parameters (change these and re-run)
mu = 0.0
sigma = 1.0

# Generate data
x = np.linspace(mu - 4*sigma, mu + 4*sigma, 1000)
def normal_pdf(x, mu, sigma):
    return (1 / (sigma * np.sqrt(2 * np.pi))) * np.exp( - (x - mu)**2 / (2 * sigma**2) )
pdf = normal_pdf(x, mu, sigma)
samples = np.random.normal(mu, sigma, 500)

fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(9, 4))

# Left: PDF with 3-sigma regions filled in different colors
ax1.plot(x, pdf, 'b-', linewidth=2, label='PDF')
# ±1σ region (~68%)
x_1 = np.linspace(mu - sigma, mu + sigma, 200)
ax1.fill_between(x_1, 0, normal_pdf(x_1, mu, sigma), color='blue', alpha=0.4, label='±1σ (~68%)')
# 1σ to 2σ regions (~27%)
x_2_low = np.linspace(mu - 2*sigma, mu - sigma, 200)
x_2_high = np.linspace(mu + sigma, mu + 2*sigma, 200)
ax1.fill_between(x_2_low, 0, normal_pdf(x_2_low, mu, sigma), color='green', alpha=0.4)
ax1.fill_between(x_2_high, 0, normal_pdf(x_2_high, mu, sigma), color='green', alpha=0.4, label='1σ–2σ (~27%)')
# 2σ to 3σ regions (~4.5%)
x_3_low = np.linspace(mu - 3*sigma, mu - 2*sigma, 200)
x_3_high = np.linspace(mu + 2*sigma, mu + 3*sigma, 200)
ax1.fill_between(x_3_low, 0, normal_pdf(x_3_low, mu, sigma), color='orange', alpha=0.4)
ax1.fill_between(x_3_high, 0, normal_pdf(x_3_high, mu, sigma), color='orange', alpha=0.4, label='2σ–3σ (~4.5%)')
# Outside ±3σ (~0.3%)
x_tail_low = np.linspace(mu - 4*sigma, mu - 3*sigma, 100)
x_tail_high = np.linspace(mu + 3*sigma, mu + 4*sigma, 100)
ax1.fill_between(x_tail_low, 0, normal_pdf(x_tail_low, mu, sigma), color='red', alpha=0.3)
ax1.fill_between(x_tail_high, 0, normal_pdf(x_tail_high, mu, sigma), color='red', alpha=0.3, label='Outside ±3σ (~0.3%)')

ax1.set_title('Normal Distribution PDF - 3-Sigma Rule')
ax1.set_xlabel('x')
ax1.set_ylabel('Probability Density')
ax1.legend(loc='upper right')
# Sigma tick marks
ticks = [mu-3*sigma, mu-2*sigma, mu-sigma, mu, mu+sigma, mu+2*sigma, mu+3*sigma]
ax1.set_xticks(ticks)
ax1.set_xticklabels(['μ−3σ', 'μ−2σ', 'μ−σ', 'μ', 'μ+σ', 'μ+2σ', 'μ+3σ'])

# Right: PDF + histogram + formula
ax2.hist(samples, bins=30, density=True, alpha=0.6, color='gray', label='Histogram (500 samples)')
ax2.plot(x, pdf, 'r-', linewidth=2, label='PDF')
ax2.set_title('PDF with Histogram of 500 Random Samples')
ax2.set_xlabel('x')
ax2.set_ylabel('Density')
ax2.legend()

# Normal distribution formula (English)
formula = r'$f(x)=\frac{1}{\sigma\sqrt{2\pi}}\exp\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)$'
ax2.text(0.02, 0.85, formula, transform=ax2.transAxes, fontsize=9)

plt.tight_layout()
plt.show()
```






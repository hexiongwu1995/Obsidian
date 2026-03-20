



```
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
            aspectmode="cube",
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









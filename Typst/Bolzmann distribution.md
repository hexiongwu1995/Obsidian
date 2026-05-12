

$$p_{i}=\frac{1}{Q} \exp \left(-\frac{\varepsilon_{i}}{k_{\mathrm{B}} T}\right)=\frac{\exp \left(-\frac{\varepsilon_{i}}{k_{\mathrm{B}} T}\right)}{\sum_{j=1}^{M} \exp \left(-\frac{\varepsilon_{j}}{k_{\mathrm{B}} T}\right)}$$

Boltzmann constant:  $K_B = 1.381 \times 10^{-23} J \cdot K^{-1}$ 

Elementary charge:  $e=1.602 \times 10^{-19} C = 1.602 \times 10^{-19} J/V$ 

$1 J= 6.242 \times 10^{18} eV$ 

Boltzmann constant in electron volt: $K_B = 1.381 \times 10^{-23} J \cdot K^{-1}= 8.620 \times 10^{-5} eV/K$ 







```run-python
import numpy as np
import matplotlib.pyplot as plt

kB= 8.620e-5
T= np.array([273.15, 298.15])
kBT= kB * T
print(kBT)
```






```run-python
import numpy as np
import matplotlib.pyplot as plt

def boltzmann_probs(eps, T, kB=1.0):
    exp_terms = np.exp(-eps / (kB * T))
    Z = np.sum(exp_terms)
    return exp_terms / Z

# Scenario parameters
M = 15
delta_eps = 1.0
eps = np.arange(M) * delta_eps          # ε_i = i * Δε
T_values = [0.5, 1.0, 2.0, 5.0]        # several temperatures

# Bar plot at one temperature
T = 1.0
p = boltzmann_probs(eps, T)
plt.bar(range(M), p)
plt.xlabel("Level index $i$")
plt.ylabel("$p_i$")
plt.title(f"Boltzmann distribution at $T = {T}$")
plt.show()

# Heatmap vs temperature (optional)
Ts = np.linspace(0.1, 10, 100)
P = np.array([boltzmann_probs(eps, t) for t in Ts])
plt.imshow(P.T, aspect="auto", origin="lower",
           extent=[Ts[0], Ts[-1], 0, M-1], cmap="viridis")
plt.colorbar(label="$p_i$")
plt.xlabel("$T$")
plt.ylabel("Level $i$")
plt.title("Probability vs temperature")
plt.show()
```








```
import numpy as np
import matplotlib.pyplot as plt

K_B= 8.620e-5 
T= np.array()
```
































```typ
#set page(paper:"a6", flipped:true, margin:1cm)
#set align(center+horizon)

#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*
import cetz.angle:*
import calc:*

let sph(r, theta, phi)={
let x=r* sin(theta)* cos(phi)
let y=r* sin(theta)* sin(phi)
let z=r*cos(theta)
return (x,y,z)
}

scale(x:1.5,y:1.5,z:1.5)

ortho(x:-70deg, y:0deg, z:-110deg,{
let mark-style= ( mark:(end:(symbol:"curved-stealth", fill:black, scale:0.5) ) ) 
line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:(dash:"dashed")) 
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:(dash:"dashed") ) 
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:(dash:"dashed") ) 
content((rel:(0.3,0,0), to: "x.end"), $x$) 
content((rel:(0,0.3,0), to: "y.end"), $y$) 
content((rel:(0,0,0.3), to: "z.end"), $z$) 


on-xy(z:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin")) 
on-xz(y:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin")) 
on-yz(x:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin")) 

let (O, P)= ((0,0,0), sph(3.5, pi/4, pi/3 ) )
line(O,P,stroke:(dash:"dashed") , ..mark-style ) 
content((rel:(0, 0.5, 0.1), to: P), $P(r,theta,phi)$)
scope({
rotate(z:60deg);
on-xz(y:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin",));
})

let (PX,PY,PZ)=P
let (Px,Py,Pz,Pxy)=((PX,0,0),(0,PY,0),(0,0,PZ),(PX,PY,0)) 
line(Pz,P,Pxy,Px,stroke:(dash:"dashed") )
line(O,Pxy,Py,stroke:(dash:"dashed") )
angle((0,0,0),Px, Pxy, radius:PX, label: text(size:15pt,fill:teal)[$phi$], ..mark-style, stroke:(thickness:2pt, paint:teal)) ;
// angle((0,0,0),Pz, P, radius:1cm, label: text(fill:teal)[$theta$], ..mark-style, stroke:(thickness:2pt, paint:teal)); 
scope({
rotate(z:60deg);
on-xz(y:0, arc((0,0),start:90deg, stop:45deg, radius:1.5, anchor:"origin", ..mark-style, stroke:(thickness:2pt,paint:teal), name:"angle-theta"));
content(sph(0.8,pi/8,pi/3),text(size:15pt, fill:teal)[$theta$])
// Is there another method to draw the theta angle?
}) }) })
```

























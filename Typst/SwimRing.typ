/*
目标：绘制一个圆环面(Torus)
1. 将圆环面的几何中心视为原点，把圆环面的中心环线所在平面视为xy平面，同时也是球坐标系的theta=pi/2平面.
2. 同时建立三维直角坐标系(x,y,z)和球坐标系(R,theta,phi)。
3. 直角坐标系中的z轴正向对应球坐标系中theta=0方向，直角坐标系中的x轴正向对应球坐标系中(theta=pi/2, phi=0)的方向。
4. 设圆环面的中心环线的半径为R。
5. 任意phi=constant的半平面与圆环面的相交截面都是一个相同半径的圆形，设这个圆形的半径为r。
6. 以这个圆形的圆心为原点，以圆面所在平面为坐标平面，建立二维极坐标系(polar, radius),选定圆环面的几何中心到截面圆心的方向作为polar=0rad的方向。
7. 需要注意分割方式，由于polar与theta并不是两个独立的分量,theta分量的位置完全由polar分量决定。
8. 分割时必须使用polar分量，因为只有它能线性映射内管的周长。
9. 选定polar分量以后，再选独立分量，发现只有phi分量可选。
10. 把这个圆环面同时沿phi角正向和polar角正向(逆时针)进行分割，分割数量分别设为Phi-num和Polar-num。
11. 则圆环面将被分割成Phi-num*Polar-num个四顶点曲面块。
12. 这些小型的四顶点曲面块由两组平行的对边组成，两组对边都是相互平行的圆弧段? 理论上可以被精确绘制。
13. 但是，由于我不知道怎样在CeTZ当中把这四个独立的圆弧段拼接成一个完整、封闭的曲面，这会妨碍我之后对这些曲面进行颜色填充。
14. 所以，精确绘制圆弧段的方式将只有描边线，无法进行颜色填充。
15. 另一种方案是，使用由这四个顶点构成的矩形块近似替代这些微小曲面。
16. 可以想象通过这种方式绘制的圆环面是由许多个矩形块拼接而成的，绘制结果并不是光滑的曲面。
17. 通过对矩形块的两个对角线向量做叉乘，求解每一个矩形块的法线向量。
18. 通过判断截面圆心到矩形块中心位置的向量与矩形块法线向量之间的夹角来求解矩形块的外法线向量。
19. 使用平行光线模拟太阳光线，使用Lambert's cosine law来计算平行光线的反射光强度，叠加环境光以避免全黑阴影。
20. 将总的反射光强度映射为深浅不一的颜色值。
*/


#set page(paper:"a5", flipped:true, margin:1cm)
#set align(center+horizon)

#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*
import cetz.angle:*
import calc:*
import cetz.util.vector

let sph(r, theta, phi)={
let x=r* sin(theta)* cos(phi)
let y=r* sin(theta)* sin(phi)
let z=r*cos(theta)
return (x,y,z) }

scale(x:1, y:1, z:1)
set-style(mark:(end:(symbol:"stealth", fill:black, scale:0.5)))

ortho(x:-70deg, y:0deg, z:-120deg, sorted:true,{



let Draw-torus(R:4, r:0.6, Phi-num:30, Polar-num:30, Fill:blue, Stroke:none,  Plight:(1,1,0.5), Pintensity:1.0, Aintensity:0.4)= {

// 绘制的坐标轴与Torus之间需要先求解交点，然后进行深度排序
line((0,0,0), (R+r,0,0), name:"x", stroke:(dash:"dotted") ) 
line((0,0,0), (0,R+r,0), name:"y", stroke:(dash:"dotted") ) 
line((0,0,0), (0,0,R+r), name:"z", stroke:(dash:"dotted") ) 
content((rel:(0.4,0,0), to: "x.end"), $x$) 
content((rel:(0,0.4,0), to: "y.end"), $y$) 
content((rel:(0,0,0.4), to: "z.end"), $z$) 

let Get-Coords(Phi,Polar)={
let x= (R+ r*cos(Polar))*cos(Phi)
let y= (R+ r*cos(Polar))*sin(Phi)
let z= r*sin(Polar)
return (x,y,z)
}

for i in range(Phi-num) {
for j in range(Polar-num) {

let Phi-step= 2*pi/Phi-num
let Phi-curr= i* Phi-step
let Phi-next= (i+1)* Phi-step

let Polar-step= 2*pi/Polar-num
let Polar-curr= j* Polar-step
let Polar-next= (j+1)* Polar-step

let Pa= Get-Coords(Phi-curr, Polar-curr)
let Pb= Get-Coords(Phi-curr, Polar-next)
let Pc= Get-Coords(Phi-next, Polar-next)
let Pd= Get-Coords(Phi-next, Polar-curr)

let rect-diagonal-a = vector.sub(Pa, Pc)
let rect-diagonal-b = vector.sub(Pb, Pd)
let normal-of-rect= vector.cross(rect-diagonal-a, rect-diagonal-b)

let rect-center= vector.scale(vector.add(Pa, Pc),0.5)
let tube-center= sph(R, pi/2, (Phi-curr+ Phi-next)/2)
let tubecenter-to-rectcenter= vector.sub( rect-center, tube-center )
let Outward-normal-of-rect= { 
let dot-product= vector.dot(normal-of-rect,tubecenter-to-rectcenter);
if dot-product < 0 { vector.scale(normal-of-rect,-1)} else { normal-of-rect}
}

let normalize-of-rect= vector.norm(Outward-normal-of-rect)
let normalize-of-Plight= vector.norm(Plight)
let P-Diffuse= max(0,vector.dot(normalize-of-rect, normalize-of-Plight))

let Intensity= min(1,Pintensity * P-Diffuse + Aintensity)

let Fill-darken = {if type(Fill)==color { Fill.darken(100% * (1-Intensity) )} else { Fill} }

line(Pa, Pb, Pc, Pd, close:true, fill:Fill-darken.transparentize(40%), mark:none, stroke: Stroke )
/* 
在此处设置stroke:none之前，必须先设置mark:none，否则会报错。
提示：" 'stroke:Stroke' expected color, gradient, tiling, or auto, found none"。
很可能是因为之前已经在set-style中设置了全部路径的mark样式，而mark必须附着于路径之上。 
我查阅了Typst的官方Reference文档，确认stroke可以取none值。此处设置stroke:none也并未报错。 
*/
} } } 

Draw-torus()

}) })



// -------------------------------------------------------------------------------------------------------------------


#set page(paper:"a5", flipped:true, margin:1cm)
#import "@preview/plotsy-3d:0.2.1": plot-3d-parametric-surface
#set align(left)
#set text(font: "New Computer Modern")

#let R = 4.0  // major radius
#let r = 1.5  // minor radius

// Parametric equations of a torus
#let x(u, v) = (R + r * calc.cos(v)) * calc.cos(u)
#let y(u, v) = (R + r * calc.cos(v)) * calc.sin(u)
#let z(u, v) = r * calc.sin(v)

#grid( columns:(3fr,2fr,), rows:(auto,), inset: 10pt, stroke:gray+1pt,
align(center+horizon)[
#figure(
  caption: [3D Torus rendered with `plotsy-3d` ],
  plot-3d-parametric-surface(
    x, y, z,
    udomain: (0, 2 * calc.pi),
    vdomain: (0, 2 * calc.pi),
    xaxis:(-6,6) ,
    yaxis:(-6,6) ,
    zaxis:(-2,2) ,   
    subdivisions: 5, 
    scale-dim: (0.05, 0.05, 0.05),
    axis-step: (1, 1, 1),
    dot-thickness: 0.04em,
    front-axis-thickness: 0.12em,
    rear-axis-text-size: 0.6em,
    axis-labels: ($x$, $y$, $z$),
    axis-label-size: 1.8em,
    rotation-matrix: ((-2, 2, 4), (0, -1, 0)),
    xyz-colors: (rgb("#e74c3c"), rgb("#2ecc71"), rgb("#3498db")),
  )
)],
align(left+horizon)[
*Parametric equations of a torus* #linebreak()
$x(u, v) = (R + r * cos(v)) * cos(u)$ #linebreak()
$y(u, v) = (R + r * cos(v)) * sin(u)$  #linebreak()
$z(u, v) = r * sin(v)$], )


// -------------------------------------------------------------------------------------------------------------------

#set page(paper:"a5", flipped:true, margin:1cm)
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





// -------------------------------------------------------------------------------------------------------------------



#set page(paper:"a4", flipped:false, margin:1cm)
#set align(center+horizon)

```python
# micropip 是 Pyodide 提供的专用工具，用于在浏览器中动态安装 Python 包
# 异步安装 numpy 包（因为 Pyodide 环境下的安装是异步的，必须使用 await）
# 异步安装 matplotlib 包（绘图用，常一起安装）

import micropip
await micropip.install("numpy")
await micropip.install("scipy")
await micropip.install("matplotlib")

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 参数设置
r = 1.0   # 管半径（tube radius）
R = 3.0   # 中心到管中心的距离（major radius）

# 生成参数网格
# polar角 映射内管周长
# theta角映射方位角
angle = np.linspace(0, 2 * np.pi, 100)
polar,phi = np.meshgrid(angle, angle) 

# Torus 参数方程
x = (R + r * np.cos(polar)) * np.cos(phi) 
y = (R + r * np.cos(polar)) * np.sin(phi) 
z = r * np.sin(polar) 

# 创建图形
fig = plt.figure(figsize=(8, 8))
ax = fig.add_subplot(111, projection='3d')

# 绘制曲面
ax.plot_surface(x, y, z, cmap='viridis', alpha=0.9)

# 设置坐标轴标签
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# 计算统一的坐标轴范围
max_range = R + r
ax.set_xlim([-max_range, max_range])
ax.set_ylim([-max_range, max_range])
ax.set_zlim([-max_range, max_range])

# 可选：关闭自动缩放以避免 matplotlib 自动调整比例
ax.auto_scale_xyz([-max_range, max_range], 
[-max_range, max_range],[-max_range, max_range])

plt.tight_layout()
plt.show()
```


























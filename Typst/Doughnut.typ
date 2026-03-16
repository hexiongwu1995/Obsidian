/*
目标：在Typst中使用CeTZ:0.4.2版本绘制一个圆环面(Torus)
详细步骤如下：
1. 将圆环面的几何中心视为原点，把圆环面的中心环线所在平面视为xy平面，同时也是球坐标系的 theta=pi/2平面，同时建立三维直角坐标系(x,y,z)和球坐标系(R,theta,phi)。
2. 直角坐标系中的z轴正向对应球坐标系中theta=0方向，直角坐标系中的x轴正向对应球坐标系中(theta=pi/2, phi=0)的方向。
3. 设圆环面的中心环线的半径为R。
4. 任意phi=constant的半平面与圆环面的相交截面都是一个相同半径的圆形，设这个圆形的半径为r。
5. 以这个圆形的圆心为原点，以圆面所在平面为坐标平面，建立二维极坐标系(polar, radius),选定圆环面的几何中心到截面圆心的方向作为polar=0rad的方向。
6. 把这个圆环面同时沿theta角正向和polar角正向(逆时针)进行分割，分割数量分别设为theta-num和polar-num。
7. 则圆环面将被分割成theta-num*polar-num个四顶点曲面，这个四顶点曲面的两组对边都是圆弧段，可以被精确绘制。
8. 但是，我不知道应该怎样把这四个独立的圆弧段合并成一个封闭的曲面，这决定了我后续无法对这些曲面进行颜色填充。
9. 发现分割方式错误，因为polar与theta并不是两个独立的正交分量,theta分量的位置完全由polar分量决定。
10. 分割时必须使用polar分量，因为只有它能线性对应内管的周长。
11. 选定polar分量以后，再选独立分量，发现只有phi分量可选。Dead end.
*/

#set page(paper:"a4", flipped:true, margin:1cm)
#set align(center + horizon)
#set text(size:1em)

#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*
import calc:*
set-style( mark:(end:(symbol:"stealth", fill:black, scale:0.5)) )
set-style(stroke:orange)
ortho(x:300deg, y:0deg, z:240deg, {

line((0,0,0), (4,0,0), name:"x")
line((0,0,0), (0,4,0), name:"y")
line((0,0,0), (0,0,4), name:"z")
content((rel:(0.3,0,0), to:"x.end"), $x$)
content((rel:(0,0.3,0), to:"y.end"), $y$)
content((rel:(0,0,0.3), to:"z.end"), $z$)

let cir-num=1
for i in range(cir-num) {
let interval= 2* pi/cir-num
rotate(z:interval* 1rad)
on-yz(x:0, {
circle((0,4), radius:2, name:"cir") ;

}) } 

line((0,0,0),"cir.20%")

let Draw-torus(R:4, r:1, theta-num:20, polar-num:20)={
let theta-max= atan( r/R )



for i in range(theta-num) {
for j in range(polar-num) {
let theta-step= 2*theta-max/theta-num
let polar-step= 2*pi/polar-num

let theta-curr= -i* theta-step
let polar-curr= j* polar-step


content((0,0,-7), text(size:15pt)[#theta-max])
content((0,0,-8), text(size:15pt)[#theta-max.deg()])
content((0,0,-9), text(size:15pt)[#theta-max.rad() rad])

} } 


}


Draw-torus()











})

})


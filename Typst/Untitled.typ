
/*
绘制一个圆环面(Torus)
1. 以圆环面的几何中心作为坐标系原点O
2. 以圆环面的管中心环线所在平面作为xy平面(同时也是球坐标系中theta=pi/2的平面)
3. 任意过z轴的平面与圆环面的相交截面都是一个具有相同半径的圆形，设这个圆形的半径为r
4. 设圆环面的几何中心到管中心环线的距离为R
5. 使用球坐标系，把圆环面沿着phi角正向进行分割，分割数量设为R-num
6. 被分割后的每一个小环面都有两个圆形截面，以圆形截面的圆心作为原点O'
7. 在圆形截面所在平面建立极坐标系(polar,rho)，设polar=0rad的方向为由圆环面几何中心指向截面圆心的方向。
8. 将每一个小环面沿着polar正向进行分割，分割数量设为r-num
9. 经过两次分割，圆环面被分割成了R-num*r-num个小型的四顶点曲面块，这些小型的四顶点曲面块可以使用由这四个顶点构成的矩形块近似替代。
10. 可以想象通过这种方式绘制的圆环面是由许多个矩形块拼接而成的，最终结果并不是光滑的曲面。
11. 求解每一个矩形块的外法线方向
12. 使用平行光线模拟太阳光线，使用Lambert's cosine law来计算反射光强度，叠加环境光以避免全黑阴影。
13. 将总的反射光强度转化为深浅不一的颜色值
14. 设置描边颜色
*/


#set page(paper:"a4", flipped:true, margin:0.2cm)
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
return (x,y,z)
}

scale(x:1.5,y:1.5,z:1.5)

ortho(x:300deg, y:0deg, z:280deg,{
let mark-style= ( mark:(end:(symbol:"curved-stealth", fill:black, scale:0.5) ) ) 
line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:(dash:"dashed")) 
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:(dash:"dashed") ) 
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:(dash:"dashed") ) 
content((rel:(0.3,0,0), to: "x.end"), $x$) 
content((rel:(0,0.3,0), to: "y.end"), $y$) 
content((rel:(0,0,0.3), to: "z.end"), $z$) 

let Rdivision=1
for k in range(Rdivision) {
let Rinterval= 2*pi/Rdivision
scope({
rotate(z:k*Rinterval) ;
on-yz(x:0, 
{circle((0,4), radius:0.2cm, name:"cir"); 
line("cir.south","cir.north", stroke:(dash:"dotted"));
line("cir.west","cir.east", stroke:(dash:"solid"))
line("cir.center","cir.10%", stroke:(paint:orange))
} ) }) } 


let Draw-torus(R:4, r:0.6, Rnum:10, rnum:10, fill:orange, stroke:none, Plight:(1,1,1), Pintensity:0.2, Aintensity:0.1)= {

let Get-Coords(Phi,Polar)={
let x= (R+ r*cos(Polar))*cos(Phi)
let y= (R+ r*cos(Polar))*sin(Phi)
let z= r*sin(Polar)
return (x,y,z)
}

for i in range(Rnum) {
for j in range(rnum) {

let Phi-step= 2*pi/Rnum
let Phi-curr= i* Phi-step
let Phi-next= (i+1)* Phi-step

let Polar-step= 2*pi/rnum
let Polar-curr= j* Polar-step
let Polar-next= (j+1)* Polar-step

let Pa= Get-Coords(Phi-curr, Polar-curr)
let Pb= Get-Coords(Phi-curr, Polar-next)
let Pc= Get-Coords(Phi-next, Polar-next)
let Pd= Get-Coords(Phi-next, Polar-curr)

let rect-diagonal-a = vector.sub(Pa, Pc)
let rect-diagonal-b = vector.sub(Pb, Pd)
let normal-of-rect= vector.cross(rect-diagonal-a, rect-diagonal-b)
let normalize-of-rect= vector.norm(normal-of-rect)
let normalize-of-Plight= vector.norm(Plight)
let Diffuse= max(0,vector.dot(normalize-of-rect, normalize-of-Plight))
let Intensity= min(1,Pintensity*Diffuse + Aintensity)

// The following if segment run into an error, error message: "cannot join array with color". Please investigate this matter and provide some insights and solutions to me.
let fill-lighten(fill)= {if type(fill)==std.color {let fill-lighten= fill.lighten(100%*(Intensity - 0.5)); return fill-lighten} else {return fill} }

line(Pa, Pb, Pc, Pd, close:true, fill:fill-lighten(fill), stroke:none)
} } 

}

Draw-torus()


}) })
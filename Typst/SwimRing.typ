/*
绘制一个圆环面(Torus)
1. 以圆环面的几何中心作为坐标系原点O
2. 以圆环面的管中心环线所在平面作为xy平面(同时也是球坐标系中theta=pi/2的平面)
3. 任意过z轴的平面与圆环面的相交截面都是一个具有相同半径的圆形，设这个圆形的半径为r
4. 设圆环面的几何中心到管中心环线的距离为R
5. 使用球坐标系，把圆环面沿着phi角正向进行分割，分割数量设为phi-num
6. 被分割后的每一个小环面都有两个圆形截面，以圆形截面的圆心作为原点O'
7. 在圆形截面所在平面建立极坐标系(rho,polar)，设polar=0rad的方向为由圆环面几何中心指向截面圆心的方向。
8. 将每一个小环面沿着polar正向进行分割，分割数量设为polar-num
9. 经过两次分割，圆环面被分割成了phi-num*polar-num个小型的四顶点曲面块，这些小型的四顶点曲面块可以使用由这四个顶点构成的矩形块近似替代。
10. 可以想象通过这种方式绘制的圆环面是由许多个矩形块拼接而成的，最终结果并不是光滑的曲面。
11. 求解每一个矩形块的外法线方向
12. 使用平行光线模拟太阳光线，使用Lambert's cosine law来计算反射光强度，叠加环境光来避免全黑阴影。
13. 将总的反射光强度转化为深浅不一的颜色值
14. 设置描边颜色
*/

#set page(paper:"a4", flipped:true, margin:1cm)
#set align(center+horizon)

#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*
import calc:*

let sph(r, theta, phi)={
let x=r* sin(theta)* cos(phi)
let y=r* sin(theta)* sin(phi)
let z=r*cos(theta)
return (x,y,z)
}


scale(x:2,y:2,z:2)

ortho(x:300deg, y:0deg, z:250deg,{
let mark-style= ( mark:(end:(symbol:"curved-stealth", fill:black, scale:0.5) ) ) 
line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:gray ) 
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:gray ) 
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:gray ) 
content((rel:(0.3,0,0), to: "x.end"), $x$) 
content((rel:(0,0.3,0), to: "y.end"), $y$) 
content((rel:(0,0,0.3), to: "z.end"), $z$) 


on-xy(z:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin")) 
on-xz(y:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin")) 
on-yz(x:0, arc((0,0),start:0deg, stop:90deg, radius:3.5, anchor:"origin")) 

let O=(0,0,0) 
let P= sph(3.5, pi/4, pi/3 ) 
line(O,P) 

let A=(0,0,3.5)
let B=sph(3.5, pi/2, pi/3)
arc-through(A, P, B)
})

let Daw-torus(R:4, r:0.6, Rnum:30, rnum:30, fill:orange, stroke:none, Plight:(1,1,1), Pintensity:0.8, Aintensity:0.2)= {

}

})
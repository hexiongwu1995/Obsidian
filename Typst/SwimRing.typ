
/*
This Typst code snippet is intended to draw a torus
1. 以Torus的质心所在位置为坐标原点
2. 设Torus的中心圆环的半径为 R
3. 以Torus的中心圆环所在平面为xz平面，则任意过y轴的平面，在Torus上的切面为一个相同半径的圆环，设这个半径为 r
4. Torus的中心圆环上的任意一点P可以使用球坐标(R, calc.pi/2, phi)来表示。
5. 通过 phi参数将Torus分割成许多份，每一份都包含两个圆形切面
6. 使用这两个圆形切面上的4个相邻边框锚点构建封闭矩形对Torus表面进行近似，对封闭矩形填充颜色
*/

#set page(paper:"a4", flipped:true)
#set align(center+horizon)
#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*

let linspace(start, end, n:10)= {
let step= (end - start)/n 
let arr= range(n+1).map(a => start + a* step)
return arr }

let sph(radius, theta, phi)={
let x= radius * calc.sin(theta) * calc.sin(phi) 
let y= radius * calc.cos(theta) 
let z= radius * calc.sin(theta) * calc.cos(phi) 
return (x,y,z) }



scale(2)
ortho(x:20deg, y:20deg, z:0deg,{
let mark-style= ( mark:(end:(symbol:"curved-stealth", fill:black, scale:0.5) ) )
line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:gray )
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:gray )
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:gray )
content((rel:(0.3,0,0), to: "x.end"), $x$)
content((rel:(0,0.3,0), to: "y.end"), $y$)
content((rel:(0,0,0.3), to: "z.end"), $z$)


let Draw-Torus(R:4, r:0.5, Rnum:10, rnum:10)={
for (idxa,i) in range(Rnum+1).enumerate() {
let phi-step = 2* calc.pi/Rnum 
let phi-i = i* phi-step 
circle(sph(R, calc.pi/2, phi-i), radius:r, name:"circle-"+ str(idxa) , stroke:(paint:gray.transparentize(95%))) 
}

for j in range(Rnum) {
for k in range(rnum) {
let r-curr-percent = str(k*(100/rnum))+ "%" 
let r-next-percent = str((k+1)*(100/rnum))+ "%" 
line("circle-" + str(j) + "." + r-curr-percent,   "circle-" + str(j) + "." + r-next-percent, 
"circle-" + str(j+1) + "." + r-next-percent, "circle-" + str(j+1) + "." + r-curr-percent,  
close:true, stroke:gray, fill:green.transparentize(80%))

} } }

Draw-Torus(R:4, r:0.5, Rnum:30, rnum:30)

}) })

/* 
step by step analysis
circle-0,..., circle-10 exist
The first segment
j=0, k=0, r-curr-percent= 0%, r-next-percent= 10%, line("circle-0.0%", "circle-0.10%", "circle-1.0%", "circle-1.10%", close:true)
j=0, k=1, r-curr-percent= 10%, r-next-percent= 20%, line("circle-0.10%", "circle-0.20%", "circle-1.10%", "circle-1.20%", close:true)
...
j=0, k=9, r-curr-percent= 90%, r-next-percent= 100%, line("circle-0.90%", "circle-0.100%", "circle-1.90%", "circle-1.100%", close:true)
...

The second segment
j=1, k=0, r-curr-percent= 0%, r-next-percent= 10%, line("circle-1.0%", "circle-1.10%", "circle-2.0%", "circle-2.10%", close:true)
j=1, k=1, r-curr-percent= 10%, r-next-percent= 20%, line("circle-1.10%", "circle-1.20%", "circle-2.10%", "circle-2.20%", close:true)
...
j=1, k=9, r-curr-percent= 90%, r-next-percent= 100%, line("circle-1.90%", "circle-1.100%", "circle-2.90%", "circle-2.100%", close:true)

*/
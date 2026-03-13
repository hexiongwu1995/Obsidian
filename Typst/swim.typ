// This Typst code snippet is intended to draw a torus
#set page(paper:"a5", flipped:true)
#set align(center+horizon)
#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*

let linspace(start, end, n:10)= {
let step= (end - start)/n 
let arr= range(n+1).map(a => start + a* step)
return arr }

ortho(x:20deg, y:20deg, z:0deg,{
let mark-style= (mark:(end:(symbol:")>", fill:black, scale:0.5)))
line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:gray )
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:gray )
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:gray )
content((rel:(0.3,0,0), to: "x.end"), $x$)
content((rel:(0,0.3,0), to: "y.end"), $y$)
content((rel:(0,0,0.3), to: "z.end"), $z$)

for j in linspace(0, 2* calc.pi, n:100) {
rotate(y:j*1rad, origin:(0,0,0))
on-xy(z:0, circle((4,0), radius:0.6, stroke:(paint:blue.transparentize(90%), thickness:10pt)))
}
})   })



// This Typst code snippet is intended to draw a torus
#set page(paper:"a4", flipped:true)
#set align(center+horizon)
#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*

let linspace(start, end, n:10)= {
let step= (end - start)/n 
let arr= range(n+1).map(a => start + a* step)
return arr }
scale(2)
ortho(x:20deg, y:20deg, z:0deg,{
let mark-style= (mark:(end:(symbol:")>", fill:black, scale:0.5)))
line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:gray )
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:gray )
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:gray )
content((rel:(0.3,0,0), to: "x.end"), $x$)
content((rel:(0,0.3,0), to: "y.end"), $y$)
content((rel:(0,0,0.3), to: "z.end"), $z$)
on-xy(z:0, circle((4,0), radius:1.5, ))

/*
1. 以游泳圈的质心所在位置为坐标原点
2. 游泳圈的中心圆环的半径为 R
3. 任意过y轴的平面，在游泳圈上的切面为一个相同半径的圆形，设这个半径为 r
4. 游泳圈的中心圆环上的任意一点P可以使用 P(R, 0, φ)来表示。
5. 通过 φ参数将游泳圈分割成100份，每一份都包含两个圆形切面
6. 使用两个圆形切面上的4个相邻路径锚点构建封闭矩形对游泳圈表面进行近似
7. 对封闭矩形填充颜色
*/


})   })
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
set-origin()})   })


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


   
   
   
   })   })

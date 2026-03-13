#set page(paper:"a4", flipped:true)
#set align(center+horizon)
#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw:*

let mark-style= (mark:(end:(symbol:")>", fill:black, scale:0.5)))

line((0,0,0), (4,0,0), name:"x",..mark-style, stroke:gray )
line((0,0,0), (0,4,0), name:"y",..mark-style, stroke:gray )
line((0,0,0), (0,0,4), name:"z",..mark-style, stroke:gray )
content((rel:(0.3,0,0), to: "x.end"), $x$)
content((rel:(0,0.3,0), to: "y.end"), $y$)
content((rel:(0,0,0.3), to: "z.end"), $z$)

})
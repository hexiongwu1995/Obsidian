#set align(center)
#import "@preview/cetz:0.4.2"

#cetz.canvas({

import cetz.draw: *

// Define a float-compatible range() function
let linspace(start, end, num)= {
let step =  (end - start)/num ;
let arr = range(num).map(a => start + a * step )
arr 
} 
// Archimedean spiral r = 0.4 * theta
grid((-3,-3),(3,3), help-lines:true) 
let theta-array = linspace(0, 2*calc.pi, 60) 
for theta in theta-array {
let r = 0.4 * theta 
circle((theta*1rad, r), radius:2pt, fill:black, stroke:none) 
}
content((-3,3.5), [Archimedean spiral #linebreak() $r = 0.4 * theta$], anchor:"south-west")

})









#set align(center)
#import "@preview/cetz:0.4.2"
#cetz.canvas({
import cetz.draw: *

intersections("i", {
  circle((0, 0))
  bezier((0,0), (3,0), (1,-1), (2,1))
  line((0,-1), (0,1))
  rect((1.5,-1),(2.5,1))
})
for-each-anchor("i", (name) => {
  circle("i." + name, radius: .1, fill: blue)
})

get-ctx(ctx => {
for j in range(7) { 
let (ctx, intersection_j)= cetz.coordinate.resolve(ctx, i.j)
content((rel:(0, -1)), [intersection_j: #intersection_j]) }
})

})


























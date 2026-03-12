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































```tikz
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=1,thick,>=latex]
%设定观察角度
\tdplotsetmaincoords{60}{110}
\begin{scope}[tdplot_main_coords]
%绘制三维直角坐标系
\draw[->,dotted](0,0,0)--(6,0,0)node[font=\large,below]{x};
\draw[->,dotted](0,0,0)--(0,6,0)node[font=\large,below]{y};
\draw[->,dotted](0,0,0)--(0,0,6)node[font=\large,left]{z};

%在xy平面绘制圆弧和绘制方位角φ
\begin{scope}[canvas is xy plane at z=0]
\draw[thick](5,0,0)arc[start angle =0,end angle=90,radius=5];
%注意上方命令中的(5,0,0)是使用canvas命令变换坐标系后，在新坐标系中的直角坐标。
\draw[->,color=cyan](1.5,0,0)arc[start angle =0,end angle=60,radius=1.5] node[midway,below,font=\Large,color=cyan,transform shape,rotate=120] {$\vec{\phi}$};
\end{scope}

%绘制φ=0°处的经线
\tdplotsetthetaplanecoords{0}
\begin{scope}[tdplot_rotated_coords]
%使用tdplotsetthetaplane命令后，会将绘图平面固定在φ=0平面内，φ=0平面随即被设置为新的xy平面，下方的(5,0,0)是新坐标系中的直角坐标

\draw[thick](5,0,0)arc[start angle=0,end angle=90,radius=5];
\end{scope}

%绘制φ=90°处的经线
\tdplotsetthetaplanecoords{90}
\begin{scope}[tdplot_rotated_coords]
\draw[thick](5,0,0)arc[start angle=0,end angle=90,radius=5];
\end{scope}

%绘制φ=60°处的经线
\tdplotsetthetaplanecoords{60}
\begin{scope}[tdplot_rotated_coords]
\draw[thick](5,0,0)arc[start angle=0,end angle=90,radius=5];
%绘制极角θ方向
\draw[->,color=cyan](2,0,0)arc[start angle=0,end angle=45,radius=2] node[midway, above, font=\large, color=cyan, transform shape, rotate=-40] {$\vec{\theta}$};
\end{scope}
%选定球面一点P，绘制OP向量
\coordinate (O) at (0,0,0);
\tdplotsetcoord{P}{5}{45}{60};
\fill[cyan](P)circle[radius=1pt];
\draw[->](O)--(P);
\node[font=\small,cyan,left=0.1] at (O) {O};
\node[font=\small,cyan,right=0.1] at (P) {$P(r,\theta,\phi)$};
%绘制P点的空间位置关系（展现球坐标与直角坐标之间的关系）
\draw[dotted](P)--(Pxy);
\draw[dotted](O)--(Pxy);
\draw[dotted](P)--(Pz);
\draw[dotted](Pxy)--(Px);
\draw[dotted](Pxy)--(Py);

\end{scope}
\end{tikzpicture}
\end{document}
```




```
let sph(radius, theta, phi)={
let x= radius* calc.sin(theta)* calc.sin(phi)
let y= radius* calc.cos(theta)
let z= radius* calc.sin(theta)* calc.cos(phi)
return (x,y,z)
}
```



```
// This Typst code snippet is intended to draw a torus

/*
1. 以Torus的质心所在位置为坐标原点
2. Torus的中心圆环的半径为 R
3. 以Torus的中心圆环所在平面为xz平面，则任意过y轴的平面，在Torus上的切面为一个相同半径的圆环，设这个半径为 r
4. Torus的中心圆环上的任意一点P可以使用球坐标(R, calc.pi/2, phi)来表示。
5. 通过 phi参数将游泳圈分割成40份，每一份都包含两个圆形切面
6. 使用两个圆形切面上的4个相邻路径锚点构建封闭矩形对Torus表面进行近似
7. 对封闭矩形填充颜色
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


let Draw-Torus(R:4, r:0.5, num:40)={

for(idx,j) in linspace(0, 2*calc.pi, n:num).enumerate() { 
circle( sph(R, calc.pi/2, j), radius:r, name:"circle-"+str(idx), stroke:(paint:gray.transparentize(80%))) 
 
let r=0.5
let num=40
let segment=40

for k in range(num) {
  for path-anchor in range(segment) {
  let interval= 2* calc.pi * r/segment
  let p= path-anchor* interval 
line("circle-"+str(k)+"."+str(p), "circle-"+str(k)+"."+str(p+interval), "circle-"+str(k+1)+"."+str(p), "circle-"+str(k+1)+"."+str(p+interval),fill:green)
}

}
}}
Draw-Torus(R:4, r:0.5, num:40)



}) })
```






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






---
math-engine: mathjax
---

## TikZ示例



```tikz
\usepackage{pgfplots}
\pgfplotsset{compat=1.16}
\begin{document}
\begin{tikzpicture}
\begin{axis}[colormap/viridis]
\addplot3[ surf, samples=18, domain=-3:3 ] {exp(-x^2-y^2)*x};
\end{axis}
\end{tikzpicture}
\end{document}
```

axis 环境最常用语法：

```latex
\begin{axis}[
    % 常用选项（可以组合使用）
    width=10cm,
    height=8cm,
    xlabel={$x$},
    ylabel={$y$},
    zlabel={$z$},
    title={标题},
    colormap/viridis, % 或 hot, jet, plasma, magma, parula, coolwarm...
    colormap/name=hot,% 另一种写法
    colorbar,         % 显示颜色条
    colorbar title={$值$},
    view={45}{30},    % 3D 视角 (方位角, 仰角)
    domain=-2:2,      % x 和 y 的默认取值范围
    y domain=-3:3,    % 只改 y 范围
    samples=50,       % 采样点数（越大越精细，但越慢）
    samples y=30,     % 分别控制 x/y 方向采样
    mesh, surf, faceted color,% 不同绘制风格
    shader=interp,    % 光滑着色（flat, interp, faceted）
]
% 这里放各种 \addplot, \addplot3 等命令
\end{axis}
```


最完整的 \addplot3 语法形式（参考）：
```latex
\addplot3[
    % 样式选项
    surf, mesh, scatter, only marks,
    samples=40, samples y=30,
    domain=-4:4, y domain=-5:5,
    z domain=-1:1,   % 很少用
    thick, line width=0.8pt,
    draw=black, fill=blue!30,
    shader=interp,   % flat / faceted / interp
    opacity=0.8,
    colormap/viridis,
] 
{表达式}  % 如 exp(-x^2-y^2)
coordinates {(x1,y1,z1) (x2,y2,z2) ...} % 或者直接给数据点
table {x y z ...}; % 或者从表格读
```


## 第 一部分:教程和指南

为了帮助你开始使用 TikZ,本手册不是从冗长的安装和配置部分开始,而是从教程开始。它们解释了系统的所有基本功能和一些更高级的功能,而不涉及所有细节。这一部分还包含一些关于使用 TikZ 创建图形时应如何进行的指南。

```tikz
\begin{document}
\begin{tikzpicture}
\draw[thick,rounded corners=8pt] (0,0)--(0,2)--(1,3.25)--(2,2)--(2,0)--(0,2)--(2,2)--(0,0)--(2,0);
\end{tikzpicture}
\end{document}
```

### 2 教程:为 Karl 的学生制作图片

本教程面向 TikZ 的新用户。它不会详尽地介绍 TikZ 的所有功能,只介绍你可能立即使用的那些功能。

Karl 是一名数学和化学高中教师。他过去使用 LaTeX 的 `{picture}` 环境在他的工作表和考试中创建图形。虽然结果可以接受,但创建图形往往是一个漫长的过程。此外,线条的角度往往略有偏差,圆似乎也很难画好。当然,他的学生根本不在乎线条的角度是否完全正确,他们发现 Karl 的考试太难了,无论画得多么漂亮。但 Karl 从未完全满意结果。

Karl 的儿子对结果更不满意(毕竟他不必参加考试),他告诉 Karl 他可能想尝试一个用于创建图形的新包。有点令人困惑的是,这个包似乎有两个名字:首先,Karl 必须下载并安装一个名为 pgf 的包。然后发现在这个包里面还有另一个名为 TikZ 的包,它应该代表"TikZ ist kein Zeichenprogramm"。Karl 觉得这一切都有点奇怪,TikZ 似乎表明这个包不能做他需要的事情。然而,使用了相当长时间的 gnu 软件和"gnu not being Unix",似乎还是有希望的。他的儿子向他保证,TikZ 的名字是为了警告人们 TikZ 不是一个可以用鼠标或平板电脑绘制图形的程序。相反,它更像是一种"图形语言"。

#### 2.1 问题陈述

Karl 想在下一份工作表上为他的学生放一个图形。他目前正在教学生关于正弦和余弦的知识。他想要的是看起来像这样的东西(理想情况下):

一个显示三角函数关系的图形,包含坐标轴、单位圆、角度 $\alpha$、以及 $\sin \alpha$、$\cos \alpha$ 和 $\tan \alpha$ 的几何表示,还有解释性文字。

在示例中角度 $\alpha$ 是 $30°$(弧度为 $\pi/6$)。$\alpha$ 的正弦值,即红线的高度,是 $\sin \alpha = 1/2$。

根据勾股定理,我们有 $\cos^2 \alpha + \sin^2 \alpha = 1$。因此蓝线的长度,即 $\alpha$ 的余弦,必须是 $\cos \alpha = \sqrt{1 - 1/4} = \frac{1}{2}\sqrt{3}$。

这表明 $\tan \alpha$,即橙线的高度,是 $\tan \alpha = \frac{\sin \alpha}{\cos \alpha} = 1/\sqrt{3}$。

#### 2.2 设置环境
在 TikZ 中,要绘制图片,在图片开始时你需要告诉 TeX 或 LaTeX 你想要开始一个图片。在 LaTeX 中,这是使用环境 `{tikzpicture}` 完成的,在纯 TeX 中,你只需使用 `\tikzpicture` 来开始图片,使用 `\endtikzpicture` 来结束它。

##### 2.2.1 在 LaTeX 中设置环境

Karl 作为 LaTeX 用户,因此这样设置他的文件:

```tikz
\usepackage{tikz}
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\end{tikzpicture}.
\end{document}
```

当执行时,即通过 pdflatex 或通过 latex 后跟 dvips 运行时,结果将包含看起来像这样的东西:

We are working on(显示一个十字形).

```tik
%We are working on
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\end{tikzpicture}.
\end{document}
```

诚然,还不是完整的图片,但我们确实建立了坐标轴。嗯,不完全是,但我们已经画出了构成坐标轴的线条。Karl 突然有一种沮丧的感觉,图片还有很长的路要走。

让我们更详细地看看代码。首先,加载了包 tikz。这个包是基本 pgf 系统的所谓"前端"。基本层,也在本手册中描述,更加,嗯,基础,因此更难使用。前端通过提供更简单的语法使事情变得更容易。

在环境内部有两个 `\draw` 命令。它们的意思是:"应该绘制路径,该路径在命令后指定,直到分号。"第一个路径指定为 `(-1.5,0) -- (1.5,0)`,意思是"从位置 $(-1.5, 0)$ 的点到位置 $(1.5, 0)$ 的点的直线"。这里,位置在一个特殊的坐标系统中指定,其中,最初,一个单位是 1cm。

Karl 很高兴地注意到环境自动保留了足够的空间来包含图片。

##### 2.2.2 在纯 TeX 中设置环境

Karl 的妻子 Gerda 也是数学教师,她不是 LaTeX 用户,而是使用纯 TeX,因为她更喜欢"老式的方式"。她也可以使用 TikZ。她需要写 `\input tikz.tex` 而不是 `\usepackage{tikz}`,写 `\tikzpicture` 而不是 `\begin{tikzpicture}`,写 `\endtikzpicture` 而不是 `\end{tikzpicture}`。

因此,她会使用:

```tik
\begin{document}
%% Plain TeX file
\input tikz.tex
\baselineskip=12pt
\hsize=6.3truein
\vsize=8.7truein
% We are working on
\tikzpicture
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\endtikzpicture.
\bye
\end{document}
```

Gerda 可以使用 pdftex 或 tex 与 dvips 一起排版此文件。TikZ 会自动识别她使用的驱动程序。如果她希望使用 dvipdfm 与 tex 一起使用,她需要修改文件 pgf.cfg 或者可以在输入 tikz.tex 或 pgf.tex 之前的某处写 `\def\pgfsysdriver{pgfsys-dvipdfm.def}`。

##### 2.2.3 在 ConTeXt 中设置环境

Karl 的叔叔 Hans 使用 ConTeXt。像 Gerda 一样,Hans 也可以使用 TikZ。他说 `\usemodule[tikz]` 而不是 `\usepackage{tikz}`。他写 `\starttikzpicture` 而不是 `\begin{tikzpicture}`,写 `\stoptikzpicture` 而不是 `\end{tikzpicture}`。

他的示例版本如下所示:

```tik
%% ConTeXt file
\usemodule[tikz]
\starttext
We are working on
\starttikzpicture
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\stoptikzpicture.
\stoptext
```

Hans 现在将以通常的方式使用 texexec 或 context 排版此文件。

#### 2.3 直线路径构造

TikZ 中所有图片的基本构建块是路径。路径是一系列连接的直线和曲线(这不是全部,但让我们暂时忽略复杂情况)。你通过将起始位置的坐标指定为圆括号中的点来开始路径,如 `(0,0)`。后面跟着一系列"路径扩展操作"。最简单的是 `--`,我们已经使用过了。它后面必须跟着另一个坐标,它将路径以直线扩展到这个新位置。例如,如果我们将坐标轴的两条路径变成一条路径,将得到以下结果:

```tik
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0) -- (0,-1.5) -- (0,1.5);
\end{tikzpicture}
\end{document}

```

Karl 对这里没有 `{tikzpicture}` 环境感到有点困惑。相反,使用了小命令 `\tikz`。这个命令要么接受一个参数(以左花括号开始,如 `\tikz{\draw (0,0) -- (1.5,0)}`,它会产生一条线段),要么收集到下一个分号之前的所有内容,并将其放在 `{tikzpicture}` 环境中。作为经验法则,所有 TikZ 图形绘制命令都必须作为 `\tikz` 的参数或在 `{tikzpicture}` 环境中出现。幸运的是,命令 `\draw` 只会在这个环境内定义,所以你不太可能意外地做错什么。

#### 2.4 曲线路径构造

Karl 接下来想做的是画圆。为此,直线显然不行。相反,我们需要某种方式来绘制曲线。为此,TikZ 提供了一种特殊的语法。需要一个或两个"控制点"。它们背后的数学并不完全简单,但这里是基本思想:假设你在点 $x$,第一个控制点是 $y$。那么曲线将开始"在 $x$ 处朝 $y$ 的方向前进",也就是说,曲线在 $x$ 处的切线将指向 $y$。接下来,假设曲线应该在 $z$ 处结束,第二个支持点是 $w$。那么曲线将确实在 $z$ 处结束,并且曲线在点 $z$ 处的切线将通过 $w$。

这里是一个例子(为了清楚起见,添加了控制点):

```tikz
\begin{document}
\begin{tikzpicture}
\filldraw [gray] (0,0) circle [radius=2pt];
\filldraw [gray] (1,1) circle [radius=2pt];
\filldraw [gray] (2,1) circle [radius=2pt];
\filldraw [gray] (2,0) circle [radius=2pt];
\draw (0,0) .. controls (1,1) and (2,1) .. (2,0);
\end{tikzpicture}
\end{document}
```

以"曲线"方式扩展路径的一般语法是 `.. controls <第一个控制点> and <第二个控制点> .. <结束点>`。你可以省略 `and <第二个控制点>`,这会导致第一个控制点被使用两次。

所以,Karl 现在可以将上半圆添加到图片中:

```tikz
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (-1,0) .. controls (-1,0.555) and (-0.555,1) .. (0,1)
.. controls (0.555,1) and (1,0.555) .. (1,0);
\end{tikzpicture}
\end{document}
```

Karl 对结果很满意,但发现以这种方式指定圆非常笨拙。幸运的是,有一种更简单的方法。

#### 2.5 圆路径构造

为了画圆,可以使用路径构造操作 `circle`。这个操作后面跟着方括号中的半径,如下例所示:(注意前一个位置用作圆心。)

```latex
\tikz \draw (0,0) circle [radius=10pt];
```

你也可以使用 `ellipse` 操作将椭圆附加到路径。可以指定两个半径,而不是单个半径:

```latex
\tikz \draw (0,0) ellipse [x radius=20pt, y radius=10pt];
```

要绘制轴不是水平和垂直而是指向任意方向的椭圆("旋转的椭圆"),你可以使用变换,稍后会解释。顺便说一下,小椭圆的代码是 `\tikz \draw[rotate=30] (0,0) ellipse [x radius=6pt, y radius=3pt];`。

所以,回到 Karl 的问题,他可以写 `\draw (0,0) circle [radius=1cm];` 来画圆:

```tikz
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\end{tikzpicture}
\end{document}
```

此时,Karl 有点担心,当他希望最终图片大得多时,圆却这么小。他很高兴地了解到 TikZ 具有强大的变换选项,将所有内容按三倍缩放非常容易。但让我们暂时保持原样以节省空间。

#### 2.6 矩形路径构造

接下来我们想要的是背景中的网格。有几种方法可以生成它。例如,可以画很多矩形。由于矩形非常常见,因此有一种特殊的语法:要向当前路径添加矩形,请使用 `rectangle` 路径构造操作。此操作后面应该跟着另一个坐标,并将向路径附加一个矩形,使得前一个坐标和下一个坐标是矩形的角。所以,让我们向图片添加两个矩形:

```tikz
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (0,0) rectangle (0.5,0.5);
\draw (-0.5,-0.5) rectangle (-1,-1);
\end{tikzpicture}
\end{document}
```

虽然这在其他情况下可能不错,但这对 Karl 的问题并没有真正的进展:首先,我们需要大量这样的矩形,然后边界没有"闭合"。

所以,Karl 正准备简单地使用好用的 `\draw` 命令画四条垂直线和四条水平线,这时他了解到有一个 `grid` 路径构造操作。

#### 2.7 网格路径构造

`grid` 路径操作向当前路径添加网格。它将添加构成网格的线条,填充矩形,其一个角是当前点,另一个角是 `grid` 操作后面的点。例如,代码 `\tikz \draw[step=2pt] (0,0) grid (10pt,10pt);` 产生一个小网格。注意 `\draw` 的可选参数如何用于指定网格宽度(还有 `xstep` 和 `ystep` 可以独立定义步长)。正如 Karl 很快会学到的,有很多东西可以使用这样的选项来影响。

对于 Karl,可以使用以下代码:

```tikz
\begin{document}
\begin{tikzpicture}
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw[step=.5cm] (-1.4,-1.4) grid (1.4,1.4);
\end{tikzpicture}
\end{document}
```

再次查看所需的图片,Karl 注意到如果网格更柔和一些会更好。(他的儿子告诉他,如果网格不柔和,往往会分散注意力。)为了使网格柔和,Karl 在绘制网格的 `\draw` 命令中再添加两个选项。首先,他对网格线使用颜色 `gray`。其次,他将线宽减小到 `very thin`。最后,他交换了命令的顺序,使网格首先绘制,其他所有内容都在上面。

```tikz
\begin{document}
\begin{tikzpicture}
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\end{tikzpicture}
\end{document}
```

#### 2.8 添加一点样式

Karl 可以说 `help lines` 而不是选项 `gray,very thin`。样式是预定义的选项集,可用于组织图形的绘制方式。通过说 `help lines`,你是说"使用我(或其他人)为绘制辅助线设置的样式"。如果 Karl 在某个时候决定网格应该使用颜色 `blue!50` 而不是 `gray` 绘制,他可以在某处提供以下选项:

```tik
help lines/.style={color=blue!50,very thin}
```

这个"样式设置器"的效果是,在当前作用域或环境中,`help lines` 选项与 `color=blue!50,very thin` 具有相同的效果。

使用样式使你的图形代码更灵活。你可以以一致的方式轻松更改事物的外观。通常,样式在图片开头定义。但是,你有时可能希望全局定义样式,以便文档的所有图片都可以使用此样式。然后,你可以通过更改这一个样式轻松更改所有图形的外观。在这种情况下,你可以在文档开头使用 `\tikzset` 命令,如

```latex
\tikzset{help lines/.style=very thin}
```

要构建样式层次结构,你可以让一个样式使用另一个样式。因此,为了定义一个基于 `grid` 样式的样式 `Karl's grid`,Karl 可以说

```latex
\tikzset{Karl's grid/.style={help lines,color=blue!50}}
...
\draw[Karl's grid] (0,0) grid (5,5);
```

样式通过参数化变得更加强大。这意味着,像其他选项一样,样式也可以与参数一起使用。例如,Karl 可以参数化他的网格,使其默认为蓝色,但他也可以使用另一种颜色。

```tik
\begin{document}
\begin{tikzpicture}
[Karl's grid/.style ={help lines,color=#1!50},
Karl's grid/.default=blue]
\draw[Karl's grid] (0,0) grid (1.5,2);
\draw[Karl's grid=red] (2,0) grid (3.5,2);
\end{tikzpicture}
\end{document}
```

在此示例中,样式 `Karl's grid` 的定义作为 `{tikzpicture}` 环境的可选参数给出。其他元素的附加样式将在逗号后跟随。当许多样式有效时,环境的可选参数可能很容易比实际内容更长。

#### 2.9 绘图选项

Karl 想知道还有哪些其他选项可以影响路径的绘制方式。他已经看到 `color=<颜色>` 选项可用于设置线条的颜色。选项 `draw=<颜色>` 几乎做同样的事情,只是它只设置线条的颜色,可以使用不同的颜色进行填充(当 Karl 填充角度的弧时需要这个)。

他看到样式 `very thin` 产生非常细的线条。Karl 对此并不感到惊讶,他也不惊讶地了解到 `thin` 产生细线,`thick` 产生粗线,`very thick` 产生非常粗的线,`ultra thick` 产生真的、真的粗的线,`ultra thin` 产生非常细的线,以至于低分辨率打印机和显示器将难以显示它们。他想知道什么能产生"正常"粗细的线条。事实证明 `thin` 是正确的选择,因为它给出与 TeX 的 `\hrule` 命令相同的粗细。然而,Karl 想知道在 `thin` 和 `thick` 之间是否有什么"中间"的东西。确实有:`semithick`。

另一个可以对线条做的有用的事情是虚线或点线。为此,可以使用两种样式 `dashed` 和 `dotted`。这两个选项也存在松散和密集版本,称为 `loosely dashed`、`densely dashed`、`loosely dotted` 和 `densely dotted`。如果他真的、真的需要,Karl 也可以使用 `dash pattern` 选项定义更复杂的虚线模式,但他的儿子坚持认为虚线应该非常谨慎地使用,主要是分散注意力。Karl 的儿子声称复杂的虚线模式是邪恶的。Karl 的学生不关心虚线模式。

#### 2.10 弧路径构造

我们的下一个障碍是绘制角度的弧。为此,`arc` 路径构造操作很有用,它绘制圆或椭圆的一部分。此 `arc` 操作后面跟着方括号中的选项,用于指定弧。一个例子是 `arc[start angle=10, end angle=80, radius=10pt]`,它的意思正如它所说的。Karl 显然需要从 $0°$ 到 $30°$ 的弧。半径应该是相对较小的东西,也许是圆半径的三分之一左右。当使用 `arc` 路径构造操作时,指定的弧将从当前位置开始添加。所以,我们首先必须"到达那里"。

```latex
\begin{tikzpicture}
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
\end{document}
```

Karl 认为这真的有点小,除非他学会如何缩放,否则他无法继续。为此,他可以添加 `[scale=3]` 选项。他可以将此选项添加到每个 `\draw` 命令,但那样会很笨拙。相反,他将其添加到整个环境,这会导致此选项应用于其中的所有内容。

```latex
\begin{tikzpicture}[scale=3]
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
\end{document}
```
至于圆,你可以指定"两个"半径以获得椭圆弧。

```latex
\tikz \draw (0,0)
arc [start angle=0, end angle=315,x radius=1.75cm, y radius=1cm];
```

```tikz
\begin{document}
\begin{tikzpicture}
\draw (0,0) arc [start angle=0, end angle=315, x radius=1.75cm, y radius=1cm];
\end{tikzpicture}
\end{document}
```


#### 2.11 裁剪路径

为了节省本手册的空间,将 Karl 的图形裁剪一点会很好,这样我们就可以专注于"有趣"的部分。在 TikZ 中裁剪非常简单。你可以使用 `\clip` 命令来裁剪所有后续的绘图。它的工作方式类似于 `\draw`,只是它不绘制任何东西,而是使用给定的路径来裁剪之后的所有内容。

```latex
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
```

```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
\end{document}
```

你还可以同时执行这两项操作:绘制和裁剪路径。为此,使用 `\draw` 命令并添加 `clip` 选项。(这不是全部:你也可以使用 `\clip` 命令并添加 `draw` 选项。好吧,这也不是全部:实际上,`\draw` 只是 `\path[draw]` 的简写,`\clip` 是 `\path[clip]` 的简写,你也可以说 `\path[draw,clip]`。)这里是一个例子:

```latex
\begin{tikzpicture}[scale=3]
\clip[draw] (0.5,0.5) circle (.6cm);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\clip[draw] (0.5,0.5) circle (.6cm);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\draw (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm];
\end{tikzpicture}
\end{document}
```

#### 2.12 抛物线和正弦路径构造

虽然 Karl 的图片不需要它们,但他很高兴地了解到有 `parabola`、`sin` 和 `cos` 路径操作,用于向当前路径添加抛物线和正弦、余弦曲线。对于 `parabola` 操作,当前点将位于抛物线上,`parabola` 操作后给出的点也将位于抛物线上。考虑以下示例:

数学上的本质（简单版）
标准抛物线方程：$y = a(x-h)^2 + k$，其中 $(h,k)$ 就是顶点坐标  
抛物线的弯曲点（bend）= 抛物线的顶点（vertex），是整条抛物线曲率变化最剧烈（方向改变最明显）的位置。
在 TikZ 里，如果你不写 `bend`，系统会默认把弯曲点放在起点和终点连线的中点，并默认向上开口。  
写上 `bend` 之后，你就获得了对抛物线“最高/最低点”位置的直接控制权。

标准抛物线方程：$y = a(x-h)^2 + k$，其中 $(h,k)$ 就是顶点坐标 
当给定弯曲点以后，h和k就确定，只剩下一个未知数，只需要一个初始点即可确定未知数a，那么终点坐标就不能被随意指定，因为抛物线方程已经确定。不是这样吗？为什么还可以随意指定终点坐标？
可以随意指定终点坐标，是因为 TikZ 的 parabola 并不是在画数学上完整的标准抛物线， 而是在起点、弯曲点、终点三点之间画一段“尽量像抛物线的曲线”。这是一种视觉上很接近抛物线的三次贝塞尔曲线近似（内部实现细节）。

```latex
\tikz \draw (0,0) rectangle (1,1) (0,0) parabola (1,1);
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\draw (0,0) rectangle (1,1) (0,0) parabola (1,1);
\end{tikzpicture}
\end{document}
```
也可以将弯曲点放在其他地方:
```latex
\tikz \draw[x=1pt,y=1pt] (0,0) parabola bend (4,16) (6,12);
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\draw[x=1pt,y=1pt] (0,0) parabola bend (4,16) (6,12);
\end{tikzpicture}
\end{document}
```

关键点：`sin` 在 TikZ 里的特殊用法
在 TikZ 中，`sin` 和 `cos` 这两个关键词不只是函数名，它们同时也是路径构造指令（path construction operators）。

当你写：(起点) sin (终点)
TikZ 会自动：把起点 → 终点 看成半个正弦波的水平投影，自动补上合适的控制点，让曲线看起来像正弦波的一段
最重要的特性是：连续写多个 sin 的时候，会把上一个终点当作下一个起点，继续接正弦波

x=1.57ex, y=1ex这是在定义当前坐标系的单位长度（basis vectors）：
横向（x 方向）：1 个单位 = 1.57ex（大约 π/2 的宽度）
纵向（y 方向）：1 个单位 = 1ex（大概一个字母 x 的高度）
TikZ 里看到连续的 `sin (x,y) sin (x,y) sin ...`  ：它就是在用正弦波的方式把这些点连起来，而且每一段都尽量做出「半个正弦波」的形状。

他们是真正的数学上的正弦波吗？还是近似？
TikZ 的 sin/cos 是“非常像正弦波的三次贝塞尔曲线近似”，而不是严格的数学正弦函数。 在绝大多数文档、幻灯片、笔记的使用场景下，这个近似已经足够好，绝大多数人都不会注意到差别。

操作 `sin` 和 `cos` 在区间 $[0, \pi/2]$ 中添加正弦或余弦曲线,使得前一个当前点位于曲线的起点,曲线在给定的结束点结束。这里有两个例子:
```latex
A sine curve. A sine \tikz \draw[x=1ex,y=1ex] (0,0) sin (1.57,1); curve.

\tikz \draw[x=1.57ex,y=1ex] (0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
(0,1) cos (1,0) sin (2,-1) cos (3,0) sin (4,1);
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=10]
\draw[x=1.57ex,y=1ex] (0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0);
\end{tikzpicture}
\end{document}
```
```latex
\begin{tikzpicture}[scale=10]
\draw[x=1.57ex,y=1ex] (0,0) sin (1,1)sin(2,2)sin(3,3)sin(2.5,2.5)cos(3.5,1.5)cos(4.5,0.5);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=10]
\draw[x=1.57ex,y=1ex] (0,0) sin (1,1)sin(2,2)sin(3,3)sin(2.5,2.5)cos(3.5,1.5)cos(4.5,0.5);
\end{tikzpicture}
\end{document}
```

#### 2.13 填充和绘制
回到图片,Karl 现在想用非常浅的绿色"填充"角度。为此,他使用 `\fill` 而不是 `\draw`。Karl 的做法如下:

```latex
\begin{document}
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\fill[green!20!white] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- (0,0);
\end{tikzpicture}
\end{document}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\fill[green!20!white] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- (0,0);
\end{tikzpicture}
\end{document}
```

颜色 `green!20!white` 表示 20% 绿色和 80% 白色混合在一起。这种颜色表达式是可能的,因为 TikZ 使用 Uwe Kern 的 xcolor 包,有关颜色表达式的详细信息,请参阅该包的文档。

如果 Karl 最后没有使用 `--(0,0)` "闭合"路径会怎样?在这种情况下,路径会自动闭合,所以这可以省略。实际上,最好写成以下形式:

```latex
\fill[green!20!white] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
```

`--cycle` 导致通过平滑连接第一个和最后一个点来关闭当前路径(实际上是当前路径的当前部分)。要理解差异,请考虑以下示例:

```latex
\begin{tikzpicture}[line width=5pt]
\draw (0,0) -- (1,0) -- (1,1) -- (0,0);
\draw (2,0) -- (3,0) -- (3,1) -- cycle;
\useasboundingbox (0,1.5); % make bounding box higher
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[line width=5pt]
\draw (0,0) -- (1,0) -- (1,1) -- (0,0);
\draw (2,0) -- (3,0) -- (3,1) -- cycle;
\useasboundingbox (0,1.5); % make bounding box higher
\end{tikzpicture}
\end{document}
```
你还可以使用 `\filldraw` 命令同时填充和绘制路径。这将首先绘制路径,然后填充它。这似乎不太有用,但你可以为填充和描边指定不同的颜色。这些作为可选参数指定,如下所示:

```latex
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20!white, draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20!white, draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\end{tikzpicture}
\end{document}
```


#### 2.14 阴影

Karl 简要考虑了通过给角度添加阴影来使其"更花哨"的可能性。不是用均匀的颜色填充区域,而是使用不同颜色之间的平滑过渡。为此,可以使用 `\shade` 和 `\shadedraw`,用于同时阴影和绘制:

```latex
\tikz \shade (0,0) rectangle (2,1) (3,0.5) circle (.5cm);
```
```tikz
\begin{document}
\begin{tikzpicture}
\shade (0,0) rectangle (2,1) (3,0.5) circle (.5cm);
\end{tikzpicture}
\end{document}
```


默认阴影是从灰色到白色的平滑过渡。要指定不同的颜色,你可以使用选项:

```latex
\begin{tikzpicture}[rounded corners,ultra thick]
\shade[top color=yellow,bottom color=black] (0,0) rectangle +(2,1);
\shade[left color=yellow,right color=black] (3,0) rectangle +(2,1);
\shadedraw[inner color=yellow,outer color=black,draw=yellow] (6,0) rectangle +(2,1);
\shade[ball color=green] (9,.5) circle (.5cm);
\end{tikzpicture}
```

```tikz
\begin{document}
\begin{tikzpicture}[rounded corners,ultra thick]
\shade[top color=yellow,bottom color=black] (0,0) rectangle +(2,1);
\shade[left color=yellow,right color=black] (3,0) rectangle +(2,1);
\shadedraw[inner color=yellow,outer color=black,draw=yellow] (6,0) rectangle +(2,1);
\shade[ball color=green] (9,.5) circle (.5cm);
\end{tikzpicture}
\end{document}
```

对于 Karl,以下可能是合适的:

```latex
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\shadedraw[left color=gray,right color=green, draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\end{tikzpicture}
```

```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\shadedraw[left color=gray,right color=green, draw=green!50!black]
(0,0) -- (3mm,0mm)
arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\end{tikzpicture}
\end{document}
```


然而,他明智地决定阴影通常只会分散注意力,而不会为图片添加任何东西。

#### 2.15 指定坐标

Karl 现在想添加正弦和余弦线。他已经知道可以使用 `color=` 选项来设置线条的颜色。那么,指定坐标的最佳方法是什么?

有不同的方法来指定坐标。最简单的方法是说类似 `(10pt,2cm)` 的东西。这意味着 x 方向 10pt,y 方向 2cm。或者,你也可以省略单位,如 `(1,2)`,这意味着"一次当前 x 向量加上两次当前 y 向量"。这些向量默认分别为 x 方向 1cm 和 y 方向 1cm。

为了以极坐标指定点,使用表示法 `(30:1cm)`,这意味着 30 度方向 1cm。这显然对"到达圆上的点 $(\cos 30°,\sin 30°)$"非常有用。

你可以在坐标前面添加一个 `+` 号或两个,如 `+(0cm,1cm)` 或 `++(2cm,0cm)`。这样的坐标解释不同:第一种形式意味着"从先前指定的位置向上 1cm",第二种意味着"从先前指定的位置向右 2cm,并使这成为新指定的位置"。例如,我们可以如下绘制正弦线:

```latex
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[red,very thick] (30:1cm) -- +(0,-0.5);
\draw[red,very thick] (30:1cm) -- (30:1.5cm);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[red,very thick] (30:1cm) -- +(0,-0.5);
\draw[red,very thick] (30:1cm) -- (30:1.5cm);
\end{tikzpicture}
\end{document}
```
两种坐标系统在同一行里同时出现，极坐标(30 : 1cm)的中间是使用冒号分隔，而直角坐标(0 , 0.5)是使用逗号分隔。

| 部分     | 写法           | 坐标系       | 含义                 | 为什么这样写更方便？                |
| ------ | ------------ | --------- | ------------------ | ------------------------- |
| 起点     | `(30:1cm)`   | 极坐标       | 从原点出发，30°方向，距离1cm  | 圆上一点，直接用角度+半径最直观          |
| 位移（终点） | `++(0,-0.5)` | 直角坐标（笛卡尔） | 从当前点再往y方向移动 -0.5单位 | “垂直向下”这个意图，用 (0,-0.5) 最自然 |

为什么 TikZ 允许（甚至鼓励）混用？
因为在实际画图时，不同的部分用不同的思维方式描述更高效：想表达“圆周上的某个角度位置” → 用极坐标 `(角度:半径)` 最直观，想表达“垂直/水平移动”“平行于坐标轴的方向” → 用直角坐标的增量 `(Δx, Δy)` 最清楚，如果强行把终点也写成极坐标，会变得很麻烦。

Karl 使用了 $\sin 30° = 1/2$ 这一事实。然而,他非常怀疑他的学生是否知道这一点，所以能够指定"从 `(30:1cm)` 正下方位于 x 轴上的点"会很好。这确实可以使用特殊语法:Karl 可以写 `(30:1cm |- 0,0)`。一般来说,`(<p> |- <q>)` 的意思是"通过 $p$ 的垂直线和通过 $q$ 的水平线的交点"。

接下来,让我们绘制余弦线。一种方法是说 `(30:1cm |- 0,0) -- (0,0)`。另一种方法如下:我们从正弦结束的地方"继续":

```latex
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm)
arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[red,very thick] (30:1cm) -- +(0,-0.5);
\draw[blue,very thick] (30:1cm) ++(0,-0.5) -- (0,0);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,0.75);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm)
arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[red,very thick] (30:1cm) -- +(0,-0.5);
\draw[blue,very thick] (30:1cm) ++(0,-0.5) -- (0,0);
\end{tikzpicture}
\end{document}
```

注意 `(30:1cm)` 和 `++(0,-0.5)` 之间没有 `--`。详细地说,此路径的解释如下:"首先,`(30:1cm)` 告诉我将笔移动到 $(\cos 30°, 1/2)$。接下来,出现另一个坐标规范,所以我将笔移动到那里而不绘制任何东西。这个新点距离最后一个位置向下半个单位,因此它在 $(\cos 30°, 0)$。最后,我将笔移动到原点,但这次绘制一些东西(因为 `--`)。"

要理解 `+` 和 `++` 之间的差异,请考虑以下示例:

```latex
\begin{tikzpicture}
\def\rectanglepath{-- ++(1cm,0cm) -- ++(0cm,1cm) -- ++(-1cm,0cm) -- cycle}
\draw (0,0) \rectanglepath;
\draw (1.5,0) \rectanglepath;
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}
\def\rectanglepath{-- ++(1cm,0cm) -- ++(0cm,1cm) -- ++(-1cm,0cm) -- cycle}
\draw (0,0) \rectanglepath;
\draw (1.5,0) \rectanglepath;
\end{tikzpicture}
\end{document}
```

相比之下,当使用单个 `+` 时,坐标是不同的:

```latex
\begin{tikzpicture}
\def\rectanglepath{-- +(1cm,0cm) -- +(1cm,1cm) -- +(0cm,1cm) -- cycle}
\draw (0,0) \rectanglepath;
\draw (1.5,0) \rectanglepath;
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}
\def\rectanglepath{-- +(1cm,0cm) -- +(1cm,1cm) -- +(0cm,1cm) -- cycle}
\draw (0,0) \rectanglepath;
\draw (1.5,0) \rectanglepath;
\end{tikzpicture}
\end{document}
```

当然,所有这些都可以更清楚、更经济地写成这样(使用单个或双个 `+`):

```latex
\tikz \draw (0,0) rectangle +(1,1) (1.5,0) rectangle +(1,1);
```
```tikz
\begin{document}
\begin{tikzpicture}
\draw (0,0) rectangle +(1,1) (1.5,0) rectangle +(1,1);
\end{tikzpicture}
\end{document}
```

#### 2.16 路径相交

Karl 剩下的是 $\tan \alpha$ 的线,使用变换和极坐标似乎很难指定。他可以做的第一件事——也是最简单的——就是简单地使用坐标 `(1,{tan(30)})`,因为 TikZ 的数学引擎知道如何计算像 `tan(30)` 这样的东西。注意添加的大括号,因为否则 TikZ 的解析器会认为第一个右括号结束了坐标(一般来说,当坐标的组成部分包含括号时,你需要在它们周围添加大括号)。

然而,Karl 也可以使用更精巧但也更"几何"的方法来计算橙线的长度:他可以将路径的交点指定为坐标。$\tan \alpha$ 的线从 $(1, 0)$ 开始,向上到一个点,该点位于向"上"的线和从原点通过 `(30:1cm)` 的线的交点。这种计算由 `intersections` 库提供。

Karl 必须做的是创建两条"不可见"的路径,它们在感兴趣的位置相交。可以使用 `\path` 命令创建未另外看到的路径,而无需像 `draw` 或 `fill` 这样的选项。然后,Karl 可以将 `name path` 选项添加到路径以供以后参考。一旦构建了路径,Karl 可以使用 `name intersections` 为坐标分配名称以供以后参考。

```latex
\usetikzlibrary{intersections}
\begin{tikzpicture}[scale=3]
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm); % 稍长一些,以便有交点
\path [name intersections={of=upward line and sloped line, by=x}];
% (在导言区加载 tikz 后添加 `\usetikzlibrary{intersections}')
\draw [very thick,orange] (1,0) -- (x);
```
```tikz
\usetikzlibrary{intersections}
\begin{document}
\begin{tikzpicture}[scale=3]
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw (-1.5,0) -- (1.5,0);
\draw (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm); % 稍长一些,以便有交点
\path [name intersections={of=upward line and sloped line, by=x}];
% (在导言区加载 tikz 后添加 `\usetikzlibrary{intersections}')
\draw [very thick,orange] (1,0) -- (x);
\end{tikzpicture}
\end{document}
```
在 TikZ 里，`name path` 声明的路径默认是“无限延长”的（数学意义上的直线）。所以即使你写的是：\path [name path=upward line] (1,0) -- (1,1); TikZ 内部对待它的方式等价于一条经过 (1,0) 和 (1,1) 的无限长垂直直线，也就是 x=1 这条直线。因此它一定会跟任何一条不平行于它的直线产生交点。如何让它真的只用有限线段求交？你需要明确告诉 TikZ 你只要“线段”（segment）而不是“直线”（line）。

#### 2.17 添加箭头

Karl 现在想在轴的末端添加小箭头。他注意到在许多图表中,即使在科学期刊上,这些箭头似乎都缺失了,大概是因为生成程序无法产生它们。Karl 认为箭头属于轴的末端。他的儿子同意。他的学生不关心箭头。

事实证明,添加箭头非常简单:Karl 在轴的绘制命令中添加选项 `->`

```latex
\usetikzlibrary {intersections}
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,1.51);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw[->] (-1.5,0) -- (1.5,0);
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[red,very thick] (30:1cm) -- +(0,-0.5);
\draw[blue,very thick] (30:1cm) ++(0,-0.5) -- (0,0);
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm);
\path [name intersections={of=upward line and sloped line, by=x}];
\draw [very thick,orange] (1,0) -- (x);
\end{tikzpicture}
```
```tikz
\usetikzlibrary {intersections}
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,1.51);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\draw[->] (-1.5,0) -- (1.5,0);
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[red,very thick] (30:1cm) -- +(0,-0.5);
\draw[blue,very thick] (30:1cm) ++(0,-0.5) -- (0,0);
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm);
\path [name intersections={of=upward line and sloped line, by=x}];
\draw [very thick,orange] (1,0) -- (x);
\end{tikzpicture}
\end{document}
```
如果 Karl 使用选项 `<-` 而不是 `->`箭头将被放在路径的开头。选项 `<->` 在路径的两端都放箭头。

可以添加箭头的路径类型有一定的限制。作为经验法则,你只能向单个开放的"线"添加箭头。例如,你不能向矩形或圆添加箭头。但是,你可以向曲线路径和具有多个线段的路径添加箭头,如以下示例所示:

```latex
\begin{tikzpicture}
\draw [<->] (0,0) arc [start angle=180, end angle=30, radius=10pt];
\draw [<->] (1,0) -- (1.5cm,10pt) -- (2cm,0pt) -- (2.5cm,10pt);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\draw [<->] (0,0) arc [start angle=180, end angle=30, radius=10pt];
\draw [<->] (1,0) -- (1.5cm,10pt) -- (2cm,0pt) -- (2.5cm,10pt);
\end{tikzpicture}
\end{document}
```
Karl 更详细地查看了 TikZ 在末端放置的箭头。当他放大时,它看起来像这样。形状似乎有些眼熟,实际上,这正是 TeX 在诸如 $f : A \to B$ 之类的标准箭头的末端。

Karl 喜欢这个箭头,特别是因为它不像许多其他包提供的箭头那样"粗"。然而,他预计有时他可能需要使用其他类型的箭头。要做到这一点,Karl 可以说 `>=<箭头类型>`,其中 `<箭头类型>` 是一个特殊的箭头规范。例如,如果 Karl 说 `>=Stealth`,那么他告诉 TikZ 他想要"隐形战斗机般"的箭头:

```latex
\usetikzlibrary {arrows.meta}
\begin{tikzpicture}[>=Stealth]
\draw [->] (0,0) arc [start angle=180, end angle=30, radius=10pt];
\draw [<<-,very thick] (1,0) -- (1.5cm,10pt) -- (2cm,0pt) -- (2.5cm,10pt);
\end{tikzpicture}
```
```tikz
\usetikzlibrary {arrows.meta}
\begin{document}
\begin{tikzpicture}[>=stealth,scale=3]
\draw [->] (0,0) arc [start angle=180, end angle=30, radius=10pt];
\draw [<<-,very thick] (1,0) -- (1.5cm,10pt) -- (2cm,0pt) -- (2.5cm,10pt);
\end{tikzpicture}
\end{document}
```
Karl 想知道箭头类型的这种军事名称是否真的有必要。当他的儿子告诉他微软的 PowerPoint 使用相同的名称时,他并没有真正感到安慰。他决定让他的学生在某个时候讨论这个问题。

除了 `Stealth` 之外,Karl 还可以选择其他几种预定义的箭头类型,请参见第 105 节。此外,如果他需要新的箭头类型,他可以自己定义。

#### 2.18 作用域

Karl 已经看到有许多图形选项会影响路径的渲染方式。通常,他希望将某些选项应用于一整组图形命令。例如,Karl 可能希望使用粗笔绘制三条路径,但希望其他所有内容"正常"绘制。

如果 Karl 希望为整个图片设置某个图形选项,他可以简单地将此选项传递给 `\tikz` 命令或 `{tikzpicture}` 环境。但是,如果 Karl 想将图形选项应用于本地组,他可以将这些命令放在 `{scope}` 环境中。此环境将图形选项作为可选参数,这些选项适用于作用域内的所有内容,但不适用于外部的任何内容。

这里是一个例子:

```latex
\begin{tikzpicture}[ultra thick]
\draw (0,0) -- (0,1);
\begin{scope}[thin]
\draw (1,0) -- (1,1);
\draw (2,0) -- (2,1);
\end{scope}
\draw (3,0) -- (3,1);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[ultra thick]
\draw (0,0) -- (0,1);
\begin{scope}[thin]
\draw (1,0) -- (1,1);
\draw (2,0) -- (2,1);
\end{scope}
\draw (3,0) -- (3,1);
\end{tikzpicture}
\end{document}
```
作用域还有另一个有趣的效果:对裁剪区域的任何更改都是作用域的局部。因此,如果你在作用域内的某处说 `\clip`,`\clip` 命令的效果在作用域结束时结束。这很有用,因为没有其他方法可以"扩大"裁剪区域。

Karl 还看到,向像 `\draw` 这样的命令提供选项仅适用于该命令。事实证明情况稍微复杂一些。首先，像 `\draw` 这样的命令的选项实际上不是命令的选项,而是"路径选项",可以在路径上的任何地方给出。所以,可以写 `\draw (0,0) [thin] -- (1,0);` 或 `\draw (0,0) -- (1,0) [thin];` 而不是 `\draw[thin] (0,0) -- (1,0);`;所有这些都有相同的效果。这可能看起来很奇怪,因为在最后一种情况下,看起来 `thin` 应该只在从 $(0, 0)$ 到 $(1, 0)$ 的线被绘制"之后"才生效。然而,大多数图形选项仅适用于整个路径。实际上,如果你在同一路径上同时说 `thin` 和 `thick`,最后给出的选项将"获胜"。

在阅读以上内容时,Karl 注意到只有"大多数"图形选项适用于整个路径。实际上,所有变换选项不适用于整个路径,而仅适用于"路径上它们之后的所有内容"。我们稍后会更详细地看这个问题。尽管如此,在路径构造期间给出的所有选项仅适用于此路径。

#### 2.19 变换

当你指定像 `(1cm,1cm)` 这样的坐标时,该坐标放在页面上的什么位置?为了确定位置,TikZ、TeX 和 pdf 或 PostScript 都对给定坐标应用某些变换,以确定页面上的最终位置。

TikZ 提供了许多选项,允许你在 TikZ 的私有坐标系统中变换坐标。例如,`xshift` 选项允许你将所有后续点按一定量移动:
```latex
\tikz \draw (0,0) -- (0,1.5) [xshift=2pt] (0,0) -- (0,1.5);
```

```tikz
\begin{document}
\begin{tikzpicture}
\draw (0,0) -- (0,1.5) [xshift=2pt] (0,0) -- (0,1.5);
\end{tikzpicture}
\end{document}
```
重要的是要注意，你可以"在路径中间"更改变换，这是 pdf 或 PostScript 不支持的功能。原因是 TikZ 跟踪自己的变换矩阵。这里是一个更复杂的例子：
```latex
\begin{tikzpicture}[even odd rule,rounded corners=2pt,x=10pt,y=10pt]
\filldraw[fill=yellow!80!black] (0,0) rectangle (1,1)
[xshift=5pt,yshift=5pt] (0,0) rectangle (1,1)
[rotate=30] (-1,-1) rectangle (2,2);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[even odd rule,rounded corners=2pt,x=10pt,y=10pt]
\filldraw[fill=yellow!80!black] (0,0) rectangle (1,1)
[xshift=5pt,yshift=5pt] (0,0) rectangle (1,1)
[rotate=30] (-1,-1) rectangle (2,2);
\end{tikzpicture}
\end{document}
```

最有用的变换是 `xshift` 和 `yshift` 用于移动,`shift` 用于移动到给定点,如 `shift={(1,0)}` 或 `shift={+(0,0)}`(大括号是必要的,这样 TeX 不会将逗号误认为是分隔选项),`rotate` 用于按一定角度旋转(还有 `rotate around` 用于围绕给定点旋转),`scale` 用于按一定因子缩放,`xscale` 和 `yscale` 仅用于在 x 或 y 方向缩放(`xscale=-1` 是翻转),以及 `xslant` 和 `yslant` 用于倾斜。如果这些变换和我没有提到的那些变换还不够,`cm` 选项允许你应用任意变换矩阵。顺便说一句,Karl 的学生不知道什么是变换矩阵。

#### 2.20 重复操作:For 循环

Karl 的下一个目标是在轴上的位置 $-1$、$-1/2$、$1/2$ 和 $1$ 添加小刻度。为此,使用某种"循环"会很好,特别是因为他希望在这些位置中的每一个都做同样的事情。有不同的包可以做到这一点。LaTeX 有自己的内部命令,pstricks 带有强大的 `\multido` 命令。所有这些都可以与 TikZ 一起使用,所以如果你熟悉它们,请随意使用它们。TikZ 引入了另一个命令,称为 `\foreach`,我引入它是因为我永远记不住其他包的语法。`\foreach` 在包 pgffor 中定义,可以完全独立于 TikZ 使用,但 TikZ 会自动包含它。

在其基本形式中,`\foreach` 命令易于使用:

```latex
x = 1, x = 2, x = 3, \foreach \x in {1,2,3} {$x =\x$, }
```

一般语法是 `\foreach <变量> in {<值列表>} <命令>`。在 `<命令>` 内部,`<变量>` 将被分配给不同的值。如果 `<命令>` 不以大括号开始,则到下一个分号之前的所有内容都用作 `<命令>`。

对于 Karl 和轴上的刻度,他可以使用以下代码：
```latex
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,1.51);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0);
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\foreach \x in {-1cm,-0.5cm,1cm}
\draw (\x,-1pt) -- (\x,1pt);
\foreach \y in {-1cm,-0.5cm,0.5cm,1cm}
\draw (-1pt,\y) -- (1pt,\y);
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-0.1,-0.2) rectangle (1.1,1.51);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0);
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\foreach \x in {-1cm,-0.5cm,1cm}
\draw (\x,-1pt) -- (\x,1pt);
\foreach \y in {-1cm,-0.5cm,0.5cm,1cm}
\draw (-1pt,\y) -- (1pt,\y);
\end{tikzpicture}
\end{document}
```
事实上,有许多不同的方法来创建刻度。例如,Karl 可以将 `\draw ...;` 放在大括号内。他还可以使用，比如：
```latex
\foreach \x in {-1,-0.5,1}
\draw[xshift=\x cm] (0pt,-1pt) -- (0pt,1pt);
```
Karl 很好奇在更复杂的情况下会发生什么，比如有 20 个刻度。显式提及 `\foreach` 集合中的所有这些数字似乎很麻烦。实际上,可以在 `\foreach` 语句内使用 `...` 来迭代大量值(但是,这些值必须是无量纲的实数),如以下示例所示:

```latex
\tikz \foreach \x in {1,...,10}
\draw (\x,0) circle (0.4cm);
```
```tikz
\begin{document}
\begin{tikzpicture}
\foreach \x in {1,...,10}
\draw (\x,0) circle (0.4cm);
\end{tikzpicture}
\end{document}
```
如果在 `...` 之前提供两个数字,`\foreach` 语句将使用它们的差值进行步进:

```latex
\tikz \foreach \x in {-1,-0.5,...,1}
\draw (\x cm,-1pt) -- (\x cm,1pt);
```

我们还可以嵌套循环以创建有趣的效果:
```latex
\begin{tikzpicture}
\foreach \x in {1,2,...,5,7,8,...,12}
\foreach \y in {1,...,5}
{
\draw (\x,\y) +(-.5,-.5) rectangle ++(.5,.5);
\draw (\x,\y) node{\x,\y};
}
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}
\foreach \x in {1,2,...,5,7,8,...,12}
\foreach \y in {1,...,5}
{
\draw (\x,\y) +(-.5,-.5) rectangle ++(.5,.5);
\draw (\x,\y) node{\x,\y};
}
\end{tikzpicture}
\end{document}
```
`\foreach` 语句可以做更巧妙的事情,但以上给出了基本思想。

#### 2.21 添加文本

到目前为止,Karl 对图片非常满意。然而,最重要的部分,即标签,仍然缺失!

TikZ 提供了一个易于使用且功能强大的系统,用于在图片的特定位置添加文本,更一般地说,添加复杂的形状。基本思想如下:当 TikZ 构造路径并在路径中间遇到关键字 `node` 时,它会读取节点规范。关键字 `node` 通常后面跟着一些选项,然后是大括号之间的一些文本。此文本放在普通的 TeX 盒子中(如果节点规范直接跟在坐标后面,这通常是情况,TikZ 能够执行一些魔法,以便甚至可以在盒子内使用逐字文本),然后放在当前位置,即最后指定的位置(可能根据给定的选项稍微移动)。但是,所有节点仅在路径完全绘制/填充/阴影/裁剪/等之后才绘制。

```latex
\begin{tikzpicture}
\draw (0,0) rectangle (2,2);
\draw (0.5,0.5) node [fill=yellow!80!black] {Text at \verb!node 1!} -- (1.5,1.5) node {Text at \verb!node 2!};
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
\draw (0,0) rectangle (2,2);
\draw (0.5,0.5) node [fill=yellow!80!black] {Text at \verb!node 1!} -- (1.5,1.5) node {Text at \verb!node 2!};
\end{tikzpicture}
\end{document}
```
显然,Karl 不仅希望将节点放置在最后指定的位置,还希望放置在这些位置的左侧或右侧。为此,你放入图片中的每个节点对象都配备了多个锚点。例如,`north` 锚点在形状的上端中间,`south` 锚点在底部,`north east` 锚点在右上角。当你给出选项 `anchor=north` 时,文本将被放置,使得这个北锚点将位于当前位置,因此文本在当前位置下方。Karl 使用它来绘制刻度,如下所示:

```latex
\begin{tikzpicture}[scale=3]
%\clip (-0.6,-0.2) rectangle (0.6,1.51);
\draw[step=.5cm,help lines] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0); 
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\foreach \x in {-1,-0.5,1}
\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north] {$\x$};
\foreach \y in {-1,-0.5,0.5,1}
\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east] {$\y$};
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-0.6,-0.2) rectangle (0.6,1.51);
\draw[step=.5cm,help lines] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0); 
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\foreach \x in {-1,-0.5,1}
\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north] {$\x$};
\foreach \y in {-1,-0.5,0.5,1}
\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east] {$\y$};
\end{tikzpicture}
\end{document}
```
这已经很好了。使用这些锚点,Karl 现在可以添加大部分其他文本元素。但是,Karl 认为,尽管"正确",但为了将某物放置在给定点下方而必须使用 `north` 锚点是相当违反直觉的。因此,有一个称为 `below` 的选项,它与 `anchor=north` 做同样的事情。类似地,`above right` 与 `anchor=south west` 做同样的事情。此外,`below` 接受一个可选的维度参数。如果给出,形状将另外向下移动给定的量。所以,`below=1pt` 可用于将文本标签放在某个点下方,并另外向下移动 1pt。

Karl 对刻度不太满意。他想显示 $1/2$ 或 $\frac{1}{2}$ 而不是 0.5,部分是为了炫耀 TeX 和 TikZ 的良好功能,部分是因为对于像 $1/3$ 或 $\pi$ 这样的位置,显示"数学"刻度肯定比仅显示"数字"刻度更可取。另一方面,他的学生更喜欢 0.5 而不是 $1/2$,因为他们通常不太喜欢分数。

Karl 现在面临一个问题:对于 `\foreach` 语句,位置 `\x` 仍应给出为 0.5,因为 TikZ 不知道 `\frac{1}{2}` 应该在哪里。另一方面,排版的文本应该真的是 `\frac{1}{2}`。为了解决这个问题,`\foreach` 提供了一种特殊的语法:Karl 可以指定两个(或更多)用斜杠分隔的变量,而不是一个变量 `\x`,如 `\x / \xtext`。然后,`\foreach` 迭代的集合中的元素也必须是 `<第一个>/<第二个>` 的形式。在每次迭代中,`\x` 将设置为 `<第一个>`,`\xtext` 将设置为 `<第二个>`。如果没有给出 `<第二个>`,则再次使用 `<第一个>`。所以,这是刻度的新代码:

```latex
\begin{tikzpicture}[scale=3]
%\clip (-0.6,-0.2) rectangle (0.6,1.51);
\draw[step=.5cm,help lines] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0); 
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\foreach \x/\xtext in {-1, -0.5/-\frac{1}{2}, 1}
\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north] {$\xtext$};
\foreach \y/\ytext in {-1, -0.5/-\frac{1}{2}, 0.5/\frac{1}{2}, 1}
\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east] {$\ytext$};
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-0.6,-0.2) rectangle (0.6,1.51);
\draw[step=.5cm,help lines] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0); 
\draw[->] (0,-1.5) -- (0,1.5);
\draw (0,0) circle [radius=1cm];
\foreach \x/\xtext in {-1, -0.5/-\frac{1}{2}, 1}
\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north] {$\xtext$};
\foreach \y/\ytext in {-1, -0.5/-\frac{1}{2}, 0.5/\frac{1}{2}, 1}
\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east] {$\ytext$};
\end{tikzpicture}
\end{document}
```
Karl 对结果非常满意,但他的儿子指出这仍然不完全令人满意:网格和圆与数字干扰,降低了它们的可读性。Karl 对此并不太担心(他的学生甚至没有注意到),但他的儿子坚持认为有一个简单的解决方案:Karl 可以添加 `[fill=white]` 选项来用白色填充文本形状的背景。

Karl 接下来想做的是添加像 $\sin \alpha$ 这样的标签。为此,他想在线的中间放置一个标签。要做到这一点,Karl 可以在线的端点之一后直接给出标签节点 `{$\sin\alpha$}`(这会将标签放在该端点),而是可以在 `--` 之后、坐标之前直接给出标签。默认情况下,这会将标签放在线的中间,但可以使用 `pos=` 选项来修改这一点。此外,可以使用像 `near start` 和 `near end` 这样的选项来修改此位置:

```latex
\usetikzlibrary {intersections}
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-2,-0.2) rectangle (2,0.8);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0) coordinate (x axis);
\draw[->] (0,-1.5) -- (0,1.5) coordinate (y axis);
\draw (0,0) circle [radius=1cm];
\draw[very thick,red] (30:1cm) -- node[left=1pt,fill=white] {$\sin \alpha$} (30:1cm |- x axis);
\draw[very thick,blue!60] (30:1cm |- x axis) -- node[below=2pt,fill=white] {$\cos \alpha$} (0,0);
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm);
\draw [name intersections={of=upward line and sloped line, by=t}] [very thick,orange] (1,0) -- node [right=1pt,fill=white]{$\displaystyle tan \alpha = \frac{\color{red} sin \alpha}{\color{blue!60} cos \alpha}$} (t);
\draw (0,0) -- (t);
\foreach \x/\xtext in {-1, -0.5/-\frac{1}{2}, 1}
\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north,fill=white] {$\xtext$};
\foreach \y/\ytext in {-1, -0.5/-\frac{1}{2}, 0.5/\frac{1}{2}, 1}
\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east,fill=white] {$\ytext$};
\end{tikzpicture}
\end{document}
```
```tikz
\usetikzlibrary {intersections}
\begin{document}
\begin{tikzpicture}[scale=3]
%\clip (-2,-0.2) rectangle (2,0.8);
\draw[step=.5cm,gray,very thin] (-1.4,-1.4) grid (1.4,1.4);
\filldraw[fill=green!20,draw=green!50!black] (0,0) -- (3mm,0mm) arc [start angle=0, end angle=30, radius=3mm] -- cycle;
\draw[->] (-1.5,0) -- (1.5,0) coordinate (x axis);
\draw[->] (0,-1.5) -- (0,1.5) coordinate (y axis);
\draw (0,0) circle [radius=1cm];
\draw[very thick,red] (30:1cm) -- node[left=1pt,fill=white] {$\sin \alpha$} (30:1cm |- x axis);
\draw[very thick,blue!60] (30:1cm |- x axis) -- node[below=2pt,fill=white] {$\cos \alpha$} (0,0);
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm);
\draw [name intersections={of=upward line and sloped line, by=t}] [very thick,orange] (1,0) -- node [right=1pt,fill=white]{$\displaystyle tan \alpha = \frac{\color{red} sin \alpha}{\color{blue!60} cos \alpha}$} (t);
\draw (0,0) -- (t);
\foreach \x/\xtext in {-1, -0.5/-\frac{1}{2}, 1}
\draw (\x cm,1pt) -- (\x cm,-1pt) node[anchor=north,fill=white] {$\xtext$};
\foreach \y/\ytext in {-1, -0.5/-\frac{1}{2}, 0.5/\frac{1}{2}, 1}
\draw (1pt,\y cm) -- (-1pt,\y cm) node[anchor=east,fill=white] {$\ytext$};
\end{tikzpicture}
\end{document}
```

你还可以在曲线上定位标签,并通过添加 `sloped` 选项,使它们旋转以匹配线的斜率。这里是一个例子:

```latex
\usetikzlibrary {intersections}
\begin{document}
\begin{tikzpicture}[xscale=1,yscale=2]
\draw [thick](0,0)--(13,0)node[right,font=\large]{x};
\draw [thick](0,0)--(0,2)node[above,font=\large]{y};
\draw [dotted](0,0)grid(12,2);
\draw (0,0) .. controls (6,1) and (9,1) ..
node[very near start,sloped,below] {near start}
node[midway,sloped] {midway}
node[very near end,sloped,above] {very near end} (12,0);
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {intersections}
\begin{document}
\begin{tikzpicture}[xscale=1,yscale=2]
\draw [thick](0,0)--(13,0)node[right,font=\large]{x};
\draw [thick](0,0)--(0,2)node[above,font=\large]{y};
\draw [dotted](0,0)grid(12,2);
\draw (0,0) .. controls (6,1) and (9,1) ..
node[very near start,sloped,below] {near start}
node[midway,sloped] {midway}
node[very near end,sloped,above] {very near end} (12,0);
\end{tikzpicture}
\end{document}
```
剩下的是在图片右侧绘制解释性文本。这里的主要困难在于限制文本"标签"的宽度,它相当长,以便使用换行。幸运的是,Karl 可以使用选项 `text width=6cm` 来获得所需的效果。所以,这里是完整的代码:

```latex
\begin{tikzpicture}
[scale=3,line cap=round,
% 样式
axes/.style=,
important line/.style={very thick},
information text/.style={rounded corners,fill=red!10,inner sep=1ex}]
% 颜色
\colorlet{anglecolor}{green!50!black}
\colorlet{sincolor}{red}
\colorlet{tancolor}{orange!80!black}
\colorlet{coscolor}{blue}
% 图形
\draw[help lines,step=0.5cm] (-1.4,-1.4) grid (1.4,1.4);
\draw (0,0) circle [radius=1cm];

\begin{scope}[axes]
\draw[->] (-1.5,0) -- (1.5,0) node[right] {$x$} coordinate(x axis);
\draw[->] (0,-1.5) -- (0,1.5) node[above] {$y$} coordinate(y axis);
\foreach \x/\xtext in {-1, -.5/-\frac{1}{2}, 1}
\draw[xshift=\x cm] (0pt,1pt) -- (0pt,-1pt) node[below,fill=white] {$\xtext$};
\foreach \y/\ytext in {-1, -.5/-\frac{1}{2}, .5/\frac{1}{2}, 1}
\draw[yshift=\y cm] (1pt,0pt) -- (-1pt,0pt) node[left,fill=white] {$\ytext$};
\end{scope}

\filldraw[fill=green!20,draw=anglecolor] (0,0) -- (3mm,0pt) arc [start angle=0, end angle=30, radius=3mm];
\draw (15:2mm) node[anglecolor] {$\alpha$};
\draw[important line,sincolor] (30:1cm) -- node[left=1pt,fill=white] {$\sin \alpha$} (30:1cm |- x axis);
\draw[important line,coscolor] (30:1cm |- x axis) -- node[below=2pt,fill=white] {$\cos \alpha$} (0,0);
\path [name path=upward line] (1,0) -- (1,1);
\path [name path=sloped line] (0,0) -- (30:1.5cm);
\draw [name intersections={of=upward line and sloped line, by=t}] [very thick,orange] (1,0) -- node [right=1pt,fill=white]
{$\displaystyle tan \alpha \color{black}= \frac{{\color{red} sin \alpha}}{\color{blue} cos \alpha}$} (t);
\draw (0,0) -- (t);
\draw[xshift=1.85cm] node[right,text width=6cm,information text]
{
{\color{anglecolor}角 $\alpha$} 在示例中是 $30^\circ$(弧度为 $\pi/6$)。{\color{sincolor}$\alpha$ 的正弦值},即红线的高度,是
\[
{\color{sincolor} \sin \alpha} = 1/2.
\]
根据勾股定理...
};
\end{tikzpicture}
```

#### 2.22 Pics:重新审视角度

Karl 预计他创建的图片的某些部分的代码可能非常有用,他可能希望在将来重用它们。一个自然的做法是创建存储他希望重用的代码的 TeX 宏。但是,TikZ 提供了另一种直接集成到其解析器中的方法:pics!

"pic"是"不完全是一个完整的图片",因此得名简短。其思想是 pic 只是一些代码,你可以使用 `pic` 命令在不同的地方添加到图片中,其语法几乎与 `node` 命令相同。主要区别在于,你不是在大括号中指定应该显示的某些文本,而是指定应该显示的预定义图片的名称。

定义新的 pics 非常简单,参见第 18 节,但现在我们只想使用一个这样的预定义 pic:`angle` pic。顾名思义,它是一个角度的小图,由一个小楔形和一个弧以及一些文本组成(Karl 需要加载 `angles` 库和 `quotes` 以获得以下示例)。使这个 pic 有用的是楔形的大小将被自动计算。

angle pic 在两条线 BA 和 BC 之间绘制一个角度,其中 A、B 和 C 是三个坐标。在我们的情况下,B 是原点,A 在 x 轴上的某处,C 在 30° 线上的某处。

```latex
\usetikzlibrary {angles,quotes}
\begin{tikzpicture}[scale=5]
\coordinate (A) at (1,0);
\coordinate (B) at (0,0);
\coordinate (C) at (30:1cm);
\draw (A) -- (B) -- (C)
pic [draw=green!50!black, fill=green!20, angle radius=9mm, "$\alpha$"] {angle = A--B--C};
\end{tikzpicture}
```
```tikz
\begin{document}
\usetikzlibrary {angles,quotes}
\begin{tikzpicture}[scale=5]
\coordinate (A) at (1,0);
\coordinate (B) at (0,0);
\coordinate (C) at (30:1cm);
\draw (A) -- (B) -- (C)
pic [draw=green!50!black, angle radius=9mm, "$\alpha$"] {angle = A--B--C};
\end{tikzpicture}
\end{document}
```
让我们看看这里发生了什么。首先,我们使用 `\coordinate` 命令指定了三个坐标。它允许我们命名图片中的特定坐标。然后是一些作为正常 `\draw` 开始的东西,但随后出现了 `pic` 命令。这个命令获得了很多选项,在大括号中,出现了最重要的一点:我们指定我们想要添加一个 `angle` pic,这个角度应该在我们命名为 A、B 和 C 的点之间(我们可以使用其他名称)。注意,我们想要在 pic 中显示的文本在 pic 的选项中用引号指定,而不是在大括号中。

要了解更多关于 pics 的信息,请参见第 18 节。



#### 2.23 pgfmathsetmacro

在 Obsidian 中使用 tikzjax 插件时，`\pgfmathsetmacro{\r}{5}` 是 PGF/TikZ 数学引擎提供的一个基础且非常重要的命令，用于“计算并定义一个可复用的数值宏”。下面从语法、本质机制、使用规范、常见应用场景以及 Obsidian 环境下的注意事项几个层面进行系统说明。

一、命令的基本语义与语法：\pgfmathsetmacro{\r}{5} 的完整语义是：调用 PGF 的数学解析器，对表达式 `5` 进行求值，并将结果以“纯数值字符串”的形式存储到宏 `\r` 中。

其标准语法为 ：`\pgfmathsetmacro{<宏名>}{<数学表达式>}`
其中：`<宏名>` 必须是一个控制序列，例如 `\r`、`\radius`、`\thetaStep`。`<数学表达式>` 由 PGF math parser 解析，而不是 TeX 原生的算术系统。因此，`\pgfmathsetmacro{\r}{5}` 等价于“定义一个数值型变量 r，其值为 5”。

二、在 TikZ 绘图中的典型用法

用作几何参数，这里 `\r` 作为长度，直接用于圆的半径。
```
\pgfmathsetmacro{\r}{5}
\draw (0,0) circle (\r);
```
用于坐标计算，注意，TikZ 在读取坐标时，会自动展开 `\x` 和 `\y`。
```
\pgfmathsetmacro{\x}{3}
\pgfmathsetmacro{\y}{4}
\draw (0,0) -- (\x,\y);
```
与极坐标配合，此处 `(\ang:\r)` 是 TikZ 的极坐标语法，而不是 PGF math 语法，但二者可以无缝协作。
```
\pgfmathsetmacro{\r}{5}
\pgfmathsetmacro{\ang}{30}
\draw (0,0) -- (\ang:\r);
```

三、与 Obsidian tikzjax 环境相关的注意事项

不需要导言区 ：在 Obsidian 的 tikzjax 中，`pgfmath` 已经内置加载，`\pgfmathsetmacro` 可直接使用，无需 `\usepackage{pgfmath}`。
不支持浮点格式控制命令 ：在完整 LaTeX 中可配合 `\pgfkeys{/pgf/number format/...}` 使用，但 tikzjax 对格式控制支持有限，宏值通常以默认精度输出。
避免在 `{}` 中使用 TeX 原生命令。例如 `{ \pi }` 是错误的，应使用 `{pi}`。`\pgfmathsetmacro{\r}{\pi}` 在 tikzjax 中通常会失败。

四、常见错误示例与解释

错误写法：`\pgfmathsetmacro{\r}{5cm}`  原因：PGF math 只接受“无单位数值”，不能包含物理单位。

正确写法： `\pgfmathsetmacro{\r}{5}`  然后在使用时由 TikZ 解释为长度，例如 `(\r,0)` 或 `circle (\r)`。

五、总结性理解：可以将`\pgfmathsetmacro{\r}{5}`  理解为：在 TikZ 绘图之前，先在“数值层面”定义一个参数 $r=5$，之后在整个绘图过程中，把它当作一个已经计算完成的常量来使用。这种方式非常适合参数化绘图、物理量建模和可维护的数学结构表达。




## 第三部分：TikZ不是绘图程序



### 11 设计原则

本节描述TikZ前端背后的设计原则，其中TikZ的意思是"TikZ ist kein Zeichenprogramm"（TikZ不是绘图程序）。要使用TikZ，作为LaTeX用户需要在导言区某处写上 `\usepackage{tikz}`，作为plain TeX用户需要写 `\input tikz.tex`。TikZ的任务是通过提供易学易用的语法来描述图形，从而让您的生活更轻松。

TikZ的命令和语法受到多个来源的影响。基本的命令名称和路径操作的概念来自metafont，选项机制来自pstricks，样式的概念让人联想到svg，图形语法取自graphviz。为了让这一切协同工作，需要做出一些折衷。我还添加了一些自己的想法，比如坐标变换。

以下是TikZ的基本设计原则：

1. 用于指定点的特殊语法
2. 用于路径规范的特殊语法
3. 对路径的操作
4. 图形参数的键值语法
5. 用于节点的特殊语法
6. 用于树的特殊语法
7. 用于图的特殊语法
8. 图形参数的分组
9. 坐标变换系统

#### 11.1 指定点的特殊语法

TikZ提供了一种特殊的语法来指定点和坐标。在最简单的情况下，您可以提供两个用逗号分隔的TeX维度，放在圆括号中，如 `(1cm,2pt)`。

您也可以使用极坐标来指定点，方法是使用冒号代替逗号，如 `(30:1cm)`，表示"在30度方向上1cm处"。

如果您不提供单位，如 `(2,1)`，您就是在pgf的xy坐标系统中指定点。默认情况下，单位x向量向右延伸1cm，单位y向量向上延伸1cm。

通过指定三个数字如 `(1,1,1)`，您可以在pgf的xyz坐标系统中指定点。

还可以使用先前定义的形状的锚点，如 `(first node.south)`。

您可以在坐标前添加两个加号，如 `++(1cm,0pt)`。这表示"相对于最后使用的点向右1cm"。这允许您轻松指定相对移动。例如，`(1,0) ++(1,0) ++(0,1)` 指定了三个坐标 `(1,0)`，然后是 `(2,0)`，以及 `(2,1)`。

最后，您也可以只添加一个加号而不是两个。这也以相对方式指定点，但它不会"改变"后续相对命令中使用的当前点。例如，`(1,0) +(1,0) +(0,1)` 指定了三个坐标 `(1,0)`，然后是 `(2,0)`，以及 `(1,1)`。

#### 11.2 路径规范的特殊语法

使用TikZ创建图片时，您的主要工作是指定路径。路径是一系列直线或曲线，它们不必连接。TikZ使指定路径变得容易，部分采用了metapost的语法。例如，要指定一个三角形路径，您可以使用：
```
(5pt,0pt) -- (0pt,0pt) -- (0pt,5pt) -- cycle
```
当您绘制这条路径时，您会得到一个三角形。

#### 11.3 对路径的操作

路径只是一系列直线和曲线，但尚未指定应该对它做什么。可以绘制路径、填充路径、着色路径、裁剪路径，或执行这些操作的任意组合。绘制（也称为描边）可以被认为是用特定粗细的笔沿着路径移动，从而在画布上绘图。填充意味着路径的内部用统一的颜色填充。显然，填充只对封闭路径有意义，如果需要，路径会在填充之前自动关闭。

```tikz
\begin{document}
\begin{tikzpicture}[scale=5]
\path[draw] (0,0) rectangle (2ex,1ex);
\end{tikzpicture}
\end{document}
```

给定一个路径如 `\path (0,0) rectangle (2ex,1ex);`，您可以通过添加draw选项来绘制它，如 `\path[draw] (0,0) rectangle (2ex,1ex);`，这会产生一个矩形。`\draw` 命令只是 `\path[draw]` 的缩写。要填充路径，使用fill选项或 `\fill` 命令，后者是 `\path[fill]` 的缩写。`\filldraw` 命令是 `\path[fill,draw]` 的缩写。着色由shade选项引起（有 `\shade` 和 `\shadedraw` 缩写），裁剪由clip选项引起。还有一个 `\clip` 命令，它的作用与 `\path[clip]` 相同，但没有像 `\drawclip` 这样的命令。请改用 `\draw[clip]` 或 `\path[draw,clip]`。

所有这些命令只能在 `{tikzpicture}` 环境内使用。TikZ允许您为填充和描边使用不同的颜色。

常见相对单位对比（TikZ / LaTeX）
你的代码：\path[draw] (0,0) rectangle (2ex,1ex);   2ex 在你的 TikZ 代码里是一个长度单位，意思是 2 倍当前字体的小写字母 x 的高度。

具体解释：在 (La)TeX / TikZ 里，ex 是一个相对单位（relative unit）；1ex ≈ 当前字体小写字母 x 的高度（严格说是字体参数 \fontdimen5 的大小）；所以 2ex 就是大约 两个小写 x 叠起来的高度；画出来的是一个宽度 ≈ 2 个 x 高度、高度 ≈ 1 个 x 高度 的小矩形。

为什么用 ex 而不用 cm、pt？
因为 ex 是跟随字体大小变化的：如果你把字体变大（比如 \Large、\Huge），这个矩形也会自动变大；如果换成小字体（\small、\tiny），矩形也会自动变小；特别适合画行内小图、标注符号、与文字比例协调的图形

常见相对单位对比（TikZ / LaTeX）

| 单位  | 含义               | 是否随字体大小变化 | 典型用途        |
| --- | ---------------- | --------- | ----------- |
| ex  | 小写 x 的高度         | 是         | 行内小图、垂直间距   |
| em  | 大写 M 的宽度（约一个字符宽） | 是         | 水平间距、文字相关长度 |
| pt  | 1/72.27 英寸（固定）   | 否         | 需要绝对尺寸时     |
| cm  | 厘米（固定）           | 否         | 大图、打印精确尺寸   |
总结：  2ex = 当前字体下大约两个小写 x 的高度，是一种与当前文字大小“和谐”的相对长度单位，在你的例子中就是让这个小矩形跟周围文字大小匹配。



#### 11.4 图形参数的键值语法

每当TikZ绘制或填充路径时，大量的图形参数会影响渲染。示例包括使用的颜色、虚线图案、裁剪区域、线宽等等。在TikZ中，所有这些选项都被指定为所谓的键值对列表，如 `color=red`，这些列表作为可选参数传递给路径绘制和填充命令。这种用法类似于pstricks。例如，以下代码将绘制一个粗的红色三角形：
```latex
\tikz \draw[line width=2pt,color=red] (1,0) -- (0,0) -- (0,1) -- cycle;
```
```tikz
\begin{document}
\begin{tikzpicture}
\draw[line width=2pt,color=red] (1,0) -- (0,0) -- (0,1) -- cycle;
\end{tikzpicture}
\end{document}
```

#### 11.5 指定节点的特殊语法

TikZ引入了一种特殊的语法，用于向图形添加文本或更一般的节点。当您指定路径时，可以添加节点，如下例所示：
```
text
\tikz \draw (1,1) node {text} -- (2,2);
```
```tikz
\begin{document}
\begin{tikzpicture}
\draw (1,1) node {text} -- (2,2);
\end{tikzpicture}
\end{document}
```
节点插入在路径的当前位置，但在完整路径渲染之前（默认）或之后。当给出特殊选项时，如 `\draw (1,1) node[circle,draw] {text};`，文本不仅仅放在当前位置。相反，它被一个圆圈包围，这个圆圈被"绘制"。

```tikz
\begin{document}
\begin{tikzpicture}
\draw (1,1) node[circle,draw] {text};
\end{tikzpicture}
\end{document}
```

您可以为节点添加名称以便以后引用，方法是使用选项 `name=<节点名称>` 或在文本外的括号中声明节点名称，如 `node[circle](name){text}`。

预定义的形状包括矩形、圆形和坐标，但可以（虽然有点挑战性）定义新形状。

#### 11.6 指定树的特殊语法

"节点语法"也可以用来绘制树：节点后面可以跟随任意数量的子节点，每个子节点都由关键字child引入。子节点本身就是节点，每个节点又可能有自己的子节点。

```latex
\begin{tikzpicture}
\node {root}
child {node {left}}
child {node {right}
child {node {child}}
child {node {child}}
child {node {child}}
};
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}
\node {root}
child {node {left}}
child {node {right}
child {node {child}}
child {node {child}}
child {node {child}}
};
\end{tikzpicture}
\end{document}
```

由于树由节点组成，因此可以使用选项来修改树的绘制方式。以下是上述树使用不同选项重绘的两个示例：

```latex
\usetikzlibrary {arrows.meta,trees}
\begin{tikzpicture}
[edge from parent fork down, sibling distance=25mm, level distance=15mm,
every node/.style={draw=red!30,rounded corners},
edge from parent/.style={blue!60,-{Circle[open]},thick,draw}]
\node {root}
child {node {left}}
child {node {right}
child {node {child}}
child {node {child}}
};
\end{tikzpicture}
```
```tikz
\begin{document}
\usetikzlibrary {arrows.meta,trees}
\begin{tikzpicture}
[edge from parent fork down, sibling distance=25mm, level distance=15mm,
every node/.style={draw=red!30,rounded corners},
edge from parent/.style={blue!60,-{Circle[open]},thick,draw}]
\node {root}
child {node {left}}
child {node {right}
child {node {child}}
child {node {child}}
};
\end{tikzpicture}
\end{document}
```
```latex
\begin{tikzpicture}
[parent anchor=east,child anchor=west,grow=east,
sibling distance=25mm, level distance=15mm,
every node/.style={ball color=red,circle,text=white},
edge from parent/.style={draw,dashed,thick,cyan}]
\node {root}
child {node {left}}
child {node {right}
child {node {child}}
child {node {child}}
};
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}
[parent anchor=east,child anchor=west,grow=east,
sibling distance=25mm, level distance=15mm,
every node/.style={ball color=red,circle,text=white},
edge from parent/.style={draw,dashed,thick,cyan}]
\node {root}
child {node {left}}
child {node {right}
child {node {child}}
child {node {child}}
};
\end{tikzpicture}
\end{document}
```

#### 11.7 图的特殊语法

`\node` 命令让您可以精确控制节点应该放在哪里、它们应该使用什么文本以及它们应该是什么样子。然而，当您绘制图时，通常需要创建许多相当相似的节点，它们仅在显示的名称上有所不同。在这些情况下，可以使用图语法，这是构建在节点语法"之上"的另一种语法层。

```latex
root
left right
child

\usetikzlibrary {graphs}
\tikz \graph [grow down, branch right] {
root -> { left, right -> {child, child} }
};
```

图命令的语法扩展了流行的graphviz程序中使用的所谓点符号。

根据您使用的TeX版本（它必须允许您调用Lua代码，这对于LuaTeX来说是这样），您还可以要求TikZ使用几种集成的图绘制算法之一自动计算图节点的良好位置。

#### 11.8 图形参数的分组

图形参数通常应该应用于多个路径绘制或填充命令。例如，我们可能希望绘制多条线，它们都具有相同的1pt线宽。为此，我们将这些命令放在一个 `{scope}` 环境中，该环境将所需的图形选项作为可选参数。自然地，指定的图形参数仅适用于环境内的绘制和填充命令。此外，嵌套的 `{scope}` 环境或单个绘制命令可以覆盖外部 `{scope}` 环境的图形参数。在以下示例中，绘制了三条红线、两条绿线和一条蓝线：

```latex
\begin{tikzpicture}
\begin{scope}[color=red]
\draw (0mm,10mm) -- (10mm,10mm);
\draw (0mm, 8mm) -- (10mm, 8mm);
\draw (0mm, 6mm) -- (10mm, 6mm);
\end{scope}
\begin{scope}[color=green]
\draw (0mm, 4mm) -- (10mm, 4mm);
\draw (0mm, 2mm) -- (10mm, 2mm);
\draw[color=blue] (0mm, 0mm) -- (10mm, 0mm);
\end{scope}
\end{tikzpicture}
```
```tikz
\begin{document}
\begin{tikzpicture}[scale=5]
\begin{scope}[color=red]
\draw (0mm,10mm) -- (10mm,10mm);
\draw (0mm, 8mm) -- (10mm, 8mm);
\draw (0mm, 6mm) -- (10mm, 6mm);
\end{scope}
\begin{scope}[color=green]
\draw (0mm, 4mm) -- (10mm, 4mm);
\draw (0mm, 2mm) -- (10mm, 2mm);
\draw[color=blue] (0mm, 0mm) -- (10mm, 0mm);
\end{scope}
\end{tikzpicture}
\end{document}
```
`{tikzpicture}` 环境本身也像 `{scope}` 环境一样工作，也就是说，您可以使用可选参数指定图形参数。这些可选参数适用于图片中的所有命令。

#### 11.9 坐标变换系统

TikZ支持pgf的坐标变换系统来执行变换，以及画布变换，一个更低级的变换系统。（有关坐标变换和画布变换之间差异的详细信息，请参见第99.4节。）

语法的设置使得使用画布变换比使用坐标变换更困难。这有两个原因：首先，画布变换必须非常小心地使用，并且经常导致"不好的"图形，具有变化的线宽和错误大小的文本。其次，当使用画布变换时，pgf会失去对节点和形状位置的跟踪。因此，在几乎所有情况下，您应该使用坐标变换而不是画布变换。



### 12 TikZ的层级结构

本节解释了使用TikZ时文件应该如何构建。在顶层，您需要包含tikz包。在主文本中，每个图形都需要放在 `{tikzpicture}` 环境中。在这些环境中，您可以使用 `{scope}` 环境来创建内部组。在作用域内，您使用 `\path` 命令来实际绘制某些内容。在所有级别（除了包级别）上，都可以给出图形选项，这些选项适用于环境内的所有内容。

#### 12.1 加载包和库

```latex
\usepackage{tikz} % LaTeX
\input tikz.tex % plain TeX
\usemodule[tikz] % ConTeXt
```

此包没有任何选项。

这将自动加载pgf和pgffor包。

pgf需要知道您打算使用什么TeX驱动程序。在大多数情况下，pgf足够聪明，可以为您确定正确的驱动程序；在使用LaTeX时尤其如此。pgf无法"自行"知道驱动程序的一种情况是当您使用plain TeX或ConTeXt以及dvipdfm时。在这种情况下，您必须在输入tikz.tex之前写 `\def\pgfsysdriver{pgfsys-dvipdfm.def}`。

**`\usetikzlibrary{<库列表>}`**

一旦加载了TikZ，您可以使用此命令加载更多库。库列表应包含用逗号分隔的库名称。您也可以使用方括号代替大括号，这是ConTeXt用户会喜欢的。如果您尝试第二次加载库，将不会发生任何事情。

示例：`\usetikzlibrary{arrows.meta}`

上述命令将加载一整套额外的箭头尖端定义。

此命令的作用是为库列表中的每个库加载文件 `tikzlibrary<库>.code.tex`。如果此文件不存在，则加载文件 `pgflibrary<库>.code.tex`。如果此文件也不存在，则打印错误消息。因此，要编写自己的库文件，您只需要将具有适当名称的文件放在TeX可以找到的地方。然后LaTeX、plain TeX和ConTeXt用户就可以使用您的库。


















## 第五部分 库

在这一部分中，将介绍库包的文档。这些库提供了额外的预定义图形对象，如新的箭头或新的绘图标记，有时还提供了基本pgf或TikZ系统的扩展。这些库默认不会加载，因为许多用户不需要它们。

Latitude：翻译成中文是 纬度。它指的是地球表面某一点相对于赤道的南北位置，以角度（度数）来表示。
北纬：North Latitude ；南纬：South Latitude

Longitude：翻译成中文是 经度。它指的是地球表面某一点相对于本初子午线（通常指格林威治子午线）的东西位置，以角度（度数）来表示。东经：East Longitude ；西经：West Longitude


### 40 三维绘图库

TikZ库 3d
```latex
\usetikzlibrary{3d} % LATEX 和 plain TEX
\usetikzlibrary[3d] % ConTEXt
```
此包提供了一些用于绘制三维形状的样式和选项。

#### 40.1 Coordinate system


##### 笛卡尔坐标系

```late
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
\draw (0,0,0) -- (1,0,0) node[below,font=\large] {$x$};
\draw (0,0,0) -- (0,1,0)node[left,font=\large] {$y$};
\draw (0,0,0) -- (0,0,1)node[left,font=\large] {$z$};
\end{tikzpicture}
\end{document}
```
```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
\draw (0,0,0) -- (1,0,0) node[below,font=\large] {$x$};
\draw (0,0,0) -- (0,1,0)node[left,font=\large] {$y$};
\draw (0,0,0) -- (0,0,1)node[left,font=\large] {$z$};
\end{tikzpicture}
\end{document}
```

#####  圆柱坐标系

xyz cylindrical坐标系允许你用柱坐标指定点，有时也称为圆柱极坐标或极柱坐标。它与canvas polar和xy polar坐标系统非常相似，不同之处在于你使用z键提供xy平面上的高度。

`/tikz/cs/angle=⟨角度⟩` (无默认值，初始为0)  在以x向量和y向量为轴的椭圆中解释的坐标角度。

`/tikz/cs/radius=⟨数字⟩` (无默认值，初始为0)  x向量和y向量在形成椭圆之前乘以的因子。

`/tikz/cs/z=⟨数字⟩` (无默认值，初始为0)  z向量乘以的因子。

最常用的几种合法写法（等价关系）：

| 写法示例                         | 实际坐标（笛卡尔）         | 含义                    |
| ---------------------------- | ----------------- | --------------------- |
| `radius=1`                   | (1, 0, 0)         | xy 平面 x 正方向，长度 1      |
| `radius=1, angle=90`         | (0, 1, 0)         | xy 平面 y 正方向，长度 1      |
| `radius=1, angle=45`         | (√2/2, √2/2, 0)   | xy 平面 45° 方向          |
| `z=1`                        | (0, 0, 1)         | 沿 z 轴向上 1 个单位         |
| `radius=2, z=3`              | (2, 0, 3)         | 底面半径 2，高度 3           |
| `radius=1.5, angle=120, z=4` | (-0.75, 1.299, 4) | 半径 1.5，120° 方向，高度 4   |
| `angle=30`                   | (0, 0, 0)         | 只有角度没有 radius → 退化为原点 |


```latex
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
% 从原点 (0,0,0) 画一条直线到圆柱坐标系中 半径=1、角度默认=0、高度默认=0 的点
% 相当于在 xy 平面上，沿着 x 正方向画长度为 1 的箭头
\draw (0,0,0) -- (xyz cylindrical cs:radius=1) node[below,font=\large] {$x$};
% 从原点画一条直线到：半径=1、角度=90°（即 y 正方向）、高度默认=0 的点
% 相当于在 xy 平面上，沿着 y 正方向画长度为 1 的箭头
\draw (0,0,0) -- (xyz cylindrical cs:radius=1,angle=90)node[left,font=\large] {$y$};
% 从原点画一条直线到：半径默认=0（圆心）、角度默认=0、高度 z=1 的点
% 相当于直接沿着 z 轴正方向向上画长度为 1 的箭头
\draw (0,0,0) -- (xyz cylindrical cs:z=1)node[left,font=\large] {$z$};
\end{tikzpicture}
\end{document}
```
```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
% 从原点 (0,0,0) 画一条直线到圆柱坐标系中 半径=1、角度默认=0、高度默认=0 的点
% 相当于在 xy 平面上，沿着 x 正方向画长度为 1 的箭头
\draw (0,0,0) -- (xyz cylindrical cs:radius=1) node[below,font=\large] {$x$};
% 从原点画一条直线到：半径=1、角度=90°（即 y 正方向）、高度默认=0 的点
% 相当于在 xy 平面上，沿着 y 正方向画长度为 1 的箭头
\draw (0,0,0) -- (xyz cylindrical cs:radius=1,angle=90)node[left,font=\large] {$y$};
% 从原点画一条直线到：半径默认=0（圆心）、角度默认=0、高度 z=1 的点
% 相当于直接沿着 z 轴正方向向上画长度为 1 的箭头
\draw (0,0,0) -- (xyz cylindrical cs:z=1)node[left,font=\large] {$z$};
\end{tikzpicture}
\end{document}
```



##### 球坐标系

xyz spherical坐标系允许你用球坐标指定点。

`/tikz/cs/radius=⟨数字⟩` (无默认值，初始为0)  x、y和z向量乘以的因子。

`/tikz/cs/latitude=⟨角度⟩` (无默认值，初始为0)  坐标在y向量和z向量之间的角度，从y向量开始测量。

`/tikz/cs/longitude=⟨角度⟩` (无默认值，初始为0)  坐标在x向量和y向量之间的角度，从y向量开始测量。

`/tikz/cs/angle=⟨角度⟩` (无默认值，初始为0)  与longitude相同。

```latex
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
% 绘制从原点指向“默认球坐标方向”的射线
% 默认情况下：radius=1, latitude=0°, longitude=0°
% 在 TikZ 的 xyz spherical cs 中：
% latitude=0°  → 在 xy 平面上（赤道面）
% longitude=0° → 指向正 x 轴方向
\draw (0,0,0) -- (xyz spherical cs:radius=1) node[right]{y};
% 绘制从原点指向“北极”的射线
% latitude=90°  表示到达北极（北纬90度）
% longitude 值在北极点时实际上不起作用（所有经度在极点重合）
\draw (0,0,0) -- (xyz spherical cs:radius=1,latitude=90)node[right]{z};
% 绘制从原点指向“赤道上、东经90°”的射线
% longitude=90° 表示沿正 y 轴方向（数学上的常用约定：0°=正x，90°=正y）
% latitude 默认=0（赤道）
\draw (0,0,0) -- (xyz spherical cs:radius=1,longitude=90)node[right]{x};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
% 绘制从原点指向“默认球坐标方向”的射线
% 默认情况下：radius=1, latitude=0°, longitude=0°
% 在 TikZ 的 xyz spherical cs 中：
% latitude=0°  → 在 xy 平面上（赤道面）
% longitude=0° → 指向正 x 轴方向
\draw (0,0,0) -- (xyz spherical cs:radius=1) node[right]{y};
% 绘制从原点指向“北极”的射线
% latitude=90°  表示到达北极（北纬90度）
% longitude 值在北极点时实际上不起作用（所有经度在极点重合）
\draw (0,0,0) -- (xyz spherical cs:radius=1,latitude=90)node[right]{z};
% 绘制从原点指向“赤道上、东经90°”的射线
% longitude=90° 表示沿正 y 轴方向（数学上的常用约定：0°=正x，90°=正y）
% latitude 默认=0（赤道）
\draw (0,0,0) -- (xyz spherical cs:radius=1,longitude=90)node[right]{x};
\end{tikzpicture}
\end{document}
```

#### 40.2 固定绘图平面

有时不需要使用完整的三维坐标进行绘制，在不同的坐标平面中进行二维绘制就足够了。以下选项帮助你切换到不同的平面。

##### 40.2.1 切换到任意平面绘图

`/tikz/plane origin=⟨点⟩` (无默认值，初始为(0,0))  平面的原点。

`/tikz/plane x=⟨点⟩` (无默认值，初始为(1,0))  新平面中x方向的单位向量。

`/tikz/plane y=⟨点⟩` (无默认值，初始为(0,1))  新平面中y方向的单位向量。

`/tikz/canvas is plane` (无值)  使用上述单位执行到新画布平面的转换。注意，你必须在调用canvas is plane之前设置单位。

```latex
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3,
plane x={(0.707,-0.707)},
plane y={(0.707,0.707)},
canvas is plane,]
\draw (0,0) -- (1,0)node[below]{new x axis};
\draw (0,0) -- (0,1)node[above]{new y axis};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3,
plane x={(0.707,-0.707)},
plane y={(0.707,0.707)},
canvas is plane,]
\draw (0,0) -- (1,0)node[below]{new x axis};
\draw (0,0) -- (0,1)node[above]{new y axis};
\end{tikzpicture}
\end{document}
```



##### 40.2.2  使用canvas is ... plane

\usetikzlibrary{3d}
作用：告诉 LaTeX 加载 TikZ 的 3D 扩展库，启用 3d 坐标系、canvas is xy plane at z=... 等功能


`/tikz/canvas is xy plane at z=⟨维度⟩` (无默认值)  具有以下属性的平面：

- plane origin={(0,0,⟨维度⟩)}
- plane x={(1,0,⟨维度⟩)}
- plane y={(0,1,⟨维度⟩)}

`/tikz/canvas is yx plane at z=⟨维度⟩` (无默认值)  具有以下属性的平面：

- plane origin={(0,0,⟨维度⟩)}
- plane x={(0,1,⟨维度⟩)}
- plane y={(1,0,⟨维度⟩)}

`/tikz/canvas is xz plane at y=⟨维度⟩` (无默认值)  具有以下属性的平面：

- plane origin={(0,⟨维度⟩,0)}
- plane x={(1,⟨维度⟩,0)}
- plane y={(0,⟨维度⟩,1)}

`/tikz/canvas is zx plane at y=⟨维度⟩` (无默认值)  具有以下属性的平面：

- plane origin={(0,⟨维度⟩,0)}
- plane x={(0,⟨维度⟩,1)}
- plane y={(1,⟨维度⟩,0)}

`/tikz/canvas is yz plane at x=⟨维度⟩` (无默认值)  具有以下属性的平面：

- plane origin={(⟨维度⟩,0,0)}
- plane x={(⟨维度⟩,1,0)}
- plane y={(⟨维度⟩,0,1)}

`/tikz/canvas is zy plane at x=⟨维度⟩` (无默认值)  具有以下属性的平面：

- plane origin={(⟨维度⟩,0,0)}
- plane x={(⟨维度⟩,0,1)}
- plane y={(⟨维度⟩,1,0)}

---

##### 40.2.3 定义旋转坐标系

在 `tikz-3dplot` 宏包中，`\tdplotsetrotatedcoords{\alpha}{\beta}{\gamma}` 是一个非常核心的命令，用于定义一个旋转后的局部坐标系。这三个参数遵循的是 $z-y'-z''$ 欧拉角旋转序列。简单来说，它通过三次连续的旋转，将初始坐标系 $(x, y, z)$ 变换到新的坐标系 $(x', y', z')$。以下是具体的旋转步骤及其含义：

一、 $\alpha$：绕原 $z$ 轴旋转
动作：将坐标系绕初始的 $z$ 轴旋转角度 $\alpha$。结果：$x$ 轴和 $y$ 轴在 $x-y$ 平面内移动，生成中间轴 $x'$ 和 $y'$。直观理解：这类似于地图上的“方位角”（Azimuth），决定了新 $x$ 轴在水平面上的朝向。

二、 $\beta$：绕新的 $y'$ 轴旋转
动作：将坐标系绕上一步得到的新 $y'$ 轴旋转角度 $\beta$。结果：$z$ 轴开始倾斜，生成 $z''$ 轴。直观理解：这决定了新 $z$ 轴相对于原 $z$ 轴的“倾斜角”（Tilt）。如果 $\beta = 90^\circ$，新 $z$ 轴将平躺在原来的 $x-y$ 平面上。

三、 $\gamma$：绕 $z''$ 轴旋转
动作：将坐标系绕上一步得到的 $z''$ 轴旋转角度 $\gamma$。
结果：$x'$ 和 $y'$ 轴绕着倾斜后的 $z''$ 轴再次自转。
直观理解：这通常用于调整新坐标系内 $x$ 和 $y$ 轴的指向。如果你只是想改变 $z$ 轴的方向，通常将 $\gamma$ 设为 $0$。

四、总结对照表

| 角度       | 旋转轴              | 对应物理/几何概念           |
| -------- | ---------------- | ------------------- |
| $\alpha$ | 初始 $z$ 轴         | 方位角 (Azimuth)       |
| $\beta$  | 当前 $y$ 轴 ($y'$)  | 极角/倾角 (Polar/Tilt)  |
| $\gamma$ | 最终 $z$ 轴 ($z''$) | 自转角 (Rotation/Roll) |

快速使用建议
如果你想在某个特定的球面坐标 $(\theta, \phi)$ 处建立一个切平面坐标系，通常的用法是：设置 $\alpha = \phi$ （经度/方位角），设置 $\beta = \theta$ （纬度/极角），设置 $\gamma = 0$ 
\tdplotdrawarc[选项]{(中心点)}{半径}{起始角度}{终止角度}{node选项}{标签}

> 注意：执行此命令后，必须在 `scope` 环境中使用 `tdplot_rotated_coords` 选项，或者在绘图命令中使用 `canvas is ...` 才能让旋转生效。


#### 40.3 斜二测绘图


##### 40.3.1  斜二测绘图的详细介绍

斜二测绘图（Oblique Axonometric Projection），也称为斜二测直观图或斜二轴测图，是一种将三维物体投影到二维平面上的轴测投影方法。它常用于工程制图、建筑设计和高中立体几何教学中，以直观的方式表现物体的空间结构。这种投影方式通过倾斜的坐标轴来模拟人眼的视觉效果，使图形更易理解，而无需复杂的透视计算。 与正等轴测（Isometric Projection）不同，斜二测在处理某些形状（如圆柱面）时更简便，尤其当圆面平行于投影面时，可以直接绘制为圆形而非椭圆。

基本原理
斜二测绘图基于斜投影原理：假设投影平面为XOZ坐标面，投射方向不垂直于投影面，而是倾斜的。具体来说：
坐标轴OX和OZ保持水平和铅垂方向，与投影面平行。
OY轴则倾斜，通常与OX轴成$45^\circ$角。
投影时，平行于坐标面的线段保持原形；垂直线段长度不变；其他方向的尺寸按规则缩放。

其核心规则是“横等纵半竖不变”：
横向（X轴）：长度不变（比例系数为1）。
纵向（Y轴）：长度变为原长的$1/2$（比例系数为0.5）。
竖向（Z轴）：长度不变（比例系数为1），且保持垂直。
平行线在投影后仍平行；垂直线保持垂直，但角度可能变为$45^\circ$或$135^\circ$。

这种投影可以视为物体从观察者左前方$45^\circ$、俯角$30^\circ$的方向观察的简化透视图。

画法步骤
斜二测绘图的绘制分为平面图形和立体图形的处理。以下是详细步骤：

缺点： 变形较大：Y轴缩半，可能导致某些图形失真。 不适合所有角度：如果多个圆面不平行投影面，仍需处理椭圆。 相比透视投影，缺乏深度感。

与其他投影的比较

| 投影类型 | 坐标轴角度          | 尺寸比例            | 适用场景      | 示例          |
| ---- | -------------- | --------------- | --------- | ----------- |
| 斜二测  | X与Y成$45^\circ$ | X:1, Y:0.5, Z:1 | 有圆面物体，教学  | 机械零件图       |
| 正等测  | 三轴成$120^\circ$ | X:Y:Z=1:1:1     | 均匀物体，游戏设计 | 等轴游戏如《模拟城市》 |
| 斜投影  | 投射线倾斜          | 自定义             | 一般三维表示    | 建筑草图        |

斜二测常用于机械制图中，当组合体只有一个平行坐标面的圆时特别合适。

##### 40.3.2  自定义斜投影绘图

z={(10:10mm)}的含义

在 TikZ 的三维坐标系设置中，`z={(10:10mm)}` 这种写法实际上是利用了极坐标 (Polar Coordinates) 来定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。

10度的具体含义：这里的 10度 指的是在 TikZ 绘图平面（画布）上，自 正右方（水平向右） 开始，逆时针旋转 10度 的方向。

具体来说： 0度：指向画布的水平正右方。90度：指向画布的正上方。10度：是一个非常接近水平向右，略微向上倾斜的方向。

为什么代码中要这样写？

默认情况下，TikZ 的三维视角通常是 $x$ 向右，$y$ 向上。当你手动指定 `z={...}` 和 `x={...}` 时，你实际上是在自定义斜二测投影（Oblique Projection）：
`z={(10:10mm)}`：让 $z$ 轴（通常代表深度或高度，取决于你的习惯）几乎水平向右延伸。
`x={(-45:5mm)}`：让 $x$ 轴指向右下方（$-45^\circ$），并且长度减半（$5\text{mm}$），以此产生透视感。

原理解析：在 TikZ 中，当你使用 `z={(angle:length)}` 时，你正在定义三维空间的 $z$ 轴在二维纸面上的投射方式：
方向 (Direction)：$z$ 轴在屏幕上的投影将指向 $10^\circ$ 的方位。
单位长度 (Unit Length)：在三维空间中 $z=1$ 的位置，在画布上对应的距离是 $10\text{mm}$。
    
总结：在你的这段代码中，$z$ 轴在画面上看起来是向右微斜向上的。如果你在三维空间画一条从 $(0,0,0)$ 到 $(0,0,1)$ 的线，它在你的 Obsidian 预览中会呈现为一条指向 $10^\circ$ 方向、长度为 $10\text{mm}$ 的线段。

可以通过调整这个坐标系，让图形看起来透视感更强（例如让 $z$ 轴垂直向上）。


```latex
\usetikzlibrary{3d}
\begin{document}
\begin{tikzpicture}[scale=3,
% ────────────────────────────────────────────────
% 非常重要的 3D 设定：自定义 x 轴、y轴和 z 轴的方向
% ────────────────────────────────────────────────
% z={(角度:长度)} 表示 z 轴在页面上的投影方向
% 这里 z={(10:10mm)} → 从原点出发，x轴正方向（水平向右）逆时针旋转10° 方向，长度 10mm 作为 z 轴的“屏幕长度”
z={(10:10mm)},
% x={(-45:5mm)} → 从原点出发，x轴正方向（水平向右）顺时针旋转45° 方向，长度 5mm（减半） 作为 x 轴的“屏幕长度”
% 注意：TikZ 3D 中 y 轴通常默认向上，此处没有显式修改 y，所以 y 保持 {(90:默认长度)}，即y轴默认为y={(90,10mm)}
x={(-45:5mm)}
]
% 绘制一条闭合路径，并填充
% 选项说明：
% fill  → 要求填充内部区域
% thick → 线条加粗（约 0.8pt）
% fill opacity=.2 → 填充颜色的不透明度只有 20%（很淡）
\draw[fill, thick, fill opacity=.2]
% 路径起点：直接给 (0,0) 即 xy 平面上的 (0,0,0)
 (0,0)
% sin 曲线到点 (1,1)
% TikZ 的 sin 和 cos 是“平滑连接”指令，不是数学上的正弦/余弦函数
% 语法：  (x1,y1) sin (x2,y2)  表示从当前点用正弦曲线平滑连接到 (x2,y2)
sin (1,1)
% 再用余弦曲线连接到 (2,0)
% cos (x,y) 与 sin 的区别主要在曲率方向相反
cos (2,0);
% 因为是闭合填充路径，TikZ 会自动从终点 (2,0) 连回起点 (0,0)
%坐标(1,1)代表坐标(x=1,y=1,z=0)；坐标(2,0)代表坐标(x=2,y=0,z=0)；
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,1)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary{3d}
\begin{document}
\begin{tikzpicture}[scale=3,
% ────────────────────────────────────────────────
% 非常重要的 3D 设定：自定义 x 轴、y轴和 z 轴的方向
% ────────────────────────────────────────────────
% z={(角度:长度)} 表示 z 轴在页面上的投影方向
% 这里 z={(10:10mm)} → 从原点出发，x轴正方向（水平向右）逆时针旋转10° 方向，长度 10mm 作为 z 轴的“屏幕长度”
z={(10:10mm)},
% x={(-45:5mm)} → 从原点出发，x轴正方向（水平向右）顺时针旋转45° 方向，长度 5mm（减半） 作为 x 轴的“屏幕长度”
% 注意：TikZ 3D 中 y 轴通常默认向上，此处没有显式修改 y，所以 y 保持 {(90:默认长度)}，即y轴默认为y={(90,10mm)}
x={(-45:5mm)}
]
% 绘制一条闭合路径，并填充
% 选项说明：
% fill  → 要求填充内部区域
% thick → 线条加粗（约 0.8pt）
% fill opacity=.2 → 填充颜色的不透明度只有 20%（很淡）
\draw[fill, thick, fill opacity=.2]
% 路径起点：直接给 (0,0) 即 xy 平面上的 (0,0,0)
 (0,0)
% sin 曲线到点 (1,1)
% TikZ 的 sin 和 cos 是“平滑连接”指令，不是数学上的正弦/余弦函数
% 语法：  (x1,y1) sin (x2,y2)  表示从当前点用正弦曲线平滑连接到 (x2,y2)
sin (1,1)
% 再用余弦曲线连接到 (2,0)
% cos (x,y) 与 sin 的区别主要在曲率方向相反
cos (2,0);
% 因为是闭合填充路径，TikZ 会自动从终点 (2,0) 连回起点 (0,0)
%坐标(1,1)代表坐标(x=1,y=1,z=0)；坐标(2,0)代表坐标(x=2,y=0,z=0)；
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,1)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

---
沿x轴方向绘制3个周期的平面波，从图片中可以看出：坐标(3,-1)代表的是(x=3,y=-1,z=0)
```latex
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
%坐标(1,1)代表坐标(x=1,y=1,z=0)；坐标(2,0)代表坐标(x=2,y=0,z=0)；
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,1)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
%坐标(1,1)代表坐标(x=1,y=1,z=0)；坐标(2,0)代表坐标(x=2,y=0,z=0)；
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,1)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

---


##### 40.3.3  交点坐标表示法

TikZ 提供了两个专门用于确定交点位置的运算符：`|-` 和 `-|`。

格式 A：`(点1 |- 点2)`
含义: 取 点 1 的横坐标 ($x$) 和 点 2 的纵坐标 ($y$)。结果: 坐标为 $(x_1, y_2)$。

格式 B：`(点1 -| 点2)`
含义: 取 点 1 的纵坐标 ($y$) 和 点 2 的横坐标 ($x$)。结果: 坐标为 $(x_2, y_1)$。

在 TikZ 中，你提到的这条命令 `\draw (.5,0) -- (0.5,0 |- 45:1cm);` 使用了一种非常强大且特殊的 坐标计算语法，称为“交点坐标表示法”。

命令详细解释：这条命令的核心作用是：从点 $(0.5, 0)$ 开始，画一条垂直线，直到它与“极坐标点 $(45:1\text{cm})$ 所在的水平线”相交为止。

(.5,0)：起点坐标，即 $x=0.5, y=0$。-- 绘制直线连接符。
(0.5,0 |- 45:1cm) ：终点坐标。这里的 `|-` 是关键运算符。
`-`左侧 `(0.5,0)`: 提供终点的 横坐标 ($x$ 轴)，即 $0.5$。
`-` 右侧 `45:1cm`: 这是一个极坐标，表示角度为 $45^\circ$、半径为 $1\text{cm}$ 的点。它为终点提供 纵坐标 ($y$ 轴)。通过三角函数计算，该点的 $y$ 值为 $1 \times \sin(45^\circ) \approx 0.707\text{cm}$。
结果: 终点的实际坐标是 $(0.5, 0.707\text{cm})$。
        
为什么在你的代码里这样写？在你的 TikZ 代码中：\draw (.5,0) -- (0.5,0 |- 45:1cm)；这种写法的精妙之处在于参数化绘制。

保持垂直: 使用 `(A |- B)` 能确保画出来的线绝对垂直，因为终点的 $x$ 坐标严格继承自起点的 $x$ 坐标。
动态对齐: 如果你想让多条垂线的高度都对齐到某个特定的点（比如极坐标定义的点），你不需要手动计算 $\sin$ 或 $\cos$ 的数值，直接引用该点即可。

> 提示: 在 Obsidian 的 TikZ 插件或导出 PDF 时，这种语法能极大地减少硬编码数值带来的对齐偏差。

```latex
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[scale=2, z={(10:10mm)},x={(-45:5mm)}]
\draw[fill,thick,fill opacity=.2](0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0);
\begin{scope}[thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,1)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```
备注： (0.5,0 |- 45:1cm)  这个坐标的 $x=0.5$ ； $y=1*sin(45) \approx 0.707 cm$ ；

```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[scale=2, z={(10:10mm)},x={(-45:5mm)}]
\draw[fill,thick,fill opacity=.2](0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0);
\begin{scope}[thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,1)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

---
使用\foreach命令，沿着x方向复制竖线
发现，平移的方向是自定义x单位向量之前的x单位向量，即水平向右的方向，可能是使用了变量或宏的原因
```
\foreach \shift in {0,4,8}
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
```

```latex
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%在限定平面内部绘图之前，绘图仍然在整个xyz空间内进行
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,10)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%在限定平面内部绘图之前，绘图仍然在整个xyz空间内进行
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,10)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

---
限定绘图范围为xy平面
此时x方向仍为原指定的x方向，y方向仍为原指定的y方向
```latex
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为xy平面
\begin{scope}[canvas is xy plane at z=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,2)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为xy平面
\begin{scope}[canvas is xy plane at z=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,2)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```
---
限定绘图范围为yz平面
此时y方向变为原指定的x方向，z方向变为原指定的y方向
```latex
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为yz平面
\begin{scope}[canvas is yz plane at x=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,13,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,3)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为yz平面
\begin{scope}[canvas is yz plane at x=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,13,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,3)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

---


限定绘图范围为xz平面
此时x方向仍为原指定的x方向，z方向变为原指定的y方向
```latex
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为xz平面
\begin{scope}[canvas is xz plane at y=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,2)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```


```tikz
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为xz平面
\begin{scope}[canvas is xz plane at y=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,2)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```


---

限定绘图范围为zx平面
此时z方向变为原指定的x方向，x方向变为原指定的y方向
```latex
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为zx平面
\begin{scope}[canvas is zx plane at y=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(13,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,2)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
%自定义三维空间的基向量（Basis Vector）在二维画布上的投影方向。
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
%限定绘图范围为zx平面
\begin{scope}[canvas is zx plane at y=0]
\draw[fill,thick,fill opacity=.2]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0)
sin (5,1) cos (6,0) sin (7,-1) cos (8,0)
sin (9,1) cos (10,0)sin (11,-1)cos (12,0);
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
\end{scope}
\draw (0,0,0)--(2,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,1,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,13)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```


---

分别在zx和zy平面绘制波形

```latex
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
\definecolor{myblue}{RGB}{63, 117, 162}
\def\wave{
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw[fill,thick,fill opacity=.3]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0);
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
}
\begin{scope}[canvas is zy plane at x=0,fill=myblue]
\wave
\node at (6,-1.5) [transform shape] {Magnetic field};
\end{scope}
\begin{scope}[canvas is zx plane at y=0,fill=orange]
\draw[help lines] (0,-1) grid (12,1);
\wave
\node at (4.5,1.5) [transform shape,rotate=180,xscale=-1] {Electric field};
\end{scope}
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,13)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[scale=1,x={(-45:5mm)},y={(90:10mm)},z={(10:10mm)}]
\definecolor{myblue}{RGB}{63, 117, 162}
\def\wave{
\foreach \shift in {0,4,8}
{
\begin{scope}[xshift=\shift cm,thin]
\draw[fill,thick,fill opacity=.3]
(0,0) sin (1,1) cos (2,0) sin (3,-1) cos (4,0);
\draw (.5,0) -- (0.5,0 |- 45:1cm);
\draw (1,0) -- (1,1);
\draw (1.5,0) -- (1.5,0 |- 45:1cm);
\draw (2.5,0) -- (2.5,0 |- -45:1cm);
\draw (3,0) -- (3,-1);
\draw (3.5,0) -- (3.5,0 |- -45:1cm);
\end{scope}
}
}
\begin{scope}[canvas is zy plane at x=0,fill=myblue]
\wave
\node at (6,-1.5) [transform shape] {Magnetic field};
\end{scope}
\begin{scope}[canvas is zx plane at y=0,fill=orange]
\draw[help lines] (0,-1) grid (12,1);
\wave
\node at (4.5,1.5) [transform shape,rotate=180,xscale=-1] {Electric field};
\end{scope}
\draw (0,0,0)--(3,0,0)node[thick,font=\large]{x};
\draw (0,0,0)--(0,2,0)node[thick,font=\large]{y};
\draw (0,0,0)--(0,0,13)node[thick,font=\large]{z};
\end{tikzpicture}
\end{document}
```




---

笛卡尔坐标系：


```tikz
\usetikzlibrary {3d}
\begin{document}
\begin{tikzpicture}[->,scale=3]
\draw (0,0,0) -- (1,0,0) node[below,font=\large] {$x$};
\draw (0,0,0) -- (0,1,0)node[left,font=\large] {$y$};
\draw (0,0,0) -- (0,0,1)node[left,font=\large] {$z$};
\end{tikzpicture}
\end{document}
```

---

绘制球体轮廓图
```latex
\begin{document}
\usetikzlibrary {3d}
\begin{tikzpicture}[scale=2]
\begin{scope}[canvas is zy plane at x=0]
\draw (0,0) circle (1cm);
\draw (-1,0) -- (1,0) (0,-1) -- (0,1);
\end{scope}
\begin{scope}[canvas is zx plane at y=0]
\draw (0,0) circle (1cm);
\draw (-1,0) -- (1,0) (0,-1) -- (0,1);
\end{scope}
\begin{scope}[canvas is xy plane at z=0]
\draw (0,0) circle (1cm);
\draw (-1,0) -- (1,0) (0,-1) -- (0,1);
\end{scope}
\end{tikzpicture}
\end{document}
```

```tikz
\begin{document}
\usetikzlibrary {3d}
\begin{tikzpicture}[scale=2]
\begin{scope}[canvas is zy plane at x=0]
\draw (0,0) circle (1cm);
\draw (-1,0) -- (1,0) (0,-1) -- (0,1);
\end{scope}
\begin{scope}[canvas is zx plane at y=0]
\draw (0,0) circle (1cm);
\draw (-1,0) -- (1,0) (0,-1) -- (0,1);
\end{scope}
\begin{scope}[canvas is xy plane at z=0]
\draw (0,0) circle (1cm);
\draw (-1,0) -- (1,0) (0,-1) -- (0,1);
\end{scope}
\end{tikzpicture}
\end{document}
```

---
#### 40.4  宏包tikz-3dplot


一、tikz-3dplot 的定位与设计目标：tikz-3dplot 是建立在 PGF/TikZ 之上的一个宏包，其核心目标是： 在 二维画布上，方便地表达三维几何示意图，提供直观的三维坐标系、旋转视角、球坐标、柱坐标，避免用户手工做三维 → 二维的投影计算。

重要结论：tikz-3dplot 并不是“真正的三维绘图引擎”，它是一个三维几何到二维投影的宏层工具。因此它非常适合：物理推导中的空间示意图，角度、立体角、方向分布，球坐标、极角、方位角示意。但不适合：高精度三维曲面渲染，自动遮挡、深度排序。

二、核心思想：视角 + 坐标变换

tikz-3dplot 的核心只有一句话：先设定观察视角，再在“数学上的三维坐标系”中作图。
观察视角的数学含义：视角由两个角度控制： θ：俯仰角（elevation），φ：方位角（azimuth）。
这与物理中球坐标方向完全一致：θ：从 _xy_ 平面抬起的角度？？？φ：在 _xy_ 平面内相对于 _x_ 轴的角度。

---
笛卡尔坐标系
```latex
\begin{document}
\begin{tikzpicture}[scale=3,thick,->,>=stealth]
\draw[](0,0,0)--(1,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,1,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,1)node[font=\large,left]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\begin{document}
\begin{tikzpicture}[scale=3,thick,->,>=stealth]
\draw[](0,0,0)--(1,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,1,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,1)node[font=\large,left]{z};
\end{tikzpicture}
\end{document}
```

---
设定观察角度tdplotsetmaincoords{60}{60}
但是不开启scope，即不使用命令begin{scope} tdplot_main_coords 和end{scope}命令，则坐标系不会发生变化。
```latex
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=3,thick,->,>=stealth]
\tdplotsetmaincoords{60}{60}
\draw[](0,0,0)--(1,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,1,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,1)node[font=\large,left]{z};
\end{tikzpicture}
\end{document}
```

```tikz
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=3,thick,->,>=stealth]
\tdplotsetmaincoords{60}{60}
\draw[](0,0,0)--(1,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,1,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,1)node[font=\large,left]{z};
\end{tikzpicture}
\end{document}
```
---
设定观察角度tdplotsetmaincoords{60}{60}
并开启scope，即使用命令begin{scope} tdplot_main_coords 和end{scope}命令，坐标系发生变化。
注意：tdplotsetmaincoords{60}{60}这个命令需要放在{tikzpicture}环境内部
```latex
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=3,thick,->,>=stealth]
\tdplotsetmaincoords{60}{60}
\begin{scope}[tdplot_main_coords]
\draw[](0,0,0)--(1,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,1,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,1)node[font=\large,left]{z};
\end{scope}
\end{tikzpicture}
\end{document}
```

```tikz
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=3,thick,->,>=stealth]
\tdplotsetmaincoords{60}{60}
\begin{scope}[tdplot_main_coords]
\draw[](0,0,0)--(1,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,1,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,1)node[font=\large,left]{z};
\end{scope}
\end{tikzpicture}
\end{document}
```

---
以(0,0,0)为圆心，在纸面所在平面绘制圆形。
\draw dotted (0,0,0) circle radius=1cm ;


```tikz
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=1,thick,->,>=stealth]
\tdplotsetmaincoords{60}{60}
\begin{scope}[tdplot_main_coords]
\draw[](0,0,0)--(6,0,0)node[font=\large,below]{x};
\draw[](0,0,0)--(0,6,0)node[font=\large,left]{y};
\draw[](0,0,0)--(0,0,6)node[font=\large,left]{z};
\draw[dotted](0,0,0)circle[radius=1cm];
\end{scope}
\end{tikzpicture}
\end{document}
```

---
三、最基础的使用流程（固定模板）

在 Obsidian 的 TikZJax 中，几乎所有 3D 图都遵循同一模板：

```latex
\begin{tikzpicture}
% 1. 加载 tikz-3dplot
\tdplotsetmaincoords{θ}{φ}
% 2. 在旋转后的坐标系中绘图
\begin{scope}[tdplot_main_coords]
% 三维图形
\end{scope}
\end{tikzpicture}
```

四、核心命令系统性说明
```latex
\tdplotsetmaincoords{θ}{φ}
```
功能：设定“观察者视角”，定义一个新的投影坐标变换。物理直觉：相当于你站在球坐标方向 $(θ, φ)$ 看向原点
```latex
\begin{scope}[tdplot_main_coords]
  ...
\end{scope}
```
功能：启用三维坐标 → 二维投影，之后所有坐标 `(x,y,z)` 都按三维处理。注意：只有在这个 scope 内，三维坐标才生效。


五、三维直角坐标系示例（最基本）

```latex
\begin{tikzpicture}
\tdplotsetmaincoords{60}{120}
\begin{scope}[tdplot_main_coords]
\draw[->] (0,0,0) -- (2,0,0) node[anchor=north east] {$x$};
\draw[->] (0,0,0) -- (0,2,0) node[anchor=north west] {$y$};
\draw[->] (0,0,0) -- (0,0,2) node[anchor=south] {$z$};
\end{scope}
\end{tikzpicture}
```

六、球坐标支持（物理中最常用）

球坐标的物理约定，tikz-3dplot 使用的约定为：$r$：径向距离； θ：极角（从 $z$ 轴向下）；φ：方位角（$xy$ 平面内）；
与物理中常见约定一致。

从球坐标画一个方向矢量
```latex
\begin{tikzpicture}
\tdplotsetmaincoords{65}{120}
\begin{scope}[tdplot_main_coords]
\tdplotsetcoord{P}{2}{40}{60}
\draw[->, thick] (0,0,0) -- (P);
\end{scope}
\end{tikzpicture}
```

命令解释\tdplotsetcoord{P}{r}{θ}{φ}
含义：定义一个点 `P`，其球坐标为 $(r, θ, φ)$，自动换算为笛卡尔坐标。

七、绘制球坐标角度（θ 与 φ）

这是 tikz-3dplot 最强、也最常被误用的部分。

绘制极角 θ
```latex
\tdplotdrawarc[->]{(0,0,0)}{0.8}{0}{40}{anchor=south}{$\theta$}
```
含义：以原点为中心，半径 0.8，从 0° 到 40° 的圆弧


绘制方位角 φ（在 xy 平面）
```latex
\tdplotdrawarc[->]{(0,0,0)}{1}{0}{60}{anchor=north}{$\varphi$}
```
注意：φ 必须在 xy 平面绘制，否则物理含义错误。

八、局部旋转坐标系（进阶但非常重要）

为什么需要局部坐标系？在物理推导中，常见需求包括：在某一方向上画垂直平面、画与某向量相关的极角、在旋转参考系中画投影。

建立旋转坐标系
```latex
\tdplotsetrotatedcoords{α}{β}{γ}
```
然后使用：tdplot_rotated_coords

示例：在某方向的垂直平面画圆
```latex
\tdplotsetcoord{P}{2}{40}{60}
\tdplotsetrotatedcoords{60}{40}{0}
\begin{scope}[tdplot_rotated_coords]
\draw (0,0,0) circle (0.5);
\end{scope}
```

九、命令tdplotdrawarc

请问这个命令是在画极角 θ还是方位角 φ？
```latex
\tdplotdrawarc[->]{(0,0,0)}{1}{30}{50}{}{$arc$} 
```
结论先行：仅从这条命令本身，无法判定它画的是极角 $θ$ 还是方位角 $φ$。它画的是“当前活动坐标平面中的一个圆弧角度”，角的物理含义完全取决于你所处的坐标系（scope）和你如何解释该平面。


######  40.4.1  在旋转后的坐标系中绘图
绘制40度方向的经线时需要注意发生旋转的坐标系。旋转后的坐标系角度的起始位置和变化方向与原坐标系保持一致，但是坐标轴的方向发生了变化。绘图时需要先固定绘图平面。
```
\tdplotsetthetaplanecoords{40}
\begin{scope}[tdplot_rotated_coords]
\end{scope}
```


```tikz
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=1,thick,>=stealth]
\tdplotsetmaincoords{60}{70}
%设定观察角度
\begin{scope}[tdplot_main_coords]
%绘制三维直角坐标系
\draw[->,thin](0,0,0)--(6,0,0)node[font=\large,below]{x};
\draw[->,thin](0,0,0)--(0,6,0)node[font=\large,right]{y};
\draw[->,thin](0,0,0)--(0,0,6)node[font=\large,left]{z};
%设定球坐标
\tdplotsetcoord{O}{0}{0}{0}
\tdplotsetcoord{A}{4}{0}{0}
\tdplotsetcoord{B}{4}{90}{40}
\tdplotsetcoord{C}{4}{90}{50}
\tdplotsetcoord{D}{4}{90}{0}
\tdplotsetcoord{E}{4}{90}{90}
\tdplotsetcoord{F}{4}{40}{40}
\tdplotsetcoord{G}{4}{40}{50}
\tdplotsetcoord{H}{4}{50}{40}
\tdplotsetcoord{I}{4}{50}{50}
\tdplotsetcoord{J}{4}{45}{45}
\tdplotsetcoord{K}{10}{45}{45}
\tdplotsetcoord{S}{4}{10}{40}
\tdplotsetcoord{T}{4}{20}{40}
%绘制xy平面的圆弧
\begin{scope}[canvas is xy plane at z=0]
\draw[dotted](0,0,0)circle[radius=0.3cm];
\draw[->,dotted](D)arc[start angle=0,end angle=90,radius=4cm];
%绘制经度的方向φ
\draw[->,cyan](B)arc[start angle=40,end angle=50,radius=4];
\node[right=0.3cm] at (B) {$\color{cyan}\vec{\phi}$};
\end{scope}
%绘制40度方向的经线
\tdplotsetthetaplanecoords{40}
\begin{scope}[tdplot_rotated_coords,->,dashed]
\draw[canvas is yx plane at z=0,dotted](B)arc[start angle=0,end angle=90,radius=4cm];
\draw[canvas is yx plane at z=0,thin,cyan,->](S)arc[start angle=80,end angle=60,radius=4cm];
\draw[->,thin](0,0,0)--(8,0,0)node[font=\large,left]{x'};
\draw[->,thin](0,0,0)--(0,8,0)node[font=\large,right]{y'};
\draw[->,thin](0,0,0)--(0,0,8)node[font=\large,right]{z'};
\node[below=0.1cm] at (T){$\color{cyan}\vec\theta$};
\end{scope}

\end{scope}
\end{tikzpicture}
\end{document}
```


node节点中的标签位置选项，如left, right, above, below都是在纸面所在平面的方向。

Stefan-Bolzmann定律示意图：点F为各向同性的均匀射射场的外表面任意一点。FGIH为一个特定的球面微元。考察的对象是时间dt范围内扫过面积微元FGIH的光子的能量。在方向空间求积分的过程中会令FG和FH的长度分别趋于0。
需要注意：图形中的$\vec{\theta}$和$\vec{\phi}$只是用于绘图的球坐标的经度方向和纬度方向，不是在方向空间中求积分时用到的$\vec{\theta}$和$\vec{\phi}$。

```tikz
\usepackage{tikz-3dplot}
\begin{document}
\begin{tikzpicture}[scale=1,thick,>=stealth]
\tdplotsetmaincoords{60}{70}
%设定观察角度
\begin{scope}[tdplot_main_coords]
%绘制三维直角坐标系
\draw[->,thin](0,0,0)--(6,0,0)node[font=\large,below]{x};
\draw[->,thin](0,0,0)--(0,6,0)node[font=\large,right]{y};
\draw[->,thin](0,0,0)--(0,0,6)node[font=\large,left]{z};
%设定球坐标
\tdplotsetcoord{O}{0}{0}{0}
\tdplotsetcoord{A}{4}{0}{0}
\tdplotsetcoord{B}{4}{90}{40}
\tdplotsetcoord{C}{4}{90}{50}
\tdplotsetcoord{D}{4}{90}{0}
\tdplotsetcoord{E}{4}{90}{90}
\tdplotsetcoord{F}{4}{40}{40}
\tdplotsetcoord{G}{4}{40}{50}
\tdplotsetcoord{H}{4}{50}{40}
\tdplotsetcoord{I}{4}{50}{50}
\tdplotsetcoord{J}{4}{45}{45}
\tdplotsetcoord{K}{10}{45}{45}
\tdplotsetcoord{S}{4}{10}{40}
\tdplotsetcoord{T}{4}{20}{40}
%绘制xy平面的圆弧
\begin{scope}[canvas is xy plane at z=0]
\draw[dotted](0,0,0)circle[radius=0.3cm];
\draw[->,dotted](D)arc[start angle=0,end angle=90,radius=4cm];
%绘制经度的方向φ
\draw[->,cyan](B)arc[start angle=40,end angle=50,radius=4];
\node[right=0.3cm] at (B) {$\color{cyan}\vec{\phi}$};
\end{scope}
%绘制Z=3.06平面上的圆弧（部分纬线）
\begin{scope}[canvas is xy plane at z=3.06]
\draw[dotted](F)arc[start angle=40,end angle=50,radius=2.57];
\end{scope}
%绘制Z=2.57平面上的圆弧（部分纬线）
\begin{scope}[canvas is xy plane at z=2.57]
\draw[dotted](H)arc[start angle=40,end angle=50,radius=3.06];
\end{scope}
%绘制40度方向的经线
\tdplotsetthetaplanecoords{40}
\begin{scope}[tdplot_rotated_coords]
\draw[canvas is xy plane at z=0,dotted](B)arc[start angle=90,end angle=0,radius=4cm];
\draw[canvas is xy plane at z=0,thin,cyan,->](S)arc[start angle=10,end angle=30,radius=4cm];
\node[below=0.1cm] at (T){$\color{cyan}\vec\theta$};
\end{scope}
%绘制50度方向的经线
\tdplotsetthetaplanecoords{50}
\begin{scope}[tdplot_rotated_coords]
\draw[canvas is xy plane at z=0,dotted](C)arc[start angle=90,end angle=0,radius=4cm];
\end{scope}
%绘制球面微元的顶点
\fill[cyan](F)circle[radius=1pt];
\fill[cyan](G)circle[radius=1pt];
\fill[cyan](H)circle[radius=1pt];
\fill[cyan](I)circle[radius=1pt];
\node[font=\small,left] at (F){F};
\node[font=\small,above] at (G){G};
\node[font=\small,left] at (H){H};
\node[font=\small,right] at (I){I};
%绘制球面微元的中心点J
\fill[red](J)circle[radius=1pt];
%绘制球面微元的外法线方向
\draw[->,thin](O)--(J)--(K)node[right]{$\vec{n}$};
%绘制：在时间dt范围内，沿着某个立体角dΩ，扫过球面微元FGIH的光子的体积
\draw[dotted](F)--++(2,2,1)coordinate(L);
\draw[dotted](G)--++(2,2,1)coordinate(M);
\draw[dotted](H)--++(2,2,1)coordinate(N);
\draw[dotted](I)--++(2,2,1)coordinate(O);
\draw[dotted](L)--(M)--(O)--(N)--cycle;
%绘制立体角dΩ的中心线方向
\coordinate (Q) at ($(J)+(2,2,1)$);
\coordinate (R) at ($(J)+(4,4,2)$);
\draw[->,thin](J)--(Q)--(R)node[right]{$\vec{d\Omega}$};
\end{scope}
\end{tikzpicture}
\end{document}
```


### 41 角度库

TikZ库 angles
```latex
\usetikzlibrary{angles} % LATEX 和 plain TEX
\usetikzlibrary[angles] % ConTEXt
```

此库定义了用于绘制角度的pic类型。

Pic类型 `angle=⟨A⟩--⟨B⟩--⟨C⟩`

此pic将角度的绘制添加到当前路径。这个"角度的绘制"由一个"扇形"或"楔形"或"切片"组成，其尖端位于点⟨B⟩，其直边位于从⟨B⟩到⟨A⟩和从⟨B⟩到⟨C⟩的线上。这些线的长度由以下键控制：`/tikz/angle radius=⟨维度⟩` (无默认值，初始为5mm)  
角度楔形边的长度：

```latex
\usetikzlibrary {angles}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (-1,-1) coordinate (C)
pic [fill=blue!50] {angle = A--B--C}
pic [draw,->,red,thick,angle radius=1cm] {angle = C--B--A};
\end{tikzpicture}
\end{document}
```

```tikz
\usetikzlibrary {angles}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (-1,-1) coordinate (C)
pic [fill=blue!50] {angle = A--B--C}
pic [draw,->,red,thick,angle radius=1cm] {angle = C--B--A};
\end{tikzpicture}
\end{document}
```


三个点⟨A⟩、⟨B⟩和⟨C⟩必须是节点或坐标的名称；你不能在这里使用像"(1,1)"这样的直接坐标。

你可以省略这三个点，在这种情况下使用文本A--B--C；所以在上面的例子中，我们可以在第一个pic中只写{angle}。

关于构成角度绘制的扇形，如果给pic传递了draw选项，则该扇形的角度部分将绘制在路径前面，而如果给pic传递了fill或shade等选项，则填充的扇形将绘制在pic后面。以下示例显示了差异：

```latex
\usetikzlibrary {angles}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw [line width=1pt] (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic [draw=blue, fill=blue!50, angle radius=1cm] {angle};
\end{tikzpicture}
\end{document}
```
```tikz
\usetikzlibrary {angles}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw [line width=1pt] (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic [draw=blue, fill=blue!50, angle radius=1cm] {angle};
\end{tikzpicture}
\end{document}
```
当设置pic text时（通常使用引号语法），将创建一个名称为空（因此继承pic的名称）的节点，该节点将位于到⟨A⟩和⟨C⟩的线之间的中间角度处，其与⟨B⟩的距离是angle radius乘以以下因子：

`/tikz/angle eccentricity=⟨因子⟩` (无默认值，初始为0.6)

```latex
\usetikzlibrary {angles,quotes}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic ["$\alpha$", draw, ->] {angle};
\end{tikzpicture}
\end{document}
```
```tikz
\usetikzlibrary {angles,quotes}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic ["$\alpha$", draw, ->] {angle};
\end{tikzpicture}
\end{document}
```

---

```latex
\usetikzlibrary {angles,quotes}
\tikz \draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic ["$\alpha$", draw, angle eccentricity=2] {angle};
```
```tikz
\usetikzlibrary {angles,quotes}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic ["$\alpha$", draw, angle eccentricity=2] {angle};
\end{tikzpicture}
\end{document}
```

---

```latex
\usetikzlibrary {angles,quotes}
\tikz {
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic (alpha) ["$\alpha$", draw] {angle};
\draw (alpha) circle [radius=5pt];
}
```
```tikz
\usetikzlibrary {angles,quotes}
\begin{document}
\begin{tikzpicture}[scale=2]
\draw (2,0) coordinate (A) -- (0,0) coordinate (B) -- (1,1) coordinate (C)
pic (alpha) ["$\alpha$", draw] {angle};
\draw (alpha) circle [radius=5pt];
\end{tikzpicture}
\end{document}
```
Pic类型 `right angle=⟨A⟩--⟨B⟩--⟨C⟩`

此pic将直角的绘制添加到当前路径。它的工作方式与angle pic相同。

```latex
\usetikzlibrary {angles}
\tikz
\draw (0,0,0) coordinate (O)
(1,0,0) coordinate (A) -- (O)
(0,0,1) coordinate (B) -- (O)
(0,1,0) coordinate (C) -- (O)
pic [fill=gray,angle radius=4mm] {right angle = A--O--B}
pic [draw,red,thick,angle eccentricity=.5,pic text=$\alpha$]
{right angle = A--O--C};
```
```tikz
\usetikzlibrary {angles,quotes}
\begin{document}
\begin{tikzpicture}[scale=4]
\draw (0,0,0) coordinate (O)
(1,0,0) coordinate (A) -- (O)
(0,0,1) coordinate (B) -- (O)
(0,1,0) coordinate (C) -- (O)
pic [fill=gray,angle radius=4mm] {right angle = A--O--B}
pic [draw,red,thick,angle eccentricity=.5,pic text=$\alpha$]
{right angle = A--O--C};
\end{tikzpicture}
\end{document}
```


### 57 林登迈尔系统绘图库

#### 57.1 概述

林登迈尔系统（通常也称为"L系统"）最初由Aristid Lindenmayer开发，作为藻类生长模式的理论，随后用于模拟植物的分支模式并产生分形模式。通常，L系统由一组符号组成，每个符号都与某些图形动作（如"向左转"或"向前移动"）相关联，以及一组规则（"生成"或"重写"规则）。给定一串符号，重写规则会应用多次，当处理结果字符串时，会执行与每个符号关联的动作。

在pgf中，L系统可用于创建简单的二维分形图案…

```latex
\usetikzlibrary {lindenmayersystems}
\begin{tikzpicture}
\pgfdeclarelindenmayersystem{Koch curve}{
\rule{F -> F-F++F-F}
}
\shadedraw [top color=white, bottom color=blue!50, draw=blue!50!black]
[l-system={Koch curve, step=2pt, angle=60, axiom=F++F++F, order=3}]
lindenmayer system -- cycle;
\end{tikzpicture}
```
```tikz
\usetikzlibrary {lindenmayersystems}
\begin{document}
\begin{tikzpicture}
\pgfdeclarelindenmayersystem{Koch curve}{
\rule{F -> F-F++F-F}
}
\shadedraw [top color=white, bottom color=blue!50, draw=blue!50!black]
[l-system={Koch curve, step=2pt, angle=60, axiom=F++F++F, order=3}]
lindenmayer system -- cycle;
\end{tikzpicture}
\end{document}
```

…以及"类似植物"的图案…

```latex
\usetikzlibrary {lindenmayersystems}
\begin{tikzpicture}
\draw [green!50!black, rotate=90]
[l-system={rule set={F -> FF-[-F+F]+[+F-F]}, axiom=F, order=4, step=2pt,
randomize step percent=25, angle=30, randomize angle percent=5}]
lindenmayer system;
\end{tikzpicture}
```

```tikz
\usetikzlibrary {lindenmayersystems}
\begin{document}
\begin{tikzpicture}[scale=3]
\draw [green!50!black, rotate=90]
[l-system={rule set={F -> FF-[-F+F]+[+F-F]}, axiom=F, order=4, step=2pt,
randomize step percent=25, angle=30, randomize angle percent=5}]
lindenmayer system;
\end{tikzpicture}
\end{document}
```


…但重要的是要记住，即使是中等复杂度的L系统也可能超出TEX的可用内存，并且可能非常慢。如果可能，建议你将主内存和保存栈增加到特定TEX发行版的最大可能值。但是，即使这样做，你可能仍会发现内存很快就用完了。

有关L系统的出色介绍（包含一些"真正很酷"的图片——其中许多遗憾的是在pgf中不可能），请参阅Przemyslaw Prusinkiewicz和Aristid Lindenmayer的《植物的算法美》（可通过互联网免费获得）。

TikZ库 lindenmayersystems

```latex
\usepgflibrary{lindenmayersystems} % LATEX、plain TEX 和纯pgf
\usepgflibrary[lindenmayersystems] % ConTEXt 和纯pgf
\usetikzlibrary{lindenmayersystems} % LATEX 和 plain TEX 使用TikZ时
\usetikzlibrary[lindenmayersystems] % ConTEXt 使用TikZ时
```

此pgf库提供了定义和使用简单L系统的基本命令。此外，TikZ库还为在TikZ中使用L系统提供了前端。


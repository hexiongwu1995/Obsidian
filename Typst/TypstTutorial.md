
```typ
#set page(fill:none)
#set text(size:4em)
#emoji.face.stars
```

# Tutorial

Welcome to Typst's tutorial! In this tutorial, you will learn how to write and format documents in Typst. We will start with everyday tasks and gradually introduce more advanced features. This tutorial does not assume prior knowledge of Typst, other markup languages, or programming. 
We do assume that you know how to edit a text file. $f(x)= integral_0^x g(t) d t$  
The best way to start is to sign up to the Typst app for free and follow along with the steps below. The app gives you instant preview, syntax highlighting and helpful autocompletions. Alternatively, you can follow along in your local text editor with the open-source CLI.

### When to use Typst

Before we get started, let's check what Typst is and when to use it. Typst is a markup language for typesetting documents. It is designed to be easy to learn, fast, and versatile. Typst takes text files with markup in them and outputs PDFs.

Typst is a good choice for writing any long form text such as essays, articles, scientific papers, books, reports, and homework assignments. Moreover, Typst is a great fit for any documents containing mathematical notation, such as papers in the math, physics, and engineering fields. Finally, due to its strong styling and automation features, it is an excellent choice for any set of documents that share a common style, such as a book series.

### What you will learn

This tutorial has four chapters. Each chapter builds on the previous one. Here is what you will learn in each of them:

1. Writing in Typst: Learn how to write text and insert images, equations, and other elements.
2. Formatting: Learn how to adjust the formatting of your document, including font size, heading styles, and more.
3. Advanced Styling: Create a complex page layout for a scientific paper with typographic features such as an author list and run-in headings.
4. Making a Template: Build a reusable template from the paper you created in the previous chapter.

We hope you'll enjoy Typst!


## Writing in Typst

Let's get started! Suppose you got assigned to write a technical report for university. It will contain prose, maths, headings, and figures. To get started, you create a new project on the Typst app. You'll be taken to the editor where you see two panels: A source panel where you compose your document and a preview panel where you see the rendered document.

You already have a good angle for your report in mind. So let's start by writing the introduction. Enter some text in the editor panel. You'll notice that the text immediately appears on the previewed page.


```
In this report, we will explore the various factors that influence fluid dynamics in glaciers 
and how they contribute to the formation and behaviour of these natural structures.
```

*Throughout this tutorial, we'll show code examples like this one. Just like in the app, the first panel contains markup and the second panel shows a preview. We shrunk the page to fit the examples so you can see what's going on.*

The next step is to add a heading and emphasize some text. Typst uses simple markup for the most common formatting tasks. To add a heading, enter the `=` character and to emphasize some text with italics, enclose it in `_underscores_`.

```typst
= Introduction
In this report, we will explore the various factors that influence _fluid dynamics_ in glaciers 

and how they contribute to the formation and behaviour of these natural structures.
```

That was easy! To add a new paragraph, just add a blank line in between two lines of text. If that paragraph needs a subheading, produce it by typing `==` instead of `=`. The number of `=` characters determines the nesting level of the heading.

Now we want to list a few of the circumstances that influence glacier dynamics. To do that, we use a numbered list. For each item of the list, we type a `+` character at the beginning of the line. Typst will automatically number the items.

```typst
+ The climate
+ The topography
+ The geology
```

If we wanted to add a bulleted list, we would use the `-` character instead of the `+` character. We can also nest lists: For example, we can add a sub-list to the first item of the list above by indenting it.

```typst
+ The climate
  - Temperature
  - Precipitation
+ The topography
+ The geology
```

### Adding a figure

You think that your report would benefit from a figure. Let's add one. Typst supports images in the formats PNG, JPEG, GIF, SVG, PDF, and WebP. To add an image file to your project, first open the *file panel* by clicking the box icon in the left sidebar. Here, you can see a list of all files in your project. Currently, there is only one: The main Typst file you are writing in. To upload another file, click the button with the arrow in the top-right corner. This opens the upload dialog, in which you can pick files to upload from your computer. Select an image file for your report.

We have seen before that specific symbols (called *markup*) have specific meaning in Typst. We can use `=`, `-`, `+`, and `_` to create headings, lists and emphasized text, respectively. However, having a special symbol for everything we want to insert into our document would soon become cryptic and unwieldy. For this reason, Typst reserves markup symbols only for the most common things. Everything else is inserted with *functions.* For our image to show up on the page, we use Typst's `image` function.

```
#image("/Obsidian/Typst/attachments/glacier.jpg")
```

In general, a function produces some output for a set of *arguments*. When you *call* a function within markup, you provide the arguments and Typst inserts the result (the function's *return value*) into the document. In our case, the `image` function takes one argument: The path to the image file. To call a function in markup, we first need to type the `#` character, immediately followed by the name of the function. Then, we enclose the arguments in parentheses. Typst recognizes many different data types within argument lists. Our file path is a short string of text, so we need to enclose it in double quotes.

The inserted image uses the whole width of the page. To change that, pass the `width` argument to the `image` function. This is a *named* argument and therefore specified as a `name: value` pair. If there are multiple arguments, they are separated by commas, so we first need to put a comma behind the path.

```
#image("glacier.jpg", width: 70%)
```

The `width` argument is a relative length. In our case, we specified a percentage, determining that the image shall take up `70%` of the page's width. We also could have specified an absolute value like `1cm` or `0.7in`.

Just like text, the image is now aligned at the left side of the page by default. It's also lacking a caption. Let's fix that by using the `figure` function. This function takes the figure's contents as a positional argument and an optional caption as a named argument.

Within the argument list of the `figure` function, Typst is already in code mode. This means, you now have to remove the hash before the image function call. The hash is only needed directly in markup (to disambiguate text from function calls).

The caption consists of arbitrary markup. To give markup to a function, we enclose it in square brackets. This construct is called a *content block.*

```
#figure(
  image("glacier.jpg", width: 70%),
  caption: [
    _Glaciers_ form an important part
    of the earth's climate system.
  ],
)
```

You continue to write your report and now want to reference the figure. To do that, first attach a label to figure. A label uniquely identifies an element in your document. Add one after the figure by enclosing some name in angle brackets. You can then reference the figure in your text by writing an `@` symbol followed by that name. Headings and equations can also be labelled to make them referenceable.

```
Glaciers as the one shown in
@glaciers will cease to exist if
we don't take action soon!

#figure(
  image("glacier.jpg", width: 70%),
  caption: [
    _Glaciers_ form an important part
    of the earth's climate system.
  ],
) <glaciers>
```

So far, we've passed content blocks (markup in square brackets) and strings (text in double quotes) to our functions. Both seem to contain text. What's the difference?

A content block can contain text, but also any other kind of markup, function calls, and more, whereas a string is really just a *sequence of characters* and nothing else.

For example, the image function expects a path to an image file. It would not make sense to pass, e.g., a paragraph of text or another image as the image's path parameter. That's why only strings are allowed here. In contrast, strings work wherever content is expected because text is a valid kind of content.

### Adding a bibliography

As you write up your report, you need to back up some of your claims. You can add a bibliography to your document with the `bibliography` function. This function expects a path to a bibliography file.

Typst's native bibliography format is Hayagriva, but for compatibility you can also use BibLaTeX files. As your classmate has already done a literature survey and sent you a `.bib` file, you'll use that one. Upload the file through the file panel to access it in Typst.

Once the document contains a bibliography, you can start citing from it. Citations use the same syntax as references to a label. As soon as you cite a source for the first time, it will appear in the bibliography section of your document. Typst supports different citation and bibliography styles. Consult the reference for more details.

```
= Methods
We follow the glacier melting models
established in @glacier-melt.

#bibliography("works.bib")
```

### Maths

After fleshing out the methods section, you move on to the meat of the document: Your equations. Typst has built-in mathematical typesetting and uses its own math notation. Let's start with a simple equation. We wrap it in `$` signs to let Typst know it should expect a mathematical expression:

```typst
The equation $Q = rho A v + C$ defines the glacial flow rate.
```


The equation $Q = rho A v + C$ is typeset inline, on the same line as the surrounding text. If you want to have it on its own line instead, you should insert a single space at its start and end:

```typst
The flow rate of a glacier is defined by the following equation:
$ Q = rho A v + C $
```

We can see that Typst displayed the single letters `Q`, `A`, `v`, and `C` as-is, while it translated `rho` into a Greek letter. Math mode will always show single letters verbatim. Multiple letters, however, are interpreted as symbols, variables, or function names. To imply a multiplication between single letters, put spaces between them.

If you want to have a variable that consists of multiple letters, you can enclose it in quotes:

```typst
The flow rate of a glacier is given by the following equation:

$ Q = rho A v + "time offset" $
```


You'll also need a sum formula in your paper. We can use the `sum` symbol and then specify the range of the summation in sub- and superscripts:

```typst
Total displaced soil by glacial flow:

$ 7.32 beta +
  sum_(i=0)^nabla Q_i / 2 $
```

To add a subscript to a symbol or variable, type a `_` character and then the subscript. Similarly, use the `^` character for a superscript. If your sub- or superscript consists of multiple things, you must enclose them in round parentheses.

The above example also showed us how to insert fractions: Simply put a `/` character between the numerator and the denominator and Typst will automatically turn it into a fraction. Parentheses are smartly resolved, so you can enter your expression as you would into a calculator and Typst will replace parenthesized sub-expressions with the appropriate notation.

```typst
Total displaced soil by glacial flow:

$ 7.32 beta + sum_(i=0)^nabla (Q_i (a_i - epsilon)) / 2 $
```


Not all math constructs have special syntax. Instead, we use functions, just like the `image` function we have seen before. For example, to insert a column vector, we can use the `vec` function. Within math mode, function calls don't need to start with the `#` character.

```typst
$ v := vec(x_1, x_2, x_3) $
```

Some functions are only available within math mode. For example, the `cal` function is used to typeset calligraphic letters commonly used for sets. The math section of the reference provides a complete list of all functions that math mode makes available.

One more thing: Many symbols, such as the arrow, have a lot of variants. You can select among these variants by appending a dot and a modifier name to a symbol's name:

```typst
$ a arrow.squiggly b $

$ a arrow b $
```

This notation is also available in markup mode, but the symbol name must be preceded with `#sym.` there. See the symbols section for a list of all available symbols.

### Review

You have now seen how to write a basic document in Typst. You learned how to emphasize text, write lists, insert images, align content, and typeset mathematical expressions. You also learned about Typst's functions. There are many more kinds of content that Typst lets you insert into your document, such as tables, shapes, and code blocks. You can peruse the reference to learn more about these and other features.

For the moment, you have completed writing your report. You have already saved a PDF by clicking on the download button in the top right corner. However, you think the report could look a bit less plain. In the next section, we'll learn how to customize the look of our document.


## Formatting

So far, you have written a report with some text, a few equations and images. However, it still looks very plain. Your teaching assistant does not yet know that you are using a new typesetting system, and you want your report to fit in with the other student's submissions. In this chapter, we will see how to format your report using Typst's styling system.

### Set rules

As we have seen in the previous chapter, Typst has functions that *insert* content (e.g. the `image` function) and others that *manipulate* content that they received as arguments (e.g. the `align` function). The first impulse you might have when you want, for example, to change the font, could be to look for a function that does that and wrap the complete document in it.

```
#text(font: "Arial")[
  = Background
  In the case of glaciers, fluid dynamics principles can be used to understand how the movement and behaviour of the ice is influenced by factors such as temperature, pressure, and the presence of other fluids (such as water).
]
```

Wait, shouldn't all arguments of a function be specified within parentheses? Why is there a second set of square brackets with content *after* the parentheses? The answer is that, as passing content to a function is such a common thing to do in Typst, there is special syntax for it: Instead of putting the content inside of the argument list, you can write it in square brackets directly after the normal arguments, saving on punctuation.

As seen above, that works. With the `text` function, we can adjust the font for all text within it. However, wrapping the document in countless functions and applying styles selectively and in-situ can quickly become cumbersome.

Fortunately, Typst has a more elegant solution. With *set rules,* you can apply style properties to all occurrences of some kind of content. You write a set rule by entering the `set` keyword, followed by the name of the function whose properties you want to set, and a list of arguments in parentheses.


```
#set text( font: "Arial" )

= Background
In the case of glaciers, fluid dynamics principles can be used to understand how the movement and behaviour of the ice is influenced by factors such as temperature, pressure, and the presence of other fluids (such as water).
```



> Want to know in more technical terms what is happening here?
> Set rules can be conceptualized as setting default values for some of the parameters of a function for all future uses of that function.

### The autocomplete panel

If you followed along and tried a few things in the app, you might have noticed that always after you enter a `#` character, a panel pops up to show you the available functions, and, within an argument list, the available parameters. That's the autocomplete panel. It can be very useful while you are writing your document: You can apply its suggestions by hitting the Return key or navigate to the desired completion with the arrow keys. The panel can be dismissed by hitting the Escape key and opened again by typing `#` or hitting `Ctrl` + `Space`. Use the autocomplete panel to discover the right arguments for functions. Most suggestions come with a small description of what they do.

### Set up the page

Back to set rules: When writing a rule, you choose the function depending on what type of element you want to style. Here is a list of some functions that are commonly used in set rules:

- `text` to set font family, size, color, and other properties of text
- `page` to set the page size, margins, headers, enable columns, and footers
- `par` to justify paragraphs, set line spacing, and more
- `heading` to set the appearance of headings and enable numbering
- `document` to set the metadata contained in the PDF output, such as title and author

Not all function parameters can be set. In general, only parameters that tell a function *how* to do something can be set, not those that tell it *what* to do it with. The function reference pages indicate which parameters are settable.

Let's add a few more styles to our document. We want larger margins and a serif font. For the purposes of the example, we'll also set another page size. 

```
#set page(
  paper: "a6",
  margin: (x: 1.8cm, y: 1.5cm),
)
#set text(
  font: "New Computer Modern",
  size: 10pt
)
#set par(
  justify: true,
  leading: 0.52em,
)

= Introduction
In this report, we will explore the
various factors that influence fluid
dynamics in glaciers and how they
contribute to the formation and
behaviour of these natural structures.

...

#align(center + bottom)[
  #image("glacier.jpg", width: 70%)

  *Glaciers form an important
  part of the earth's climate
  system.*
]
```

There are a few things of note here.

First is the `page` set rule. It receives two arguments: the page size and margins for the page. The page size is a string. Typst accepts many standard page sizes, but you can also specify a custom page size. The margins are specified as a dictionary. Dictionaries are a collection of key-value pairs. In this case, the keys are `x` and `y`, and the values are the horizontal and vertical margins, respectively. We could also have specified separate margins for each side by passing a dictionary with the keys `left`, `right`, `top`, and `bottom`. 

Next is the set `text` set rule. Here, we set the font size to `10pt` and font family to `"New Computer Modern"`. The Typst app comes with many fonts that you can try for your document. When you are in the text function's argument list, you can discover the available fonts in the autocomplete panel.

We have also set the spacing between lines (a.k.a. leading): It is specified as a length value, and we used the `em` unit to specify the leading relative to the size of the font: `1em` is equivalent to the current font size (which defaults to `11pt`).

Finally, we have bottom aligned our image by adding a vertical alignment to our center alignment. Vertical and horizontal alignments can be combined with the `+` operator to yield a 2D alignment.

### A hint of sophistication

To structure our document more clearly, we now want to number our headings. We can do this by setting the `numbering` parameter of the `heading` function.

```
#set heading(numbering: "1.")

= Introduction
#lorem(10)

== Background
#lorem(12)

== Methods
#lorem(15)
```

We specified the string `"1."` as the numbering parameter. This tells Typst to number the headings with arabic numerals and to put a dot between the number of each level. We can also use letters, roman numerals, and symbols for our headings:

```
#set heading(numbering: "1.a")

= Introduction
#lorem(50)

== Background
#lorem(50)

== Methods
#lorem(50)
```

This example also uses the `lorem` function to generate some placeholder text. This function takes a number as an argument and generates that many words of *Lorem Ipsum* text.

> Did you wonder why the headings and text set rules apply to all text and headings, even if they are not produced with the respective functions?
> Typst internally calls the `heading` function every time you write `= Conclusion`. In fact, the function call `#heading[Conclusion]` is equivalent to the heading markup above. Other markup elements work similarly, they are only *syntax sugar* for the corresponding function calls.

### Show rules

You are already pretty happy with how this turned out. But one last thing needs to be fixed: The report you are writing is intended for a larger project and that project's name should always be accompanied by a logo, even in prose.

You consider your options. You could add an `#image("logo.svg")` call before every instance of the logo using search and replace. That sounds very tedious. Instead, you could maybe define a custom function that always yields the logo with its image. However, there is an even easier way:

With show rules, you can redefine how Typst displays certain elements. You specify which elements Typst should show differently and how they should look. Show rules can be applied to instances of text, many functions, and even the whole document.

```
#show "ArtosFlow": name => box[
  #box(image(
    "logo.svg",
    height: 0.7em,
  ))
  #name
]

This report is embedded in the ArtosFlow project. ArtosFlow is a project of the Artos Institute.
```

There is a lot of new syntax in this example: We write the `show` keyword, followed by a string of text we want to show differently and a colon. Then, we write a function that takes the content that shall be shown as an argument. Here, we called that argument `name`. We can now use the `name` variable in the function's body to print the ArtosFlow name. Our show rule adds the logo image in front of the name and puts the result into a box to prevent linebreaks from occurring between logo and name. The image is also put inside of a box, so that it does not appear in its own paragraph.

The calls to the first box function and the image function did not require a leading `#` because they were not embedded directly in markup. When Typst expects code instead of markup, the leading `#` is not needed to access functions, keywords, and variables. This can be observed in parameter lists, function definitions, and code blocks.

### Review

You now know how to apply basic formatting to your Typst documents. You learned how to set the font, justify your paragraphs, change the page dimensions, and add numbering to your headings with set rules. You also learned how to use a basic show rule to change how text appears throughout your document.

You have handed in your report. Your supervisor was so happy with it that they want to adapt it into a conference paper! In the next section, we will learn how to format your document as a paper using more advanced show rules and functions.

## Styling

Typst includes a flexible styling system that automatically applies styling of your choice to your document. With set rules, you can configure basic properties of elements. This way, you create most common styles. However, there might not be a built-in property for everything you wish to do. For this reason, Typst further supports show rules that can completely redefine the appearance of elements. 

### Set rules 

With set rules, you can customize the appearance of elements. They are written as a function call to an element function preceded by the set keyword (or #set in markup). Only optional parameters of that function can be provided to the set rule. Refer to each function's documentation to see which parameters are optional. In the example below, we use two set rules to change the font family and heading numbering.

```typst
#set heading(numbering: "I.")
#set text( font: "New Computer Modern" )

= Introduction
With set rules, you can style your document.
```


A top level set rule stays in effect until the end of the file. When nested inside of a block, it is only in effect until the end of that block. With a block, you can thus restrict the effect of a rule to a particular segment of your document. Below, we use a content block to scope the list styling to one particular list. 

```typst
// This paragraph demonstrates how a 'set' rule can locally affect only the following content (because of the #[] content block / scope)

This list is affected: 
#[                      // ← Start of a content block (limits the scope of following rules)
  #set list(marker: [------])   // ← Changes the marker of all 'list' elements inside this block to "--"
  - Dash                // ← This becomes:   -- Dash
  - Another item        // ← This becomes:   -- Another item
]                       // ← End of the content block → the 'set list' rule no longer applies after this

This one is not affected (uses the document's default bullet style):
- Bullet               // ← This remains • Bullet (or whatever default marker is set)
- Another bullet
```

Sometimes, you'll want to apply a set rule conditionally. For this, you can use a set-if rule.

```typst
// Defines a custom function named "task" that creates a styled list item
// Parameters:
//   - body: the main content of the task (required, can be any content/block)
//   - critical: boolean flag, default = false
//     When true → text becomes red to indicate high priority/urgency
#let task(body, critical: false) = {
  
  // Conditional styling: only applies when critical is true
  // 'set' rules inside a function only affect content inside this scope
  set text(red) if critical
  
  // Creates a bullet list item [- ...]
  // #body means: insert the content passed to the function here
  [- #body]
}

// ────────────────────────────────────────────────
// Usage examples:
// ────────────────────────────────────────────────

// Critical task → text will be red
#task(critical: true)[Food today?]

// Normal task → default black text
#task(critical: false)[Work deadline]

// You can also omit the named argument when using the default value
#task[Buy milk tomorrow]
```

### Show rules 

With show rules, you can deeply customize the look of a type of element. The most basic form of show rule is a show-set rule. Such a rule is written as the show keyword followed by a selector, a colon and then a set rule. The most basic form of selector is an element function. This lets the set rule only apply to the selected element. In the example below, headings become dark blue while all other text stays black.

General syntax forms of "show" function

```
// Most common: show-set rule (modifies properties without replacing the element)
#show 〈selector〉: set 〈function〉(〈arguments〉…)

// Full custom replacement with a function
#show 〈selector〉: 〈it〉 => 〈new content〉

// Shorthand: no parameter name (implicit "it")
#show 〈selector〉: 〈new content using it〉

// Special case: show everything (whole document from here)
#show: 〈function〉          // receives the remaining document content as argument
#show: 〈it〉 => …           // same as above
```


A small example:

```typst

// Tell Typst: whenever you encounter a heading, automatically apply the following style to it. This is a show rule — one of the most powerful styling mechanisms in Typst.

#show heading: set text(navy)

// This creates a level-1 heading
// Because of the show rule above, all headings will now use navy color
= This is navy-blue

// Normal paragraph text — not affected by the previous show rule
But this stays black.
```

Another example:

```
#show "ArtosFlow": name => box[ #box(image( "logo.svg", height: 0.7em)) #name ]

This report is embedded in the ArtosFlow project. ArtosFlow is a project of the Artos Institute.
```

This Typst snippet is a clever way to automate branding. It essentially says: "Every time the text 'ArtosFlow' appears, replace it with a version that includes a logo." Here is the breakdown of the code with detailed comments:

Deep Dive: The `show` Function Syntax
The `show` rule is one of Typst's most powerful features. It acts as a "search and style" mechanism. Its general syntax in this context is: `#show <selector>: <transform-function>`.

The Selector (`"ArtosFlow"`)
The first part tells Typst what to look for. In your code, it is a simple string. Typst will scan the document for every instance of this specific text. Other selectors can be elements, like `heading` or `emphasis`.

The Transformation (`name => ...`)
This is a lambda function (anonymous function).
 `name`: This is the parameter representing the content that was matched by the selector. In this case, `name` holds the value "ArtosFlow".
  `=>`: This arrow separates the input parameter from the output layout.
 `box[...]`: This defines what the new output looks like. By wrapping the logo and the text in a `box`, you ensure they stay together on the same line and don't break apart during word-wrapping.

Why use `name` instead of just typing "ArtosFlow" again?
By using the variable `name`, your code remains flexible. If you were to change the selector to a regular expression or a more complex object later, the function body would still correctly reference whatever was "caught" by the selector.

Summary of Layout Logic
The code creates a nested box structure. The logic follows the standard height ratio of text:
This ensures that the logo scales naturally if you change the font size of your document paragraphs later.

```
// Use a 'show' rule to transform all occurrences of the string "ArtosFlow"
#show "ArtosFlow": name => box[ 
// Inside the transformation:
// 1. Place the logo SVG, constrained to the height of the current line text (0.7em)
  #box(image("logo.svg", height: 0.7em)) 

// 2. Place the original matched text ("ArtosFlow") next to the logo
  #name 
]
This report is embedded in the ArtosFlow project. ArtosFlow is a project of the Artos Institute.
```


With show-set rules you can mix and match properties from different functions to achieve many different effects. But they still limit you to what is predefined in Typst. For maximum flexibility, you can instead write a transformational show rule that defines how to format an element from scratch. To write such a show rule, replace the set rule after the colon with an arbitrary function. This function receives the element in question and can return arbitrary content. The function is often defined inline as it => .. using the unnamed function syntax. The function's parameter is typically named it by convention.

The available fields on the element passed to the function match the parameters of the respective element function. Below, we define a show rule that formats headings for a fantasy encyclopedia.

The show rule itself adds tilde characters around the title (these must be escaped with a backslash because otherwise they would indicate a non-breaking space), emphasizes the title with italics, and then displays the heading counter after the title.

For this example, we also wanted center alignment and a different font. While we could've added these set rules into the existing show rule, we instead added them as separate show-set rules. This is good practice because now these rules can still be overridden by later show-set rules in the document, keeping styling composable. In contrast, set rules within a transformational show rule would not be overridable anymore.

```
#set heading(numbering: "(I)")
#show heading: set align(left)
#show heading: set text(font: "Inria Serif")
#show heading: it => block[
  \~
  #emph(it.body)
  #counter(heading).display(it.numbering)
  \~
]

= Dragon
With a base health of 15, the dragon is the most powerful creature.

= Manticore
While less powerful than the dragon, the manticore gets extra style points.
```


In Typst, the `show` rule you've provided acts like a template that intercepts every heading and wraps it in a custom block. Here is the breakdown of those two specific functions:

`emph(it.body)`, This function handles the content of your heading.
 `it`: This is the "element" object (the heading itself) being passed into the function.
`.body`: This is a property of the heading that contains the actual text you wrote (e.g., "Dragon" or "Manticore").
`emph(...)`: This is the emphasis function. By wrapping the body in it, you are telling Typst to render the heading text in italics
Syntax Logic: `$emph(content)$`

`#counter(heading).display(it.numbering)`
This function handles the automatic numbering of your heading.
`counter(heading)`: This identifies the specific internal counter that Typst uses to track headings (1, 2, 3...).
`.display(...)`: This method tells Typst *how* to show that counter's current value.
`it.numbering`: This refers back to the format you defined in your very first line: `#set heading(numbering: "(I)")`.
Instead of hard-coding a style, `it.numbering` dynamically grabs `"(I)"` so the counter displays as (I), (II), etc.
Syntax Logic: `$counter(key).display(format)$`

Summary Table

| Code Segment       | Purpose                               | Result in your Example |
| ------------------ | ------------------------------------- | ---------------------- |
| `it.body`          | Accesses the text of the heading.     | "*Dragon*"             |
| `it.numbering`     | Accesses the defined numbering style. | `"(I)"`                |
| `counter(heading)` | Tracks the current heading index.     | `1`, `2`, `3`...       |

Like set rules, show rules are in effect until the end of the current block or file.

Instead of a function, the right-hand side of a show rule can also take a literal string or content block that should be directly substituted for the element. And apart from a function, the left-hand side of a show rule can also take a number of other selectors that define what to apply the transformation to:

```
Everything: show: rest => ..
Transform everything after the show rule. This is useful to apply a more complex layout to your whole document without wrapping everything in a giant function call.

Text: show "Text": ..
Style, transform or replace text.

Regex: show regex("\w+"): ..
Select and transform text with a regular expression for even more flexibility. See the documentation of the regex type for details.

Function with fields: show heading.where(level: 1): ..
Transform only elements that have the specified fields. For example, you might want to only change the style of level-1 headings.

Label: show <intro>: ..
Select and transform elements that have the specified label. See the documentation of the label type for more details.
```



```typst
#show "Project": smallcaps
#show "badly": "great"

We started Project in 2019 and are still working on it. Project is progressing badly.
```


## Advanced Styling

In the previous two chapters of this tutorial, you have learned how to write a document in Typst and how to change its formatting. The report you wrote throughout the last two chapters got a straight A and your supervisor wants to base a conference paper on it! The report will of course have to comply with the conference's style guide. Let's see how we can achieve that.

Before we start, let's create a team, invite your supervisor and add them to the team. You can do this by going back to the app dashboard with the back icon in the top left corner of the editor. Then, choose the plus icon in the left toolbar and create a team. Finally, click on the new team and go to its settings by clicking 'manage team' next to the team name. Now you can invite your supervisor by email.

Next, move your project into the team: Open it, going to its settings by choosing the gear icon in the left toolbar and selecting your new team from the owners dropdown. Don't forget to save your changes!

Now, your supervisor can also edit the project and you can both see the changes in real time. You can join our Discord server to find other users and try teams with them!

### The conference guidelines

The layout guidelines are available on the conference website. Let's take a look at them:

- The font should be an 11pt serif font
- The title should be in 17pt and bold
- The paper contains a single-column abstract and two-column main text
- The abstract should be centered
- The main text should be justified
- First level section headings should be 13pt, centered, and rendered in small capitals
- Second level headings are run-ins, italicized and have the same size as the body text
- Finally, the pages should be US letter sized, numbered in the center of the footer and the top right corner of each page should contain the title of the paper

We already know how to do many of these things, but for some of them, we'll need to learn some new tricks.

### Writing the right set rules

Let's start by writing some set rules for the document.

```
#set page(
  paper: "us-letter",
  header: align(right)[ A Fluid Dynamic Model for Glacier Flow ],
  numbering: "1",
)
#set par(justify: true, leading:1em)
#set text(
  font: "Arial",
//  font: "Libertinus Serif",
  size: 11pt,
)

#lorem(100)
```

You are already familiar with most of what is going on here. We set the text size to `11pt` and the font to Libertinus Serif. We also enable paragraph justification and set the page size to US letter.

The `header` argument is new: With it, we can provide content to fill the top margin of every page. In the header, we specify our paper's title as requested by the conference style guide. We use the `align` function to align the text to the right.

Last but not least is the `numbering` argument. Here, we can provide a numbering pattern that defines how to number the pages. By setting it to `"1"`, Typst only displays the bare page number. Setting it to `"(1/1)"` would have displayed the current page and total number of pages surrounded by parentheses. And we could even have provided a completely custom function here to format things to our liking.

### Creating a title and abstract

Now, let's add a title and an abstract. We'll start with the title. Typst comes with a `title` function. Let's start by providing our title as an argument:

```typst
#title[ A Fluid Dynamic Model for Glacier Flow ]
```

You can see that the title is already boldfaced and has some space around it. However, it is left-aligned and not exactly 17pt large. Hence, we need to adjust its appearance. The title function does not come with any arguments for font or text size we could set. Instead, these properties are defined on the `text` and `align` functions.

> What is the difference between what the `title` function inserted and the headings we produced with equals signs?
> Headings, even first-level headings, can appear multiple times in your document whereas a title only appears once, usually at the beginning. Differentiating between the two helps Typst make your document accessible for users of Assistive Technology such as screen readers.

When we want to customize the properties of some element inside of another kind of element, we can use show-set rules. First, we use `show` to select which element we want to customize. We call this a *selector.* Then, we type a colon. Next, we write the set rule that should apply to elements matching the selector. Summarized, the syntax looks like this:

```
#show your-selector: set some-element(/* ... */)
```

Let's recall: We want to center-align the title and make it 17pt large. Hence, we need two show-set rules:

- One with the selector `title` and the rule `set text(size: 17pt)`
- One with the selector `title` and the rule `set align(center)`

Our example now looks like this:

```
#show title: set text(size: 17pt)
#show title: set align(center)

#title[ A Fluid Dynamic Model for Glacier Flow ]
```

This looks right. Let's also add the author list: Since we are writing this paper together with our supervisor, we'll add our own and their name.

```
#grid(
  columns: (1fr, 1fr),  // 1fr = 1 fraction
  align(center)[
    Therese Tungsten \     // \=#linebreak()
    Artos Institute \
    #link("mailto:tung@artos.edu")
  ],
  align(center)[
    Dr. John Doe \
    Artos Institute \
    #link("mailto:doe@artos.edu")
  ]
)
```

The two author blocks are laid out next to each other. We use the `grid` function to create this layout. With a grid, we can control exactly how large each column is and which content goes into which cell. The `columns` argument takes an array of relative lengths or fractions. In this case, we passed it two equal fractional sizes, telling it to split the available space into two equal columns. We then passed two content arguments to the grid function. The first with our own details, and the second with our supervisors'. We again use the `align` function to center the content within the column. The grid takes an arbitrary number of content arguments specifying the cells. Rows are added automatically, but they can also be manually sized with the `rows` argument.

Looking at the authors and the title, they are a bit too close together. You can address this by using another show-set rule to configure the space below the title. The title, the grid, paragraphs, and all other elements that Typst arranges from the top to the bottom of the page are called *blocks.* Each block is controlled by the `block` function. It controls behaviors like their distance and whether a block can contain a page break. That means that we can write another show-set rule that selects the title to set the block spacing: 

```
#show title: set text(size: 17pt)
#show title: set align(center)
#show title: set block(below: 1.2em)

#title[ A Fluid Dynamic Model for Glacier Flow ]

#grid(
  // ...
)
```

With this show-set rule, we overrode the spacing below the title. We have used the `em` unit: It allows us to express lengths as multiples of the font size. Here, we used it to space the title and the author list exactly 1.2× the font size apart. Now, let's add the abstract. Remember that the conference wants the abstract to be set ragged and centered. 

```
...

#align(center)[
  #set par(justify: false)
  *Abstract* \
  #lorem(80)
]
```

Well done! One notable thing is that we used a set rule within the content argument of `align` to turn off justification for the abstract. This does not affect the remainder of the document even though it was specified after the first set rule because content blocks *scope* styling. Anything set within a content block will only affect the content within that block.

Another tweak could be to remove the duplication between the header and the title element's argument. Since they share the title, it would be convenient to store it in a place designed to hold metadata about the document. We would then need a way to retrieve the title in both places. The `document` element can help us with the former: By using it in a set rule, we can store document metadata like title, description, and keywords. 

```
#set document(title: [A Fluid Dynamic Model for Glacier Flow])
```

When exporting a PDF, the title set here will appear in the title bar of your PDF reader. Your operating system will also use this title to make the file retrievable with search. Last but not least, it contributes to making your document more accessible and is required if you choose to comply with PDF/UA, a PDF standard focused on accessibility. 

Now, we need a way to retrieve the value we set in the main title and the header. Because the `title` function is designed to work together with the `document` element, calling it with no arguments will just print the title. For the header, we will need to be more explicit: Because Typst has no way of knowing that we want to insert the title there, we will need to tell it to do so manually.

Using *context,* we can retrieve the contents of any values we have set on elements before. When we use the `context` keyword, we can access any property of any element, including the document element's title property. Its use looks like this:

```
#set document(title: [ A Fluid Dynamic Model for Glacier Flow ])
#set page(
  header: align(
    right + horizon,
    // Retrieve the document element's title property.
    context document.title,
  )
)

#title()

```

First, notice how we called the title function with empty, round parentheses. Because no argument was passed, it defaulted to what we set for the document element above. The distinction between empty round and empty square brackets is important: While empty round brackets show that you are passing nothing, empty square brackets mean that you are passing one argument: an empty content block. If called that way, the title would have no visible content.

Next, take a look at the header. Instead of the title in square parentheses, we used the context keyword to access the document title. This inserted exactly what we set above. The role of context is not limited to accessing properties: With it, you can check if some elements are present in the document, measure the physical dimensions of others, and more. Using context, you can build powerful templates that react to the preferences of the end-user. 

> Why is the context keyword required to access element properties?
> Normally, when we access a variable, we know exactly what its value is going to be:
> - The variable could be a constant built into Typst, like `#sym.pi`
> - The variable could be defined by an argument
> - The variable could be defined or overwritten in the current scope
>
> However, sometimes, that's not enough. In this chapter of the tutorial, we have inserted a page header with the title. Even though we pass only one piece of content for the header, we may want different pages to have different headers. For example, we may want to print the chapter name or use the page number. When we use context, we can write a single context block that tells Typst to take a look at where it's inserted, look for the last heading, the current page number, or anything else, and go from there. That means that the same context block, inserted on different pages, can produce different output.

For more information, read up on context in its docs after completing this tutorial.

### Adding columns and headings

The paper above unfortunately looks like a wall of lead. To fix that, let's add some headings and switch our paper to a two-column layout. Fortunately, that's easy to do: We just need to amend our `page` set rule with the `columns` argument.

By adding `columns: 2` to the argument list, we have wrapped the whole document in two columns. However, that would also affect the title and authors overview. To keep them spanning the whole page, we can wrap them in a function call to `place`. Place expects an alignment and the content it should place as positional arguments. Using the named `scope` argument, we can decide if the items should be placed relative to the current column or its parent (the page). There is one more thing to configure: If no other arguments are provided, `place` takes its content out of the flow of the document and positions it over the other content without affecting the layout of other content in its container: 

```
#place(
  top + center,
  rect(fill: black),
)
#lorem(30)
```

If we hadn't used `place` here, the square would be in its own line, but here it overlaps the few lines of text following it. Likewise, that text acts as if there was no square. To change this behavior, we can pass the argument `float: true` to ensure that the space taken up by the placed item at the top or bottom of the page is not occupied by any other content. 

```
#set document(title:[A Fluid Dynamics Model for Glacier Flow])

#set page(
  paper: "us-letter",
  header: align( right + horizon, context document.title, ),
  numbering: "1",
  columns: 2,
)
#title()
#place( top + center, float: true, scope: "parent", clearance: 2em,
)[
  #par(justify: false)[ *Abstract* \  #lorem(80) ]
]

= Introduction
#lorem(300)

= Related Work
#lorem(200)

```

In this example, we also used the `clearance` argument of the `place` function to provide the space between it and the body instead of using the `v` function. We can also remove the explicit `align(center, ..)` calls around the various parts since they inherit the center alignment from the placement. 

Now there is only one thing left to do: Style our headings. We need to make them centered and use small capitals. These properties are not available on the `heading` function, so we will need to write a few show-set rules and a show rule:

- A show-set rule to make headings center-aligned
- A show-set rule to make headings 13pt large and use the regular weight
- A show rule to wrap the headings in a call to the `smallcaps` function

```
#show heading: set align(center)
#show heading: set text( size: 13pt, weight: "regular",)
#show heading: smallcaps

...

= Introduction
...

== Motivation
...
```

This looks great! We used show rules that apply to all headings. In the final show rule, we applied the `smallcaps` function to the complete heading. As we will see in the next example, we can also provide a custom rule to completely override the default look of headings.

The only remaining problem is that all headings look the same now. The "Motivation" and "Problem Statement" subsections ought to be italic run-in headers, but right now, they look indistinguishable from the section headings. We can fix that by using a `where` selector on our show rule: This is a method we can call on headings (and other elements) that allows us to filter them by their properties. We can use it to differentiate between section and subsection headings:

```
#show heading.where(level: 1): set align(center)
#show heading.where(level: 1): set text(size: 13pt, weight: "regular")
#show heading.where(level: 1): smallcaps

#show heading.where(level: 2): set text( size: 11pt, weight: "regular", style: "italic",)
#show heading.where(level: 2): it => { it.body + [.] }

= Introduction

== Motivation
#lorem(50)

```

In this example, we first scope our previous rules to first-level headings by using `.where(level: 1)` to make the selector more specific. Then, we add a show-set rule for the second heading level. Finally, we need a show rule with a custom function: Headings enclose their contents with a block by default. This has the effect that the heading gets its own line. However, we want it to run into the text, so we need to provide our own show rule to get rid of this block.

We provide the rule with a function that takes the heading as a parameter. This parameter is conventionally called `it`, but can have another name. The parameter can be used as content and will just display the whole default heading. Alternatively, when we want to build our own heading instead, we can use its fields like `body`, `numbering`, and `level` to compose a custom look. Here, we are just printing the body of the heading with a trailing dot and leave out the block that the built-in show rule produces. Note that this heading will no longer react to set rules for heading numbering and similar because we did not explicitly use `it.numbering` in the show rule. If you are writing show rules like this and want the document to remain customizable, you will need to take these fields into account. 

This looks great! We wrote show rules that selectively apply to the first and second level headings. We used a `where` selector to filter the headings by their level. We then rendered the subsection headings as run-ins. We also automatically add a period to the end of the subsection headings. 

Let's review the conference's style guide:

- The font should be an 11pt serif font ✓
- The title should be in 17pt and bold ✓
- The paper contains a single-column abstract and two-column main text ✓
- The abstract should be centered ✓
- The main text should be justified ✓
- First level section headings should be centered, rendered in small caps and in 13pt ✓
- Second level headings are run-ins, italicized and have the same size as the body text ✓
- Finally, the pages should be US letter sized, numbered in the center and the top right corner of each page should contain the title of the paper ✓

We are now in compliance with all of these styles and can submit the paper to the conference!

### Review

You have now learned how to create titles, headers, and footers, how to use functions, show-set rules, and scopes to locally override styles, how to create more complex layouts with the `grid` function, how to access element properties with context, and how to write show rules for individual functions, and the whole document. You also learned how to use the `where` selector to filter the headings by their level.

The paper was a great success! You've met a lot of like-minded researchers at the conference and are planning a project which you hope to publish at the same venue next year. You'll need to write a new paper using the same style guide though, so maybe now you want to create a time-saving template for you and your team?

In the next section, we will learn how to create templates that can be reused in multiple documents. This is a more advanced topic, so feel free to come back to it later if you don't feel up to it right now.



## Making a Template

In the previous three chapters of this tutorial, you have learned how to write a document in Typst, apply basic styles, and customize its appearance in-depth to comply with a publisher's style guide. Because the paper you wrote in the previous chapter was a tremendous success, you have been asked to write a follow-up article for the same conference. This time, you want to take the style you created in the previous chapter and turn it into a reusable template. In this chapter you will learn how to create a template that you and your team can use with just one show rule. Let's get started! 

### Reusing data with variables

In the past chapters, most of the content of the document was entered by hand. In the third chapter, we used the `document` element and context to cut down on repetition and only enter the title once. But in practice, there may be many more things that occur multiple times in your document. There are multiple good reasons to just define these repeated values once: 

1. It makes changing them later easier
2. It allows you to quickly find all instances where you used something 
3. It makes it easy to be consistent throughout
4. For long or hard-to-enter repeated segments, a shorter variable name is often more convenient to type

If you were using a conventional word processor, you might resort to using a placeholder value that you can later search for. In Typst, however, you can instead use variables to safely store content and reuse it across your whole document through a variable name. 

The technique of using context to reproduce an element's property we have learned earlier is not always the most appropriate for this: Typst's built-in elements focus on semantic properties like the title and description of a document, or things that directly relate to typesetting, like the text size.

For our example, we want to take a look at Typst's pronunciation. One of the best ways to transcribe pronunciation is the International Phonetic Alphabet (IPA). But because it uses characters not found on common keyboards, typing IPA repeatedly can become cumbersome. So let's instead define a variable that we can reference multiple times. 

```
#let ipa = [taɪpst]
```

Here, we use a new keyword, `let`, to indicate a variable definition. Then, we put the name of our variable, in this case, `ipa`. Finally, we type an equals sign and the value of our variable. It is enclosed in square brackets because it is content, mirroring how you would call a function accepting content. In other words, this syntax mirrors the phrase *"Let the variable `ipa` have the value `[taɪpst]`."* 

Now, we can use the variable in our document: 

```
#let ipa = [taɪpst]

The canonical way to pronounce Typst is #ipa.

#table(
  columns: (1fr, 1fr),
  [Name], [Typst],
  [Pronunciation], ipa,
)
```

In the example, you can see that the variable can be used both in markup (prefixed with a `#`) and in a function call (by just typing its name). Of course, we can change the value of the variable and all its occurrences will automatically change with it. Let's make it a bit clearer what is IPA and what is normal prose by rendering IPA in italics. We are also using slashes which, by convention, often enclose IPA. 

```
#let ipa = text( style: "italic",)[/taɪpst/]

The canonical way to pronounce Typst is #ipa.

#table(
  columns: (1fr, 1fr),
  [Name], [Typst],
  [Pronunciation], ipa,
)
```

Here, we called the text function and assigned its *return value* to the variable. When you call a function, it processes its arguments and then yields another value (often content). So far in this tutorial, we called most functions directly in markup, like this: `#text(fill: red)[CRIMSON!]`. This call to the text function returns the red text as a return value. Because we placed it in markup, its return value just immediately got inserted into the content we wrote. With variables, we can instead store it to use it later or compose it with other values. 

Variables are not limited to storing content: they can store any data type Typst knows about. Throughout this tutorial, you made use of many data types when you passed them to Typst's built-in functions. Here is an example assigning each of them to a variable: 

```
// Content with markup inside
#let blind-text = [_Lorem ipsum_ dolor sit amet]

// Unformatted strings
#let funny-font = "MS Comic Sans"

// Absolute lengths (see also pt, in, ...)
#let mile = 160934cm

// Lengths relative to the font size
#let double-space = 2em

// Ratios
#let progress = 80%

// Integer numbers
#let answer = 42

// Booleans
#let truth = false

// Horizontal and vertical alignment
#let focus = center
```

### A toy template

In Typst, templates are functions in which you can wrap your whole document. To learn how to do that, let's first review how to write your very own functions. They can do anything you want them to, so why not go a bit crazy?

```
#let amazed(term) = box[✨ #term ✨]

You are #amazed([beautiful])   !

// Defines a reusable function (command) named "amazed", It takes one parameter called "term" (the content to be wrapped) , box[] creates a visual container around the content, #term places the argument content here, The ✨ symbols are just decorative Unicode emojis. When you write #amazed([beautiful]), it calls the function and replaces it with: box[✨ beautiful ✨]
```

Comparing this against the previous section, you may have noticed that this looks a lot like a variable definition using `let`. This instinct is correct: Functions are just another data type. Here, we are defining the variable `amazed`, assigning it a function that takes a single argument, `term`, and returns content with the `term` surrounded by sparkles. We also put the whole thing in a `box` so that the term we are amazed by cannot be separated from its sparkles by a line break. The special function definition syntax makes the definition shorter and more readable, but you can also use the regular variable definition syntax (see the scripting reference for details). After its definition, we are able to call the function just like all built-in functions.

```
我很漂亮！
```


Templates now work by wrapping our whole document in a custom function like `amazed`. But wrapping a whole document in a giant function call would be cumbersome! Instead, we can use an "everything" show rule to achieve the same with cleaner code. To write such a show rule, put a colon directly after the show keyword and then provide a function. This function takes the rest of the document as a parameter. The function can then do anything with this content. Since the `amazed` function above can be called with a single content argument, we can just pass it by name to the show rule. Let's try it:

```
#let amazed(term, color: blue) = { text(color, box[✨ #term ✨]) }
#show: amazed
I choose to focus on the good in my life and let go of any negative thoughts or beliefs. In fact, It's a most reasonable way to live a person's life! 
```

Our whole document will now be passed to the `amazed` function, as if we wrapped it around the function. Of course, this is not especially useful with this particular function, but when combined with set rules and named arguments, it can be very powerful.

#### Code block in function definition

Many functions that come with Typst have optional named parameters. Our functions can also have them. Let's add a parameter to our function that lets us choose the color of the text. We need to provide a default color in case the parameter isn't given.

```
#let amazed(term, color: blue) = { text(color, box[✨ #term ✨]) }

You are #amazed[beautiful]!

I am #amazed(color: purple)[amazed]!

I am #amazed([testing],color:green)!
```

Above is a snippet of Typst code. I feel puzzled and confused about the syntax of `={...}`. Could you please provide clear and concise explanations. Then, incorporate these explanations as annotations inside the code snippet.

Quick explanation of ={ ... } syntax. In Typst, when defining a function, there are two common styles: 

| Style                                         | Meaning                                                            | When people use it                                |
| --------------------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------- |
| `#let f(x) = expr`                            | Single expression body (most common & cleanest)                | Short & simple functions                          |
| `#let f(x) = { ...statements...; last-expr }` | Code block body — allows multiple statements + local variables | When you need `if`, `for`, `let`, multiple steps… |
 The = followed immediately by { ... } is not a special operator. It simply means: the body of the function is a code block ( { … } ). So these two are exactly equivalent: 

```
// Style A (expression body)
#let add(a, b) = a + b

// Style B (code block body)
#let add(a, b) = { a + b }
```

Your function uses the code block style because it contains more than one thing inside (function call + content incorporation ).

#### positional argument

Below is a snippet of Typst code. I feel puzzled and confused about the positional argument `term` and named argument 'color'. I have no idea about what is a positional argument. Please provide clear and concise explanations.
 
```
#let amazed(term, color: blue) = text(color, box[✨ #term ✨])
You are #amazed[beautiful]!

I am #amazed(color: purple)[amazed]!

I am #amazed([testing],color:green)!
```

It’s perfectly normal to feel a bit confused by these terms—they are fundamental concepts in programming that aren't always explained in a "human-friendly" way. In Typst (and many other languages), arguments are simply the "inputs" you give to a function so it knows what to do.

What is a Positional Argument? (`term`)
A positional argument is defined by its order. The function knows what the value is based on where it sits in the list. In your code: `term` is a positional argument because it doesn't have a default value (like `= blue`) in the definition. The Rule: When you call `#amazed[beautiful]`, Typst sees that `[beautiful]` is the first thing you provided, so it automatically assigns it to `term`.

What is a Named Argument? (`color`)
A named argument is identified by a specific label (a name). These usually have a default value, making them optional. In your code: `color: blue` is a named argument. The Benefit: You can put named arguments in any order, or skip them entirely. If you skip it, Typst just uses the default (`blue`).

Breaking Down Your Examples

| Code | How Typst sees it |
| --- | --- |
| `#amazed[beautiful]` | `term` is `[beautiful]`. Since `color` wasn't mentioned, it stays `blue`. |
| `#amazed(color: purple)[amazed]` | `color` is `purple`. The `[amazed]` in brackets is treated as the positional `term`. |
| `#amazed([testing], color: green)` | `term` is `[testing]` (1st position). `color` is `green` (named). |

A Quick Note on Typst Syntax
Typst has a special "shorthand": if you put content in square brackets `[]` immediately after a function, Typst treats it as a positional argument. `#amazed[Hello]` is exactly the same as `#amazed([Hello])`.


### Embedding set and show rules

To apply some set and show rules to our template, we can use `set` and `show` within a content block in our function and then insert the document into that content block. 

```
#let template(doc) = [
  #set text(font: "Inria Serif")
  #show "something cool": [Typst]
  #doc
]

#show: template
I am learning something cool today. It's going great so far!
```

Just like we already discovered in the previous chapter, set rules will apply to everything within their content block. Since the everything show rule passes our whole document to the `template` function, the text set rule and string show rule in our template will apply to the whole document. Let's use this knowledge to create a template that reproduces the body style of the paper we wrote in the previous chapter.

```
#let conf(title, doc) = {
  set page( paper: "us-letter", header: align( right + horizon, title ), columns: 2,)
  set par(justify: true)
  set text( font: "Libertinus Serif", size: 11pt,)

  // Heading show rules.
  doc
}

#show: doc => conf( [Paper title], doc)

// doc is a positional argument. Command `show: doc' puts the rest of the document as the positional argument of doc
= Introduction

#lorem(600)
```

We copy-pasted most of that code from the previous chapter. The two differences are this:

1. We wrapped everything in the function `conf` using an everything show rule. The function applies a few set and show rules and echoes the content it has been passed at the end.
2. Moreover, we used a curly-braced code block instead of a content block. This way, we don't need to prefix all set rules and function calls with a `#`. In exchange, we cannot write markup directly in the code block anymore.

Also note where the title comes from: We previously had it inside of a variable. Now, we are receiving it as the first parameter of the template function. To do so, we passed a closure (that's a function without a name that is used right away) to the everything show rule. We did that because the `conf` function expects two positional arguments, the title and the body, but the show rule will only pass the body. Therefore, we add a new function definition that allows us to set a paper title and use the single parameter from the show rule.

### Templates with named arguments

Our paper in the previous chapter had a title and an author list. Let's add these things to our template. In addition to the title, we want our template to accept a list of authors with their affiliations and the paper's abstract. To keep things readable, we'll add those as named arguments. In the end, we want it to work like this:

```
#show: doc => conf(
  title: [ A Fluid Dynamic Model for Glacier Flow ],
  authors: (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu", ),
    ( name: "Eugene Deklan", affiliation: "Honduras State",  email: "e.deklan@hstate.hn",),
  ),
  abstract: lorem(80),
  doc,
)
```

Let's build this new template function. First, we add a default value to the `title` argument. This way, we can call the template without specifying a title. We also add the named `authors` and `abstract` parameters with empty defaults. Next, we copy the code that generates title, abstract and authors from the previous chapter into the template, replacing the fixed details with the parameters.

The new `authors` parameter expects an array of dictionaries with the keys `name`, `affiliation` and `email`. Because we can have an arbitrary number of authors, we dynamically determine if we need one, two or three columns for the author list. First, we determine the number of authors using the `.len()` method on the `authors` array. Then, we set the number of columns as the minimum of this count and three, so that we never create more than three columns. If there are more than three authors, a new row will be inserted instead. For this purpose, we have also added a `row-gutter` parameter to the `grid` function. Otherwise, the rows would be too close together. To extract the details about the authors from the dictionary, we use the field access syntax.

We still have to provide an argument to the grid for each author: Here is where the array's `map` method comes in handy. It takes a function as an argument that gets called with each item of the array. We pass it a function that formats the details for each author and returns a new array containing content values. We've now got one array of values that we'd like to use as multiple arguments for the grid. We can do that by using the `spread` operator. It takes an array and applies each of its items as a separate argument to the function. 

The resulting template function looks like this:

```
#let conf( authors: (), abstract: [], doc,) = {
  // Set and show rules from before.
  ...

  place( top + center, float: true, scope: "parent", clearance: 2em,
    { 
      title()
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid( columns: (1fr,) * ncols, row-gutter: 24pt,
        ..authors.map(author => [
          #author.name \
          #author.affiliation \
          #link("mailto:" + author.email)
        ]),
      )

      par(justify: false)[
        *Abstract* \
        #abstract
      ]

    }
     )

  doc
}
```

### A separate file

Most of the time, a template is specified in a different file and then imported into the document. This way, the main file you write in is kept clutter free and your template is easily reused. Create a new text file in the file panel by clicking the plus button and name it `conf.typ`. Move the `conf` function definition inside of that new file. Now you can access it from your main file by adding an import before the show rule. Specify the path of the file between the `import` keyword and a colon, then name the function that you want to import.

Another thing that you can do to make applying templates just a bit more elegant is to use the `.with` method on functions to pre-populate all the named arguments. This way, you can avoid spelling out a closure and appending the content argument at the bottom of your template list. Templates on Typst Universe are designed to work with this style of function call. 

```
#import "conf.typ": conf

#set document(title: [ A Fluid Dynamic Model for Glacier Flow ])

#show: conf.with(
  authors: (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu", ),
    ( name: "Eugene Deklan", affiliation: "Honduras State", email: "e.deklan@hstate.hn", ),
  ),
  abstract: lorem(80),
)

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)
```

We have now converted the conference paper into a reusable template for that conference! Why not share it in the Forum or on Typst's Discord server so that others can use it too?

### The incorporation file

```
#let conf( authors: (), abstract: [], doc) = {

  place( top + center, float: true, scope: "parent", clearance: 2em,
    { 
      title()
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid( columns: (1fr,) * ncols, row-gutter: 24pt,
        ..authors.map(author => [
          #author.name \
          #author.affiliation \
          #link("mailto:" + author.email)
        ]),
      )

      par(justify: false)[
        *Abstract* \
        #abstract
      ]

    }
     )
  doc
}

#set document(title: [ A Fluid Dynamic Model for Glacier Flow ])

#show: conf.with(
  authors: (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu" ),
    ( name: "Eugene Deklan", affiliation: "Honduras State", email: "e.deklan@hstate.hn" ),
  ),
  abstract: lorem(80)
)

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)
```

### Review

Congratulations, you have completed Typst's Tutorial! In this section, you have learned how to define your own functions and how to create and apply templates that define reusable document styles. You've made it far and learned a lot. You can now use Typst to write your own documents and share them with others.

We are still a super young project and are looking for feedback. If you have any questions, suggestions or you found a bug, please let us know in the Forum, on our Discord server, on GitHub, or via the web app's feedback form (always available in the Help menu).

So what are you waiting for? Sign up and write something!


### The closure function
In programming languages like Typst (which has scripting features inspired by functional programming), a closure is essentially an anonymous function—a small, inline piece of code that acts like a function but doesn't need a full name or separate definition. It's called a "closure" because it can "close over" (or capture) variables from the surrounding code, allowing it to remember and use those values even when called later or in a different context.

Think of it like a mini-function you define on the spot. In Typst, closures are often used when you need to pass a function as an argument to something else, such as a show rule or another function. They use the syntax like `parameter => body`, where `parameter` is the input (if any), and `body` is what the closure does.

#### Why is it mentioned in the tutorial?
In the Typst tutorial you shared, the `conf` function is a template that takes named arguments like `authors` and `abstract`, plus a final positional argument `doc` (which is the main content of your document). To apply this template with a show rule, one way is to use a closure to wrap it and handle the `doc` argument explicitly. For example, without the `.with` method, you might write:

```
#show: doc => conf(
  authors: (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu", ),
    ( name: "Eugene Deklan", affiliation: "Honduras State", email: "e.deklan@hstate.hn", ),
  ),
  abstract: lorem(80),
  doc,
)
```

Here, `doc => conf(..., doc)` is the closure:
- `doc` is the parameter (it receives the document content automatically from the show rule).
- The body `conf(..., doc)` calls your template function, passing in the pre-set arguments and appending `doc` at the end.

This creates a temporary, unnamed function that adapts `conf` for the show rule. It's handy but can feel a bit verbose if you have many arguments.

#### The .with method as an alternative
The tutorial suggests using `.with` on the function to pre-fill the named arguments, which returns a new function ready to take just the `doc` argument. This avoids writing out the closure manually:

```
#show: conf.with(
  authors: (...),
  abstract: lorem(80),
)
```

Under the hood, `.with` is doing something similar to a closure—it's creating a partially applied version of the function—but it's more concise and elegant, especially for templates.

#### A simple standalone example of a closure in Typst
Suppose you want to create a function that applies bold to some text, but only if a condition is met. You could use a closure like this:

```
#let apply-style(condition, text) = {
  if condition {
    strong(text)  // Built-in bold function
  } else {text}
}

#let my-content = "Hello, Typst!"

// Using a closure to decide the condition dynamically
#let styled = apply-style(true, my-content)  // This would bold
#my-content

#styled
// Or pass a closure as an argument to another function (advanced use)
```

Closures are powerful for things like custom show rules, loops, or data transformations in Typst scripts. If you're coming from languages like JavaScript or Python, they're similar to arrow functions (`() => ...`) or lambdas (`lambda x: ...`).

If this still feels confusing or you have a specific example from your code you'd like me to break down, feel free to share!


### A revised version

Above is a snippet of Typst code. I have confirmed that it fails to render and returns the following error message: "Unexpected argument". Please help me identify the location of the bug and fix it.

I can definitely help you spot and fix that bug!
The "Unexpected argument" error is happening because of how Typst distinguishes between positional and named arguments.

The Location of the Bug
The error is being triggered on this specific line at the bottom of your configuration setup:

```
#show: conf.with( authors, abstract )
```

The Cause
In Typst, when you define a function with default values for parameters—like `authors: ()` and `abstract: []` in your `#let conf(...)` definition—those automatically become named arguments.
By writing `conf.with( authors, abstract )`, you are passing them as positional arguments. Because the `conf` function only expects *one* positional argument (`doc`), Typst gets confused when you hand it a second one (`abstract`), resulting in the "Unexpected argument" error.

The Fix
To fix this, you simply need to explicitly pass those variables as named arguments when using the `.with()` method. Change the problematic line to:

```
#show: conf.with(authors: authors, abstract: abstract)
```


```
#let conf( authors: (), abstract: [], doc) = {

  place( top + center, float: true, scope: "parent", clearance: 2em,
    { 
      title()
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid( columns: (1fr,) * ncols, row-gutter: 24pt,
        ..authors.map(au => [
          #au.name \
          #au.affiliation \
          #link("mailto:" + au.email)
        ]),
      )

      par(justify: false)[
        *Abstract* \
        #abstract
      ]
    }
     )
  doc
}

#set document(title: [ A Fluid Dynamic Model for Glacier Flow ])
  #let authors = (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu" ),
    ( name: "Eugene Deklan", affiliation: "Honduras State", email: "e.deklan@hstate.hn" ),
  )
#let abstract = lorem(80)

#show: conf.with( authors:authors, abstract:abstract )
//Incorrect version: #show: conf.with( authors, abstract )

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)
```


### The .map() method

Below is a snippet of Typst code. I am puzzled and confused by this code: "au =>" as I've never defined a variable or an argument named "au". I only defined an array called "authors". How does Typst know that "au" represent the elements of the "authors" array? Reply clearly and concisely.

```
#let conf( authors: (), abstract: [], doc) = {

  place( top + center, float: true, scope: "parent", clearance: 2em,
    { 
      title()
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid( columns: (1fr,) * ncols, row-gutter: 24pt,
        ..authors.map(au => [
          #au.name \
          #au.affiliation \
          #link("mailto:" + au.email)
        ]),
      )

      par(justify: false)[
        *Abstract* \
        #abstract
      ]
    }
     )
  doc
}

#set document(title: [ A Fluid Dynamic Model for Glacier Flow ])
  #let authors = (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu" ),
    ( name: "Eugene Deklan", affiliation: "Honduras State", email: "e.deklan@hstate.hn" ),
  )
#let abstract = lorem(80)

#show: conf.with( authors:authors, abstract:abstract )
//Incorrect version: #show: conf.with( authors, abstract )

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)
```

It is completely understandable to be puzzled by this syntax if you are new to functional programming concepts!
The short answer is: Typst doesn't inherently know what `au` means based on its name; it knows what the `.map()` function does. Here is exactly how it works:

#### 1. The `.map()` Method

The `.map()` method is a built-in function that loops through an array. When you write `authors.map(...)`, you are telling Typst: *"Take the `authors` array, look at each item inside it one by one, and do something to it."*

#### 2. Anonymous Functions (Lambdas)

The code inside the parentheses—`au => [ ... ]`—is an anonymous function. This is a quick way to create a temporary function without giving it an official name using `#let`.

* The left side (`au`) is the input parameter for this temporary function.
* The right side (`[ ... ]`) is what the function outputs.

#### 3. Putting it Together

Because you placed this function inside `.map()`, Typst automatically feeds each element of the `authors` array into that function. `au` is simply the temporary, made-up variable name chosen to represent the "current item" during the loop.

You never had to define `au` beforehand because you are defining it *right there on the spot*. You could change the code to use `x`, `person`, or anything else, and it would work exactly the same way:

```
// This works perfectly too!
..authors.map(person => [
  #person.name \
  #person.affiliation \
  #link("mailto:" + person.email)
]),

```

Would you like me to explain what the two dots (`..`) right in front of `authors.map` do in this context?


### The map function and the argument expansion operator

Below is a snippet of Typst code. I feel puzzled and confused about this code: " ..authors.map()" as I've never seen this kind of syntax before and don't understand what it mean. Please explain clearly and provide short related examples.

```
#let conf( authors: (), abstract: [], doc) = {

  place( top + center, float: true, scope: "parent", clearance: 2em,
    { 
      title()
      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid( columns: (1fr,) * ncols, row-gutter: 24pt,
        ..authors.map(au => [
          #au.name \
          #au.affiliation \
          #link("mailto:" + au.email)
        ]),
      )

      par(justify: false)[
        *Abstract* \
        #abstract
      ]
    }
     )
  doc
}

#set document(title: [ A Fluid Dynamic Model for Glacier Flow ])
  #let authors = (
    ( name: "Theresa Tungsten", affiliation: "Artos Institute", email: "tung@artos.edu" ),
    ( name: "Eugene Deklan", affiliation: "Honduras State", email: "e.deklan@hstate.hn" ),
  )
// #let abstract = lorem(80)

#show: conf.with( authors:authors, abstract: lorem(100) )
//Incorrect version: #show: conf.with( authors, abstract )

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)
```

It is completely understandable why `..authors.map()` looks confusing! It looks a bit like alien syntax if you haven't encountered it before, but it is actually just two distinct Typst features combined into a single, powerful line:
1. `.map()`: An array method that transforms data.
2. `..`: The argument expansion (or "spread") operator.
Here is a clear breakdown of exactly what each part does, complete with short examples.

#### 1. The `.map()` Method (Transforming the Data)

In Typst, `.map()` is a function you can attach to any array. It goes through the array one item at a time, applies a rule (a function) to that item, and spits out a new array with the transformed items.

In your code, `authors` is an array of dictionaries (where each dictionary holds an author's name, affiliation, and email). The `.map()` function takes each author dictionary and transforms it into a formatted text block `[ ... ]`.

Simple `.map()` Example:

```
#let numbers = (1, 2, 3)
// Multiply each number by 2
#let doubled = numbers.map(n => n * 2) 
// doubled is now an array: (2, 4, 6)
#doubled
```

#### 2. The `..` Operator (Unpacking the Data)

The `..` symbol is called the argument expansion operator (often called a "spread" operator in other programming languages like JavaScript or Python).

Functions like `grid()` in Typst expect their contents to be passed as individual, separate arguments, rather than as one big list (array). The `..` operator takes an array and "unpacks" it, dropping the parentheses and feeding the items into the function one by one.

Simple `..` Example:

```typst
#let my-blocks = ([Hello ], [World ], [Typst ])

// If you write this, the grid sees ONE argument (an array). This will cause an error or unexpected formatting.
// #grid(columns: 3, my-blocks) 

// If you write this, the `..` unpacks the array. 
// The grid sees THREE separate arguments: grid(columns: 3, [Hello], [World], [Typst])
#grid(columns: 3, ..my-blocks) 

```


```typst
#let my-blocks = ("Hello ", "World ", "Typst ")

#grid(columns: 3, ..my-blocks) 
```

#### Bringing It All Together

When we look at the line `..authors.map(...)` inside your `grid()` function, here is the exact step-by-step of what Typst is doing behind the scenes:

1. Iterate: Typst looks at your `authors` array.
2. Transform: The `.map()` function loops through Theresa and Eugene. For each one, it grabs their name, affiliation, and email, and builds a visual content block for them. Now you have an array containing two blocks: `( [Theresa's Block], [Eugene's Block] )`.
3. Unpack: The `..` sitting at the front takes that newly created array and unpacks it directly into the `grid()` function.

So, what you wrote dynamically translates to this:

```
grid(
  columns: (1fr,) * ncols, 
  row-gutter: 24pt,
  [Theresa's formatted text block], // Argument 1
  [Eugene's formatted text block]   // Argument 2
)

```

This syntax is incredibly useful because it allows your template to handle 1, 2, 3, or 10 authors seamlessly without you ever having to hard-code each author's block into the grid manually.

Would you like me to break down any other parts of this template, such as how the `columns: (1fr,) * ncols` math works to dynamically space out the authors?



























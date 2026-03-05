

# Typst Reference — Language


```typ
#set align(center)
#set text(size:4em)
#emoji.face.stars
```

## Syntax

Typst is a markup language. This means that you can use simple syntax to accomplish common layout tasks. The lightweight markup syntax is complemented by set and show rules, which let you style your document easily and automatically. All this is backed by a tightly integrated scripting language with built-in and user-defined functions.

### Modes

Typst has three syntactical modes: Markup, math, and code. Markup mode is the default in a Typst document, math mode lets you write mathematical formulas, and code mode lets you use Typst's scripting features. 

You can switch to a specific mode at any point by referring to the following table:

| New mode | Syntax                        | Example                       |
| -------- | ----------------------------- | ----------------------------- |
| Code     | Prefix the code with `#`      | `Number: #(1 + 2)`            |
| Math     | Surround equation with `$..$` | `$-x$ is the opposite of $x$` |
| Markup   | Surround markup with `[..]`   | `let name = [*Typst!*]`       |

Once you have entered code mode with `#`, you don't need to use further hashes unless you switched back to markup or math mode in between. 

### Markup

Typst provides built-in markup for the most common document elements. Most of the syntax elements are just shortcuts for a corresponding function. The table below lists all markup that is available and links to the best place to learn more about their syntax and usage.

| Name             | Example                  | See          |
| ---------------- | ------------------------ | ------------ |
| Paragraph break  | Blank line               | `parbreak`   |
| Strong emphasis  | `*strong*`               | `strong`     |
| Emphasis         | `_emphasis_`             | `emph`       |
| Raw text         | `` `print(1)` ``         | `raw`        |
| Link             | `https://typst.app/`     | `link`       |
| Label            | `<intro>`                | `label`      |
| Reference        | `@intro`                 | `ref`        |
| Heading          | `= Heading`              | `heading`    |
| Bullet list      | `- item`                 | `list`       |
| Numbered list    | `+ item`                 | `enum`       |
| Term list        | `/ Term: description`    | `terms`      |
| Math             | `$x^2$`                  | Math         |
| Line break       | `\`                      | `linebreak`  |
| Smart quote      | `'single' or "double"`   | `smartquote` |
| Symbol shorthand | `~`, `---`               | Symbols      |
| Code expression  | `#rect(width: 1cm)`      | Scripting    |
| Character escape | `Tweet at us \#ad`       | Below        |
| Comment          | `/* block */`, `// line` | Below        |

### Math mode

Math mode is a special markup mode that is used to typeset mathematical formulas. It is entered by wrapping an equation in `$` characters. This works both in markup and code. The equation will be typeset into its own block if it starts and ends with at least one space (e.g. `$ x^2 $`). Inline math can be produced by omitting the whitespace (e.g. `$x^2$`). An overview over the syntax specific to math mode follows: 

| Name                   | Example               | See         |
| ---------------------- | --------------------- | ----------- |
| Inline math            | `$x^2$`               | Math        |
| Block-level math       | `$ x^2 $`             | Math        |
| Bottom attachment      | `$x_1$`               | `attach`    |
| Top attachment         | `$x^2$`               | `attach`    |
| Fraction               | `$1 + (a+b)/5$`       | `frac`      |
| Line break             | `$x \ y$`             | `linebreak` |
| Alignment point        | `$x &= 2 \ &= 3$`     | Math        |
| Variable access        | `$#x$, $pi$`          | Math        |
| Field access           | `$arrow.r.long$`      | Scripting   |
| Implied multiplication | `$x y$`               | Math        |
| Symbol shorthand       | `$->$`, `$!=$`        | Symbols     |
| Text/string in math    | `$a "is natural"$`    | Math        |
| Math function call     | `$floor(x)$`          | Math        |
| Code expression        | `$#rect(width: 1cm)$` | Scripting   |
| Character escape       | `$x\^2$`              | Below       |
| Comment                | `$/* comment */$`     | Below       |


```typst
$f(x)=1 + (a+b)/2       "equation 1a"$ /*equation 1a*/

#let x=3.14
#let y= $floor(x)$
#y
#rect(width:1cm) 
#circle(radius:0.5cm)
#let a =2
#let b =3
#let y = a+b
a =2 \
b =3 \
y = a+b = #y \

$a x^2 + b x +c = 0 arrow.r.double x_(1,2)= (-b plus.minus sqrt(b^2 - 4 a c))/ (2 a)$ \
#let z= (y*y+y/y)
$z=y^2+y/y= #z$ \
#let f(t)= t*t+ 2*t+1
f(t)= t*t+ 2*t+1 \
$f(2)= #f(2)$ \

```


### Code mode

Within code blocks and expressions, new expressions can start without a leading `#` character. Many syntactic elements are specific to expressions. Below is a table listing all syntax that is available in code mode: 

| Name                     | Example                       | See        |
| ------------------------ | ----------------------------- | ---------- |
| None                     | `none`                        | `none`     |
| Auto                     | `auto`                        | `auto`     |
| Boolean                  | `false`, `true`               | `bool`     |
| Integer                  | `10`, `0xff`                  | `int`      |
| Floating-point number    | `3.14`, `1e5`                 | `float`    |
| Length                   | `2pt`, `3mm`, `1em`, ..       | `length`   |
| Angle                    | `90deg`, `1rad`               | `angle`    |
| Fraction                 | `2fr`                         | `fraction` |
| Ratio                    | `50%`                         | `ratio`    |
| String                   | `"hello"`                     | `str`      |
| Label                    | `<intro>`                     | `label`    |
| Math                     | `$x^2$`                       | Math       |
| Raw text                 | `` `print(1)` ``              | `raw`      |
| Variable access          | `x`                           | Scripting  |
| Code block               | `{ let x = 1; x + 2 }`        | Scripting  |
| Content block            | `[*Hello*]`                   | Scripting  |
| Parenthesized expression | `(1 + 2)`                     | Scripting  |
| Array                    | `(1, 2, 3)`                   | Array      |
| Dictionary               | `(a: "hi", b: 2)`             | Dictionary |
| Unary operator           | `-x`                          | Scripting  |
| Binary operator          | `x + y`                       | Scripting  |
| Assignment               | `x = 1`                       | Scripting  |
| Field access             | `x.y`                         | Scripting  |
| Method call              | `x.flatten()`                 | Scripting  |
| Function call            | `min(x, y)`                   | Function   |
| Argument spreading       | `min(..nums)`                 | Arguments  |
| Unnamed function         | `(x, y) => x + y`             | Function   |
| Let binding              | `let x = 1`                   | Scripting  |
| Named function           | `let f(x) = 2 * x`            | Function   |
| Set rule                 | `set text(14pt)`              | Styling    |
| Set-if rule              | `set text(..) if ..`          | Styling    |
| Show-set rule            | `show heading: set block(..)` | Styling    |
| Show rule with function  | `show raw: it => {..}`        | Styling    |
| Show-everything rule     | `show: template`              | Styling    |
| Context expression       | `context text.lang`           | Context    |
| Conditional              | `if x == 1 {..} else {..}`    | Scripting  |
| For loop                 | `for x in (1, 2, 3) {..}`     | Scripting  |
| While loop               | `while x < 10 {..}`           | Scripting  |
| Loop control flow        | `break, continue`             | Scripting  |
| Return from function     | `return x`                    | Function   |
| Include module           | `include "bar.typ"`           | Scripting  |
| Import module            | `import "bar.typ"`            | Scripting  |
| Import items from module | `import "bar.typ": a, b, c`   | Scripting  |
| Comment                  | `/* block */`, `// line`      | Below      |

### Comments

Comments are ignored by Typst and will not be included in the output. This is useful to exclude old versions or to add annotations. To comment out a single line, start it with `//`: 

```
// our data barely supports this claim

We show with $p < 0.05$ that the difference is significant.
```

Comments can also be wrapped between `/*` and `*/`. In this case, the comment can span over multiple lines:

```
Our study design is as follows:
/* Somebody write this up:
   - 1000 participants.
   - 2x2 data design. */
```

### Escape sequences

Escape sequences are used to insert special characters that are hard to type or otherwise have special meaning in Typst. To escape a character, precede it with a backslash. To insert any Unicode codepoint, you can write a hexadecimal escape sequence: `\u{1f600}`. The same kind of escape sequences also work in strings. 

```typst
#set align(center)
#set text(size:2em)
I got an ice cream for \$1.50! \u{1f600}
```

### Identifiers

Names of variables, functions, and so on (*identifiers*) can contain letters, numbers, hyphens (`-`), and underscores (`_`). They must start with a letter or an underscore. 

More specifically, the identifier syntax in Typst is based on the Unicode Standard Annex #31, with two extensions: Allowing `_` as a starting character, and allowing both `_` and `-` as continuing characters.

For multi-word identifiers, the recommended case convention is Kebab case. In Kebab case, words are written in lowercase and separated by hyphens (as in `top-edge`). This is especially relevant when developing modules and packages for others to use, as it keeps things predictable. 

```
#let kebab-case = [Using hyphen]
#let _schön = "😊"
#let 始料不及 = "😱"
#let π = calc.pi

#kebab-case \
#if -π < 0 { _schön } else { 始料不及 }
// -π means -1 * π, 
// so it's not a valid identifier
```

### Paths

Typst has various features that require a file path to reference external resources such as images, Typst files, or data files. Paths are represented as strings. There are two kinds of paths: Relative and absolute. 

- A relative path searches from the location of the Typst file where the feature is invoked. It is the default:

```
#image("logo.svg")
```

- An absolute path searches from the *root* of the project. It starts with a leading `/`: 

```
#image("/MathModel/Pictures/logo.svg")
```


Project root

By default, the project root is the parent directory of the main Typst file. For security reasons, you cannot read any files outside of the root directory.

If you want to set a specific folder as the root of your project, you can use the CLI's `--root` flag. Make sure that the main file is contained in the folder's subtree!

```
typst compile --root .. file.typ
```

In the web app, the project itself is the root directory. You can always read all files within it, no matter which one is previewed (via the eye toggle next to each Typst file in the file panel).

Paths and packages

A package can only load files from its own directory. Within it, absolute paths point to the package root, rather than the project root. For this reason, it cannot directly load files from the project directory. If a package needs resources from the project (such as a logo image), you must pass the already loaded image, e.g. as a named parameter `logo: image("mylogo.svg")`. Note that you can then still customize the image's appearance with a set rule within the package.

In the future, paths might become a distinct type from strings, so that they can retain knowledge of where they were constructed. This way, resources could be loaded from a different root. 

## Styling

Typst includes a flexible styling system that automatically applies styling of your choice to your document. With *set rules,* you can configure basic properties of elements. This way, you create most common styles. However, there might not be a built-in property for everything you wish to do. For this reason, Typst further supports *show rules* that can completely redefine the appearance of elements.

### Set rules

With set rules, you can customize the appearance of elements. They are written as a function call to an element function preceded by the `set` keyword (or `#set` in markup). Only optional parameters of that function can be provided to the set rule. Refer to each function's documentation to see which parameters are optional. In the example below, we use two set rules to change the font family and heading numbering.

```
#set heading(numbering: "I.")
#set text(font: "New Computer Modern")

= Introduction
With set rules, you can style your document.
```

A top level set rule stays in effect until the end of the file. When nested inside of a block, it is only in effect until the end of that block. With a block, you can thus restrict the effect of a rule to a particular segment of your document. Below, we use a content block to scope the list styling to one particular list.

```
This list is affected: 
#[ #set list(marker: [----]) 
- Dash ]

This one is not: 
- Bullet
```

Sometimes, you'll want to apply a set rule conditionally. For this, you can use a *set-if* rule.

```
#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}

#task(critical: true)[Food today?]
#task(critical: false)[Work deadline]
```


#### Positional argument

Below is a snippet of Typst code. I am confused by the "body" parameter in the line "#let task(body, critical: false) ". Specifically, I am unsure whether it's a variable, a positional argument or a named argument. Reply in English.
 
```
#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}
#task(critical: true)[Food today?]
#task(critical: false)[Work deadline]
```


In the context of Typst, the `body` parameter in your code snippet is both a variable and a positional argument, specifically designed to handle "content blocks."  Here is a breakdown of why it functions the way it does:

1. It is a Positional Argument

In the function definition `#let task(body, critical: false)`, `body` is the first parameter. Because it does not have a default value (unlike `critical`, which is set to `false`), it is required.

In Typst, when you call a function, arguments without names are matched to parameters based on their order.

* Regular call: `#task([My Content], critical: true)`
* Syntactic Sugar: Typst allows you to move a content block `[...]` outside the parentheses if it is the last positional argument. This is why you can write `#task(critical: true)[Food today?]`.

2. It is a Variable

Inside the function scope (the code between the curly braces `{ ... }`), `body` acts as a local variable. It holds whatever content you passed into the function. When you write `[- #body]`, you are telling Typst to: 

1. Create a list item (the `-`).
2. "Evaluate" the variable `body` (using the `#` prefix) to place its stored content there.

Argument Types Comparison

| Feature         | `body`                                 | `critical`                     |
| --------------- | -------------------------------------- | ------------------------------ |
| Category        | Positional Argument                    | Named (Optional) Argument      |
| Requirement     | Mandatory                              | Optional (defaults to `false`) |
| Trailing Syntax | Can be passed as `[ ... ]` after `( )` | Must be inside `(key: value)`  |

Why is it named "body"?

While you could technically name it anything (like `x` or `my_text`), naming the content parameter `body` is a standard convention in Typst. It signals to anyone reading the code that this function is intended to wrap or style a block of content.

Would you like me to show you how to handle multiple positional arguments or how to capture an unknown number of arguments using "rest" parameters?

#### User defined function

Regarding the Typst code snippet below. I am uncertain about the role of "task()" in the command "#let task(body, critical: false)". Could you clarify if "task()" acts as a function or something else?

```
#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}
#task(critical: true)[Food today?]
#task(critical: false)[Work deadline]
```

In Typst, `task()` acts as a function. Specifically, it is a user-defined function created using the `#let` keyword. In your snippet, you are defining how the function should behave and what parameters it should accept, then calling it later in your document.

Breakdown of the Syntax

Here is how the components of that line work:

* `#let`: This is the keyword used to declare a variable or a function. 
* `task`: This is the name of your function.
* `(body, critical: false)`: These are the parameters (arguments):
* `body`: A positional parameter. In Typst, if you put content in square brackets `[]` after a function call, it is passed as the first positional argument.
* `critical: false`: A named parameter with a default value of `false`.
* `= { ... }`: Everything inside the curly braces is the function body, which defines the logic and the output.

How it executes

When you write `#task(critical: true)[Food today?]`, the following happens:

1. The value `$true$` is assigned to `critical`.
2. The content `[Food today?]` is assigned to `body`.
3. Because `critical` is true, the `set text(red)` rule activates.
4. It returns a list item containing the body.

Comparison to Other Languages

If you are familiar with Python or JavaScript, the logic is very similar to:

Python equivalent:

```
def task(body, critical=False):
    # logic to return formatted text
    pass
```


Key Takeaway

In Typst, almost everything that performs an action or formats content is a function. By using `#let task(...) = ...`, you are simply building your own custom formatting tool to keep your document's code "DRY" (Don't Repeat Yourself).

Would you like me to show you how to add more complex logic to this function, such as adding a "CRITICAL" label automatically when the flag is true?


#### Functions or Parameters

In Typst, are elements like headings, page, text, header and footer implemented as functions? Reply in English.

In Typst, most document elements are backed by functions, which can be called directly (e.g., via markup shortcuts or explicit invocations) or configured through set rules. Here's a breakdown of the specified elements based on Typst's documentation: 

- Headings: Yes, headings are implemented as a function. The `heading` function creates heading elements, and markup like `= Title` is syntactic sugar for `#heading[Title]`. It can be styled via set rules like `#set heading(numbering: "1.")`.

- Page: Yes, page is implemented as a function. The `page` function is used in set rules to configure page properties (e.g., `#set page(paper: "a4")`) or to explicitly render content onto pages (e.g., `#page[Content]` for a page break).

- Text: Yes, text is implemented as a function. The `text` function styles and places text content (e.g., `#text(size: 12pt)[Hello]`), and it's commonly used in set rules like `#set text(font: "Arial")` to apply global text properties.

- Header and footer: No, headers and footers are not implemented as standalone functions. Instead, they are parameters (arguments) of the `page` function, set via rules like `#set page(header: [Header content], footer: align(center)[Page #counter(page).display()])`. They define content that appears in the top and bottom margins of pages, but they are not elements or functions themselves.

### Show rules

With show rules, you can deeply customize the look of a type of element. The most basic form of show rule is a *show-set rule.* Such a rule is written as the `show` keyword followed by a selector, a colon and then a set rule. The most basic form of selector is an element function. This lets the set rule only apply to the selected element. In the example below, headings become dark blue while all other text stays black.

```
#show heading: set text(navy)

= This is navy-blue
But this stays black.
```

With show-set rules you can mix and match properties from different functions to achieve many different effects. But they still limit you to what is predefined in Typst. For maximum flexibility, you can instead write a *transformational* show rule that defines how to format an element from scratch. To write such a show rule, replace the set rule after the colon with an arbitrary function. This function receives the element in question and can return arbitrary content. The function is often defined inline as `it => ..` using the unnamed function syntax. The function's parameter is typically named `it` by convention.

The available fields on the element passed to the function must? match the parameters of the respective element function. Below, we define a show rule that formats headings for a fantasy encyclopedia.

The show rule itself adds tilde characters around the title (these must be escaped with a backslash because otherwise they would indicate a non-breaking space), emphasizes the title with italics, and then displays the heading counter after the title.

For this example, we also wanted center alignment and a different font. While we could've added these set rules into the existing show rule, we instead added them as separate show-set rules. This is good practice because now these rules can still be overridden by later show-set rules in the document, keeping styling composable. In contrast, set rules within a *transformational show rule* ? would not be overridable anymore.

```
#set heading(numbering: "(I)")
#show heading: set align(left)
#show heading: set text(font: "Inria Serif")

// Below is a transformational show rule
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

Like set rules, show rules are in effect until the end of the current block or file.

Instead of a function, the right-hand side of a show rule can also take a literal string or content block that should be directly substituted for the element. And apart from a function, the left-hand side of a show rule can also take a number of other *selectors* that define what to apply the transformation to:

- Everything: `show: rest => ..`
  Transform everything after the show rule. This is useful to apply a more complex layout to your whole document without wrapping everything in a giant function call.
- Text: `show "Text": ..`
  Style, transform or replace text.
- Regex: `show regex("\w+"): ..`
  Select and transform text with a regular expression for even more flexibility. See the documentation of the `regex` type for details.
- Function with fields: `show heading.where(level: 1): ..`
  Transform only elements that have the specified fields. For example, you might want to only change the style of level-1 headings.
- Label: `show <intro>: ..` 
  Select and transform elements that have the specified label. See the documentation of the `label` type for more details.


```typst
#set text(size:1.2em)
#show "Project": set text(size:1.5em)
#show "Project": it => smallcaps(it)
#show "badly": "great"

#show heading.where(level:1) : {it => "Chapter 1: "+it.body + "...forever"}
We started Project in 2019 and are still working on it. Project is progressing badly. \
//#show: rest => "000000000000000000000000000000000000000000"

= testing

== learning
```


#### syntax of counter 

Regarding the Typst code snippet below. Could you introduce and explain the syntax logic or structure of "#counter(heading).display(it.numbering)" as I've never seen commands like this and I have no idea about what it mean.
 
```
#set heading(numbering: "(I)")
#show heading: set align(left)
#show heading: set text(font: "Inria Serif")
// Below is a transformational show rule
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

Great question! The line looks a bit magical at first, but once you understand the pieces, it becomes very logical. Let's break it down step by step.

```
#counter(heading).display(it.numbering)
```

1. What is `#counter(heading)`?

Typst maintains counters for many built-in elements that need numbering:

- `counter(page)` → page numbers
- `counter(heading)` → section / heading numbers
- `counter(figure)` → figures, tables, etc.
- `counter(equation)` → equations
- …

`counter(heading)` is the object that keeps track of how many headings of each level have appeared so far.

It is a counter object with several methods, most importantly:

- `.get()` → returns the raw array of numbers `[1, 2, 3]` etc.
- `.step()` → increases the counter
- `.display()` → the most commonly used method: turns the current counter value into nice formatted content (like "3.2.1" or "III.4" or whatever style you want)

2. What does `.display()` do?

`.display()` has two main modes:

```
counter(heading).display()               // ← uses the currently set numbering style
counter(heading).display("1.1.1")        // ← forces this specific pattern
counter(heading).display(it.numbering)   // ← uses whatever pattern "it" carries
```

When you write

```
#set heading(numbering: "(I)")
```

you are telling Typst:   "Whenever someone asks for heading numbering, please format it using the Roman numeral style `(I)`" That style string `(I)` gets attached to every heading element as `it.numbering`. 

3. What is `it` here?

Because you wrote

```
#show heading: it => block[ … ]
```

Typst calls your function once for every heading and passes the original heading as the parameter `it`.

`it` is a full heading element that contains (among others):

- `it.body`        → the text ("Dragon", "Manticore", …)
- `it.level`       → 1, 2, 3, …
- `it.numbering`   → the numbering pattern that was active when this heading was created  (in your case: `"(I)"`)

So `it.numbering` = `"(I)"` 

4. Putting it together

```
#counter(heading).display(it.numbering)
```

means: Take the current value of the heading counter,  and format it using exactly the same numbering pattern that this particular heading is supposed to use.

In your document:

```typst
//#set heading(numbering: "(I)")
#set heading(numbering: "1.1.")
= Dragon
← it.numbering = "(I)"
```

→ Typst has already incremented the counter to 1  
→ `.display("(I)")` → I

Next heading:
→ counter is now 2  
→ `.display("(I)")` → II

This is very powerful because:

- You can change `#set heading(numbering: "1.")` later in the document
- Different parts of the document can use different styles
- Your custom show rule still respects whatever numbering style is currently active

Summary – what each part really means

| Expression                                | Meaning                                                                           |
| ----------------------------------------- | --------------------------------------------------------------------------------- |
| `counter(heading)`                        | The object that tracks section numbering                                          |
| `.display(…)`                             | "Turn the current numbers into formatted text"                                    |
| `it`                                      | The original heading Typst is currently processing                                |
| `it.numbering`                            | The numbering pattern string (or function) that belongs to this heading           |
| `#counter(heading).display(it.numbering)` | "Show me the current section number, styled exactly the way this heading expects" |

So in your example you get nice Roman numerals after the title — and if you later change to `#set heading(numbering: "1.1.")` everything still works without touching the show rule.

Hope this clears up the mystery! 😄  
Let me know if you'd like to see variations (e.g. number before the title, two-line layout, etc.).


## Scripting

Typst embeds a powerful scripting language. You can automate your documents and create more sophisticated styles with code. Below is an overview over the scripting concepts. 

### Expressions

In Typst, markup and code are fused into one. All but the most common elements are created with *functions.* To make this as convenient as possible, Typst provides compact syntax to embed a code expression into markup: An expression is introduced with a hash (`#`) and normal markup parsing resumes after the expression is finished. If a character would continue the expression but should be interpreted as text, the expression can  be forcibly ended with a semicolon (`;`). You can escape a literal `#` or `;` with a backslash. 

```typs
#emph[Hello] \
#emph([Hello again]) \ 
#emph("Hello again") \
#let hello=[Hello again]
#emph(hello) \ //emph() is a function and must accept a positional argument. #emph expects a single content argument (the text to emphasize). Typst is strict about argument types: content blocks [] or strings "" are safe for text, but bare words without them are interpreted as variables or code expressions.
#emoji.face \  // field accesses
#"hello".len() \  //method calls
```

The example above shows a few of the available expressions, including function calls, field accesses, and method calls. More kinds of expressions are discussed in the remainder of this chapter. A few kinds of expressions are not compatible with the hash syntax (e.g. binary operator expressions). To embed these into markup, you can use parentheses, as in `#(1 + 2)`. 

### Blocks

To structure your code and embed markup into it, Typst provides two kinds of *blocks:* 

- Code block: `{ let x = 1; x + 2 }`
  When writing code, you'll probably want to split up your computation into multiple statements, create some intermediate variables and so on. Code blocks let you write multiple expressions where one is expected. The individual expressions in a code block should be separated by line breaks or semicolons. The output values of the individual expressions in a code block are joined to determine the block's value. Expressions without useful output, like `let` bindings yield `none`, which can be joined with any value without effect.

- Content block: `[*Hey* there!]`
  With content blocks, you can handle markup/content as a programmatic value, store it in variables and pass it to functions. Content blocks are delimited by square brackets and can contain arbitrary markup. A content block results in a value of type `content`. An arbitrary number of content blocks can be passed as trailing arguments to functions. That is, `list([A], [B])` is equivalent to `list[A][B]`. 

Content and code blocks can be nested arbitrarily. In the example below, `[hello ]` is joined with the output of `a + [ the ] + b` yielding `[hello from the *world*]`.

```
#{
  let a = [from]
  let b = [*world*] 
  [hello ]
  a + [ the ] + b 
}
```



### Difference between code block and content block

What's the difference between code block and content block in Typst.^Difference between code blocks and content blocks
Introduce and explain clearly in English.

In Typst, code block and content block are two different kinds of *blocks* used to embed logic or rich markup inside expressions. They serve very different purposes.

Quick Comparison

| Feature              | Code block                                                        | Content block                                            |
| -------------------- | ----------------------------------------------------------------- | -------------------------------------------------------- |
| Delimiters           | Curly braces `{ … }`                                              | Square brackets `[ … ]`                                  |
| Syntax mode inside   | Code mode                                                         | Markup mode (normal Typst markup)                        |
| What it evaluates to | Usually some value (number, string, array, function result, etc.) | Always a value of type `content`                         |
| Needs `#` prefix?    | No — inside `{}` you write code directly                          | Yes for code — e.g. `#text(red)[…]`                      |
| Main purpose         | Computation, logic, variables, loops, conditionals                | Capturing formatted text / rich content as a value       |
| Typical usage        | Calculations, defining variables/functions, control flow          | Passing rich body to functions, storing styled fragments |
| Example              | `{ let x = 3; x + 2 }` → `5`                                      | `[*Hello* there!]` → formatted content                   |


```typst
*Content and code blocks can be nested arbitrarily. * \ 
markup mode and code mode determins the results. \ 
\# sign before a content block means acessing the content block and produce the value of the content block \ 
\# sign before a code block means switching to code mode. \ 

a {let x=3; x+2;}

b #{let x=3; x+2;}

c [#let x=3; x+2;]

d [#let x=3; x= #x+ 1;]

e #[#let x=3; x= #x+ 1;]

f #{let x=3; x = x+ 1; x}

g #[#let x=3; {x= #x+ 1;}]

h [#let x=3; #{x= x+ 1; x}]

I #{let x=3; x = x+ 1; [x]} ???

J #{let x=3; x = x+ 1; [#x]} ???

K #[#let x=3; #{x= x+ 1; x}]
```

In Typst, the # symbol is the escape character that switches from markup mode (normal text + formatting like italics, bold, headings, etc.) into code mode. Putting # immediately before a content block or code block has slightly different but related meanings depending on what follows it. 

The # before a content block
tells Typst: “Please evaluate the following thing as code, and insert the result into the document.” 
In this case the thing that follows is a content block […], so Typst : creates a content value from the markup inside the [ ] ; treats it as the return value of that little code expression ; places that content into the document flow. 

The # before a code block { … }
means: “switch to code mode and evaluate this as code”.




```
#{
  let x = 1
  let y = 2 // Separated by newline
  x + y; x - y // Separated by semicolon on one line
}
```



Code Block `{ … }`

This is Typst's way to write real programming code.

- Runs in code mode
- You can write multiple statements (separated by line breaks or `;`)
- The value of the block is the joined result of all expressions inside
- Very commonly used after `#` to embed logic directly in markup

```
// Simple computation
The result is #( { let x = 12; x * 2 } ).

// With variables and logic
#{
  let name = "Alice"
  let age = 25
  if age >= 18 { [Adult: ] } else { [Minor: ] }
  strong(name)
}
```

→ Produces:  
The result is 24.  
Adult: Alice

Content Block `[ … ]`

This captures Typst markup (the same syntax you normally write in the document) and turns it into a single `content` value.

- Runs in markup mode (headings, lists, *emphasis*, tables, images, etc. all work)
- Almost always used to pass rich content to functions (especially your own)
- You need `#` to embed code inside it

```
#let alert(body) = {
  block(
    fill: orange.lighten(10%),
    inset: 20pt,
    radius: 10pt,
  )[
     #strong[Attention!] \
     #body
   ]
}

#alert[
  *Do not* touch the button! \
  #lorem(20)
]
```

→ Produces a nice red warning box containing formatted text + dummy text.


Summary – When to use which

- Want to compute something or run logic → use code block `{ … }`
- Want to capture formatted / rich markup as a value (to store, pass to function, reuse, etc.) → use content block `[ … ]`

Most real documents use both frequently:

```typst
#let name = "World"

The answer is #{ let x = 40 ; x + 2 ;}

#box(stroke: blue + 2pt, radius:10pt, inset: 20pt)[
  *Hello #name!* \
  You have #text(red)[important] message.
]
```

Hope this clears up the difference! 😄


### Bindings and Destructuring

As already demonstrated above, variables can be defined with `let` bindings. The variable is assigned the value of the expression that follows the `=` sign. A valid variable name may contain `-`, but cannot start with `-`. The assignment of a value is optional, if no value is assigned, the variable will be initialized as `none`. The `let` keyword can also be used to create a custom named function. Variables can be accessed for the rest of the containing block (or the rest of the file if there is no containing block).

```
#let name = "Typst"
This is #name's documentation.
It explains #name.

#let my-ass(x, y) = x + y
Sum is #my-ass(2, 3).
```

Let bindings can also be used to destructure arrays and dictionaries. In this case, the left-hand side of the assignment should mirror an array or dictionary. The `..` operator can be used once in the pattern to collect the remainder of the array's or dictionary's items.

```
#let (x, y) = (1, 2)
The coordinates are #x, #y.

#let (a, .., b) = (1, 2, 3, 4)
The first element is #a.
The last element is #b.

#let books = (Shakespeare: "Hamlet", Homer: "The Odyssey", Austen: "Persuasion")

#let (Austen,) = books  
Austen wrote #Austen.

#let (Homer: h) = books
Homer wrote #h.

#let (Homer, ..other) = books
#for (author, title) in other [
  #author wrote #title.
]
```

Above is a snippet of Typst code. I am puzzled and confused by the code as I have never seen similar syntax before. Could you please analyse it and provide clear and detailed explanation for me? Reply in English.

#### destructuring assignment

Typst is a modern typesetting system designed for creating beautifully formatted documents, similar to LaTeX but with a more concise and intuitive syntax. It supports scripting-like features, including variables, loops, and data structures like arrays and dictionaries. The code snippet you provided demonstrates advanced variable assignment techniques using destructuring (also called pattern matching), which allows unpacking values from arrays or dictionaries into variables in a flexible way. This syntax is inspired by languages like Rust or Python, but adapted for Typst's markup and scripting environment. 

I'll break down the code step by step, explaining each section, what it does, and why it works. I'll also describe the output it would produce when rendered in a Typst document.

1. Basic Tuple Destructuring

```
#let (x, y) = (1, 2)
The coordinates are #x, #y.
```

- `#let (x, y) = (1, 2)`: This uses destructuring to assign values from a tuple (an ordered collection, like an array) on the right to variables on the left.
  - The right side `(1, 2)` is a tuple with two elements.
  - The left side `(x, y)` is a pattern that matches the structure: it binds the first element (1) to `x` and the second (2) to `y`.
  - If the tuple had more or fewer elements, this would cause an error, as the patterns must match exactly.
- `The coordinates are #x, #y.`: This is markup text. The `#` prefix inserts the values of variables `x` and `y` inline.
- Rendered Output: "The coordinates are 1, 2."
- Why this syntax? It's a concise way to extract multiple values at once, avoiding separate assignments like `#let x = 1; #let y = 2;`. 

2. Destructuring with Ignore Pattern (`..`)

```
#let (a, .., b) = (1, 2, 3, 4)
The first element is #a.
The last element is #b.
```

- `#let (a, .., b) = (1, 2, 3, 4)`: Another tuple destructuring, but with a "rest" or "ignore" pattern.
  - The right side is a tuple `(1, 2, 3, 4)` with four elements.
  - The left side `(a, .., b)`:
    - Binds the first element (1) to `a`.
    - `..` ignores the middle elements (2 and 3); it acts as a wildcard to skip any number of items.
    - Binds the last element (4) to `b`.
  - This is flexible for tuples of varying lengths, as long as there's at least a first and last element.
- `The first element is #a.` and `The last element is #b.`: Inserts the values inline.
- Rendered Output:
  - "The first element is 1."
  - "The last element is 4."
- Why this syntax? It's useful when you only care about specific positions (e.g., head and tail) and want to discard the rest without naming every variable.

3. Defining a Dictionary

```
#let books = (Shakespeare: "Hamlet", Homer: "The Odyssey", Austen: "Persuasion")
```

- `#let books = ...`: Assigns a dictionary (a key-value map) to the variable `books`.
  - Dictionaries in Typst use the syntax `(key1: value1, key2: value2, ...)`.
  - Keys here are strings ("Shakespeare", "Homer", "Austen"), and values are also strings (book titles).
  - This is like a hash map or object in other languages.
- No output here; this just defines `books` for later use.
- Why dictionaries? They allow associating data by meaningful keys instead of numeric indices, making code more readable.

4. Destructuring a Single Key from a Dictionary

```
#let (Austen,) = books
Austen wrote #Austen.
```

- `#let (Austen,) = books`: Dictionary destructuring to extract a specific value.
  - The left side `(Austen,)` is a pattern matching a single key. The trailing comma indicates it's a tuple-like pattern (even for one item).
  - It looks for the key "Austen" in `books` and binds its value ("Persuasion") to a new variable also named `Austen`.
  - Note: The variable name `Austen` is the same as the key, but they are distinct—Typst binds the *value* to the variable.
  - If the key didn't exist, this would error.
- `Austen wrote #Austen.`: Inserts the variable's value.
- Rendered Output: "Austen wrote Persuasion."
- Why this syntax? It extracts just one entry without needing to access the whole dictionary later (e.g., via `books.at("Austen")`). The variable name reusing the key name is a shorthand for clarity. 

```
#let books = (Shakespeare: "Hamlet", Austen: "Persuasion", Homer: "Iliad")

// All Three lines below do exactly the same thing:
#let a = books.Austen
#let a = books.at("Austen")
#let (Austen,) = books    // ← what you saw
```


| Pattern                    | Meaning                            | Common usage case                                |
| -------------------------- | ---------------------------------- | ------------------------------------------------ |
| `#let x = dict`            | normal assignment                  | you want the whole dictionary                    |
| `#let x = dict.key`        | field access                       | you want one specific value                      |
| `#let (key1, key2) = dict` | destructuring several named fields | you want multiple specific values at once        |
| `#let (key,) = dict`       | destructuring just one named field | you want one value but using destructuring style |


5. Destructuring with Renaming

```
#let (Homer: h) = books
Homer wrote #h.
```

- `#let (Homer: h) = books`: More advanced dictionary destructuring.
  - The pattern `(Homer: h)` specifies the key "Homer" and binds its value to a variable `h` (renaming it).
  - This extracts only the "Homer" entry's value ("The Odyssey") into `h`.
  - Like before, it's a single-entry pattern, but with explicit renaming using `key: var`.
- `Homer wrote #h.`: Inserts `h`'s value.
- Rendered Output: "Homer wrote The Odyssey."
- Why this syntax? Renaming is helpful when the key name isn't ideal as a variable (e.g., too long or conflicts), or to avoid overwriting existing variables. 

6. Destructuring with Rest Pattern in a Dictionary

```
#let (Homer, ..other) = books
#for (author, title) in other [
  #author wrote #title.
]
```

- `#let (Homer, ..other) = books`: Dictionary destructuring with a rest pattern.
  - The pattern `(Homer, ..other)`:
    - Extracts the "Homer" entry's *value* ("The Odyssey") into a variable `Homer` (similar to section 4, no renaming).
    - `..other` captures the remaining key-value pairs into a new dictionary `other`.
  - After this, `other` would be `(Shakespeare: "Hamlet", Austen: "Persuasion")` (order may not be preserved, as dictionaries are unordered). 
  - Note: Without `:`, `Homer` binds the value directly to a variable named `Homer`.
- `#for (author, title) in other [ ... ]`: A loop over the dictionary `other`.
  - `for ... in ...` iterates over the dictionary's entries.
  - For each entry, it destructures into `(author, title)`, where `author` gets the key (string) and `title` gets the value.
  - Inside the loop body (in square brackets, which denotes content block), it outputs markup: `#author wrote #title.`
- Rendered Output (assuming iteration order):
  - "Shakespeare wrote Hamlet."
  - "Austen wrote Persuasion."
- Why this syntax? It combines extraction of specific items with handling the rest, enabling loops or further processing on subsets. The `..` rest pattern is powerful for partial matching.

Overall Notes 

- Destructuring in Typst: This feature allows patterns on the left of `#let` to match structures (tuples/arrays or dictionaries) on the right. It's strict: mismatches cause errors. Patterns can include literals, variables, ignores (`..`), and renames (`key: var`). For dictionaries, keys must match exactly.
- Why this might seem unfamiliar: If you're coming from LaTeX or basic scripting, Typst's functional programming influences (e.g., from Rust) introduce these concise patterns. They're not common in traditional typesetting but make code cleaner for complex documents.
- Rendering: In a full Typst file, this would compile to a PDF with the text outputs as paragraphs. No visual elements like bolding are added here, but you could style them further.
- Potential Errors: If keys are missing or structures don't match, Typst would raise a compile-time error, helping catch issues early.

You can use the underscore to discard elements in a destructuring pattern:

```
#let (_, y, _) = (1, 2, 3)
The y coordinate is #y.
```

Destructuring also works in argument lists of functions ...

```
#let left = (2, 4, 5)
#let right = (3, 2, 6)
#left.zip(right).map(
  ((a,b)) => a + b
)
```

... and on the left-hand side of normal assignments. This can be useful to swap variables among other things.

```
#{
  let a = 1
  let b = 2
  (a, b) = (b, a)
  [a = #a, b = #b]
}
```



### Conditionals

With a conditional, you can display or compute different things depending on whether some condition is fulfilled. Typst supports `if`, `else if` and `else` expressions. When the condition evaluates to `true`, the conditional yields the value resulting from the if's body, otherwise yields the value resulting from the else's body. 

```typst
#if 1 > 2 [This is True] else [This is false]
```

Each branch can have a code or content block as its body.

- `if condition {..}` 
- `if condition [..]` 
- `if condition [..] else {..}` 
- `if condition [..] else if condition {..} else [..]` 


### Loops

With loops, you can repeat content or compute something iteratively. Typst supports two types of loops: `for` and `while` loops. The former iterate over a specified collection whereas the latter iterate as long as a condition stays fulfilled. Just like blocks, loops *join* the results from each iteration into one value. 

In the example below, the three sentences created by the for loop join together into a single content value and the length-1 arrays in the while loop join together into one larger array.

```typst
#for c in "ABC" [ #c is a letter. ]

#let n = 2
#while n < 10 { n = (n * 2) - 1 ; (n,) ;}
```

For loops can iterate over a variety of collections:

- `for value in array {..}` — Iterates over the items in the array. The destructuring syntax described in Let binding can also be used here.
- `for pair in dict {..}` — Iterates over the key-value pairs of the dictionary. The pairs can also be destructured by using `for (key, value) in dict {..}`. It is more efficient than `for pair in dict.pairs() {..}` because it doesn't create a temporary array of all key-value pairs.
- `for letter in "abc" {..}` — Iterates over the characters of the string. Technically, it iterates over the grapheme clusters of the string. Most of the time, a grapheme cluster is just a single codepoint. However, a grapheme cluster could contain multiple codepoints, like a flag emoji.
- `for byte in bytes("😀") {..}` — Iterates over the bytes, which can be converted from a string or read from a file without encoding. Each byte value is an integer between `0` and `255`.

To control the execution of the loop, Typst provides the `break` and `continue` statements. The former performs an early exit from the loop while the latter skips ahead to the next iteration of the loop.

```
#for letter in "abc nope" { if letter == " " { break } else {letter} }
```

The body of a loop can be a code or content block:

- `for .. in collection {..}`
- `for .. in collection [..]`
- `while condition {..}`
- `while condition [..]`


### Collect values from a loop

Below is a Typst code snippet. I am confused by the syntax of " (n,) " as I've never seen similar syntax before. Please analyse the code and provide a clear explanation for me. Additionally, I would appreciate seeing equivalent ways to write this logic.
 
```
#let n = 2
#while n < 10 { n = (n * 2) - 1 ; (n,) ;}
```

The `(n,)` syntax is Typst's way to create a single-element array (also called a 1-tuple).

- `(expr)` → just a parenthesized expression (e.g. `(n * 2) - 1` groups the calculation).
- `(expr,)` → an array with one item. The trailing comma is mandatory for length-1 arrays; Typst requires it to distinguish from a plain grouped expression.

This is exactly the same rule as in the official Typst array documentation:  
A single-element array must be written as `(1,)` (not `(1)`).

What the whole snippet actually does

```typs
#let n = 2
#while n < 10 {
  n = (n * 2) - 1 ;
  (n,) ;
}
```

1. Start: `$n = 2$` 
2. Loop condition `$n < 10$` is true → enter body
3. Update: `$n = (n times 2) - 1$`  
   → `$n = 3$` 
4. Last expression of the block: `(3,)` → produces the 1-element array `[3]` 
5. Loop repeats while `$n < 10$` 

The iterations produce these arrays:

- Iteration 1: `(3,)` 
- Iteration 2: `(5,)` 
- Iteration 3: `(9,)` 
- Iteration 4: `(17,)` 

Typst loops automatically join the result of every iteration:

- Arrays are concatenated. 
- So four length-1 arrays become one length-4 array: `(3, 5, 9, 17)` 

The `#while` expression therefore evaluates to exactly that array, which Typst displays as `[3, 5, 9, 17]` in the document.

Note about the semicolons in your version:  
In a code block `{ stmt1; stmt2; }` the value of the block is the value of the *last* expression. A trailing `;` after `(n,)` makes the block end with an empty statement, so each iteration technically returns `none`. In practice the official docs write it without the final `;` (or on a separate line) to make `(n,)` the actual return value. Your code still runs, but the cleanest form is the one from the Typst reference:

```typs
#while n < 10 {
  n = (n * 2) - 1
  (n,)
}
```

Equivalent ways to write the same logic

1. Most idiomatic (exactly what you saw)  
Uses the built-in loop-joining behaviour:

```typs
#let n = 2
#while n < 10 {
  n = (n * 2) - 1
  (n,)
}
```

2. Explicit mutable array (very readable)

```
#let n = 2 ;
#let seq = () ;
#while n < 10 { n = (n * 2) - 1 ; seq.push(n) ;}
seq= #seq   // → (3, 5, 9, 17)
```

3. As content (prints the numbers with spaces)

```typst
#let n = 2
#while n < 10 {
  n = (n * 2) - 1
  [#n ]  // or just `#n ` if you prefer
}
```

4. One-liner version (if you like golf)

```typs
#let n = 2
#while n < 10 { n = (n*2)-1 ; (n,) }
```

All four produce the same final array (or the same visual output). The `(n,)` trick is simply the shortest and most "Typst-native" way to collect values from a loop without manually managing a list.

### Fields

You can use *dot notation* to access fields on a value. For values of type `content`, you can also use the `fields` function to list the fields. 

The value in question can be either:

- a dictionary that has the specified key,
- a symbol that has the specified modifier,
- a module containing the specified definition,
- content consisting of an element that has the specified field. The available fields match the arguments of the element function that were given when the element was constructed.

```
#let it = [= Heading]
#it.body \
#it.depth \
#it.fields() \

#let dict = (greet: "Hello")
#dict.greet \
#emoji.face
```


### Methods

A *method call* is a convenient way to call a function. The function is scoped to a value's type. For example, we can call the `str.len` function in the following two equivalent ways:

```
#str.len("abc") is the same as
#"abc".len()
```

The structure of a method call is `value.method(..args)` and its equivalent full function call is `type(value).method(value, ..args)`. The documentation of each type lists its scoped functions. You cannot currently define your own methods.

```
#let values = (1, 2, 3, 4)
#values.pop() \
#values.len() \

#("a, b, c"
    .split(", ")
    .join[ --- ])

#"abc".len() is the same as
#str.len("abc")
```

There are a few special functions that modify the value they are called on (e.g. `array.push`). These functions *must* be called in method form. In some cases, when the method is only called for its side effect, its return value should be ignored (and not participate in joining). The canonical way to discard a value is with a let binding: `let _ = array.remove(1)`.


### Packages

To reuse building blocks across projects, you can also create and import Typst *packages.* A package import is specified as a triple of a namespace, a name, and a version.

```
#import "@preview/example:0.1.0": add
#add(2, 7)
```

The `preview` namespace contains packages shared by the community. You can find all available community packages on Typst Universe.

If you are using Typst locally, you can also create your own system-local packages. For more details on this, see the package repository.

### Modules

You can split up your Typst projects into multiple files called *modules.* A module can refer to the content and definitions of another module in multiple ways:

- Including: `include "bar.typ"` — Evaluates the file at the path `bar.typ` and returns the resulting content.
- Import: `import "bar.typ"` — Evaluates the file at the path `bar.typ` and inserts the resulting module into the current scope as `bar` (filename without extension). You can use the `as` keyword to rename the imported module: `import "bar.typ" as baz`. You can import nested items using dot notation: `import "bar.typ": baz.a`.
- Import items: `import "bar.typ": a, b` — Evaluates the file at the path `bar.typ`, extracts the values of the variables `a` and `b` (that need to be defined in `bar.typ`, e.g. through `let` bindings) and defines them in the current file. Replacing `a, b` with `*` loads all variables defined in a module. You can use the `as` keyword to rename the individual items: `import "bar.typ": a as one, b as two` 

```
#import "@preview/cetz:0.4.2"  // import package

#cetz.canvas({
  import cetz.draw: *  // import "draw" module and loads all variables defined in the module?
})
```

Instead of a path, you can also use a module value, as shown in the following example: 

```
#import emoji: face
#face.grin
```


### Operators

The following table lists all available unary and binary operators with effect, arity (unary, binary) and precedence level (higher binds stronger). Some operations, such as modulus, do not have a special syntax and can be achieved using functions from the `calc` module.

| Operator | Effect                          | Arity  | Precedence |
| -------- | ------------------------------- | ------ | ---------- |
| `-`      | Negation                        | Unary  | 7          |
| `+`      | No effect (exists for symmetry) | Unary  | 7          |
| `*`      | Multiplication                  | Binary | 6          |
| `/`      | Division                        | Binary | 6          |
| `+`      | Addition                        | Binary | 5          |
| `-`      | Subtraction                     | Binary | 5          |
| `==`     | Check equality                  | Binary | 4          |
| `!=`     | Check inequality                | Binary | 4          |
| `<`      | Check less-than                 | Binary | 4          |
| `<=`     | Check less-than or equal        | Binary | 4          |
| `>`      | Check greater-than              | Binary | 4          |
| `>=`     | Check greater-than or equal     | Binary | 4          |
| `in`     | Check if in collection          | Binary | 4          |
| `not in` | Check if not in collection      | Binary | 4          |
| `not`    | Logical "not"                   | Unary  | 3          |
| `and`    | Short-circuiting logical "and"  | Binary | 3          |
| `or`     | Short-circuiting logical "or"   | Binary | 2          |
| `=`      | Assignment                      | Binary | 1          |
| `+=`     | Add-Assignment                  | Binary | 1          |
| `-=`     | Subtraction-Assignment          | Binary | 1          |
| `*=`     | Multiplication-Assignment       | Binary | 1          |
| `/=`     | Division-Assignment             | Binary | 1          |

## Import CeTZ

The following is a typst code snippet. I am unfamiliar with its syntax and unsure of its function. Please provide a detailed explanation and include comments inside the snippet. Reply in English.
 
```
#import "@preview/cetz:0.4.2"
#cetz.canvas({
  import cetz.draw: *
})
```

This Typst code snippet is the minimal boilerplate required to start creating vector drawings (diagrams, plots, geometric shapes, arrows, etc.) using the very popular CeTZ package.

CeTZ (short for "CeTZ, ein Typst Zeichenpaket" – German for "a Typst drawing package") is a powerful drawing library for Typst. Its syntax is heavily inspired by TikZ (from LaTeX) and Processing/p5.js. 

Here is your original snippet with added comments explaining every part:

```
// Import version 0.4.2 of the CeTZ package from the Typst preview (package) repository.
// The "@preview/" prefix tells Typst to fetch the package from the official preview registry.
// You can also use a locally installed version like "@local/cetz:0.4.2" if you have it installed.

#import "@preview/cetz:0.4.2"

// Create a drawing canvas (the actual drawing area).
// Everything drawn inside this block becomes part of one vector graphic.
// CeTZ automatically calculates the bounding box → no manual sizing needed in most cases.

#cetz.canvas({

  // Import all drawing commands (functions) from the cetz.draw module with `*` (wildcard import).
  // This is the strongly recommended pattern in CeTZ.
  // After this line you can write short names like:
  //   line((0,0), (2,1))    instead of    cetz.draw.line(...)
  //   circle((3,2), radius: 1)    instead of    cetz.draw.circle(...)   etc.
  
  import cetz.draw: *
  
  // From here you write your actual drawing commands.
})
```


Very minimal complete example 

```typst
#import "@preview/cetz:0.4.2"

#cetz.canvas({
  import cetz.draw: *

  // Draw a red triangle + a blue circle + some text
  stroke(red + 1.4pt)
  fill(blue.transparentize(80%))
  line((0,0), (4,0), (2,3), close: true)

  fill(none)
  stroke(blue + 2pt)
  circle((2,1), radius: 1.2)

  content((2,3.5), text(14pt, weight: "bold", fill: eastern)[Hello CeTZ!])
})
```

This should produce a small graphic with a red triangle, a translucent blue circle, and text on top.

Let me know if you'd like to see how to draw something specific (coordinate systems, function plots, trees, Feynman diagrams, 3D projections, etc.) — CeTZ can do quite a lot once you get past this initial setup!


## Context

Sometimes, we want to create content that reacts to its location in the document. This could be a localized phrase that depends on the configured text language or something as simple as a heading number which prints the right value based on how many headings came before it. However, Typst code isn't directly aware of its location in the document. Some code at the beginning of the source text could yield content that ends up at the back of the document.

To produce content that is reactive to its surroundings, we must thus specifically instruct Typst: We do this with the `context` keyword, which precedes an expression and ensures that it is computed with knowledge of its environment. In return, the context expression itself ends up opaque. We cannot directly access whatever results from it in our code, precisely because it is contextual: There is no one correct result, there may be multiple results in different places of the document. For this reason, everything that depends on the contextual data must happen inside of the context expression.

Aside from explicit context expressions, context is also established implicitly in some places that are also aware of their location in the document: Show rules provide context and numberings in the outline, for instance, also provide the proper context to resolve counters.

### Style context

With set rules, we can adjust style properties for parts or the whole of our document. We cannot access these without a known context, as they may change throughout the course of the document. When context is available, we can retrieve them simply by accessing them as fields on the respective element function.

```
#set text(lang: "de")
#context text.lang
```

As explained above, a context expression is reactive to the different environments it is placed into. In the example below, we create a single context expression, store it in the `value` variable and use it multiple times. Each use properly reacts to the current surroundings.

```
#let value = context text.lang
#value

#set text(lang: "de")
#value

#set text(lang: "fr")
#value
```

Crucially, upon creation, `value` becomes opaque content that we cannot peek into. It can only be resolved when placed somewhere because only then the context is known. The body of a context expression may be evaluated zero, one, or multiple times, depending on how many different places it is put into.

### Location context

We've already seen that context gives us access to set rule values. But it can do more: It also lets us know *where* in the document we currently are, relative to other elements, and absolutely on the pages. We can use this information to create very flexible interactions between different document parts. This underpins features like heading numbering, the table of contents, or page headers dependent on section headings. 

Some functions like `counter.get` implicitly access the current location. In the example below, we want to retrieve the value of the heading counter. Since it changes throughout the document, we need to first enter a context expression. Then, we use `get` to retrieve the counter's current value. This function accesses the current location from the context to resolve the counter value. Counters have multiple levels and `get` returns an array with the resolved numbers. Thus, we get the following result: 

```
#set heading(numbering: "1.")

= Introduction
#lorem(5)

#context counter(heading).get()

=== Background
#lorem(5)

#context counter(heading).get()
```

For more flexibility, we can also use the `here` function to directly extract the current location from the context. The example below demonstrates this:

- We first have `counter(heading).get()`, which resolves to `(2,)` as before.
- We then use the more powerful `counter.at` with `here`, which in combination is equivalent to `get`, and thus get `(2,)`.
- Finally, we use `at` with a label to retrieve the value of the counter at a *different* location in the document, in our case that of the introduction heading. This yields `(1,)`. Typst's context system gives us time travel abilities and lets us retrieve the values of any counters and states at *any* location in the document.

```
#set heading(numbering: "1.")

= Introduction <intro>
#lorem(5)

= Background <back>
#lorem(5)

#context [
  #counter(heading).get() \
  #counter(heading).at(here()) \
  #counter(heading).at(<intro>)
]
```

As mentioned before, we can also use context to get the physical position of elements on the pages. We do this with the `locate` function, which works similarly to `counter.at`: It takes a location or other selector that resolves to a unique element (could also be a label) and returns the position on the pages for that element.

```
Background is at: \
#context locate(<back>).position()

= Introduction <intro>
#lorem(5)
#pagebreak()

= Background <back>
#lorem(5)
```

There are other functions that make use of the location context, most prominently `query`. Take a look at the introspection category for more details on those.

### Nested contexts

Context is also accessible from within function calls nested in context blocks. In the example below, `foo` itself becomes a contextual function, just like `to-absolute` is.

```
#let foo() = 1em.to-absolute()
#context {
  foo() == text.size
}
```

Context blocks can be nested. Contextual code will then always access the innermost context. The example below demonstrates this: The first `text.lang` will access the outer context block's styles and as such, it will not see the effect of `set text(lang: "fr")`. The nested context block around the second `text.lang`, however, starts after the set rule and will thus show its effect.

```
#set text(lang: "de")
#context [
  #set text(lang: "fr")
  #text.lang \
  #context text.lang
]
```

You might wonder why Typst ignores the French set rule when computing the first `text.lang` in the example above. The reason is that, in the general case, Typst cannot know all the styles that will apply as set rules can be applied to content after it has been constructed. Below, `text.lang` is already computed when the template function is applied. As such, it cannot possibly be aware of the language change to French in the template.

```
#let template(body) = {
  set text(lang: "fr")
  upper(body)
}

#set text(lang: "de")
#context [
  #show: template
  #text.lang \
  #context text.lang
]
```

The second `text.lang`, however, *does* react to the language change because evaluation of its surrounding context block is deferred until the styles for it are known. This illustrates the importance of picking the right insertion point for a context to get access to precisely the right styles.

The same also holds true for the location context. Below, the first `c.display()` call will access the outer context block and will thus not see the effect of `c.update(2)` while the second `c.display()` accesses the inner context and will thus see it.

```
#let c = counter("mycounter")
#c.update(1)
#context [
  #c.update(2)
  #c.display() \
  #context c.display()
]
```

### Compiler iterations

To resolve contextual interactions, the Typst compiler processes your document multiple times. For instance, to resolve a `locate` call, Typst first provides a placeholder position, layouts your document and then recompiles with the known position from the finished layout. The same approach is taken to resolve counters, states, and queries. In certain cases, Typst may even need more than two iterations to resolve everything. While that's sometimes a necessity, it may also be a sign of misuse of contextual functions (e.g. of state). If Typst cannot resolve everything within five attempts, it will stop and output the warning "layout did not converge within 5 attempts."

A very careful reader might have noticed that not all of the functions presented above actually make use of the current location. While `counter(heading).get()` definitely depends on it, `counter(heading).at(<intro>)`, for instance, does not. However, it still requires context. While its value is always the same *within* one compilation iteration, it may change over the course of multiple compiler iterations. If one could call it directly at the top level of a module, the whole module and its exports could change over the course of multiple compiler iterations, which would not be desirable.

*Currently, all show rules provide style context, but only show rules on locatable elements provide a location context.*








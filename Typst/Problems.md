

## Problem 1 Triple-backticks

The typst code snippet below renders as expected. But I still have questions. I am confused by the syntax of ` ```typst ...  ``` ` as I have never seen similar syntax before. Specifically, I don't know that 3 back ticks which has a language tag can be used as a delimiter??? Additionally,  I didn't realize that the variable `cetz-code` has a field called text??? Please clearly explain the detailed syntax. Reply in English.

```typ
#set page(width:WIDTH, height:auto)
#set align(left)

#let cetz-code= ```typst import "@preview/cetz:0.4.2" ; 
cetz.canvas({ import cetz.draw: * ; 
circle((0,0),radius:1);}) ``` ;

#grid(columns:(1fr,2fr), rows:auto, align:(horizon+center,horizon+left),stroke:(paint:black,thickness:1pt,dash:"solid"),inset:10pt,{eval(cetz-code.text,mode:"code")},{raw(cetz-code.text,lang:"typc",block:true)})
```


In Typst, the syntax you're seeing is part of its markup language for defining and handling raw text (often used for code snippets or literal strings). I'll break it down step by step, focusing on the two points of confusion you mentioned: the triple-backtick delimiter with a language tag, and the `.text` field on the `cetz-code` variable. I'll reference the provided code snippet for context. 

### 1. The Triple-Backtick Syntax 
This is Typst's way of creating a **raw text block**, which is a literal string that preserves formatting, whitespace, and special characters without interpreting them as Typst markup or code. It's designed for displaying or storing code snippets, similar to how Markdown or other languages handle fenced code blocks. 

- **Basic Structure**:
  - Typst uses backticks ( \` ) as delimiters for raw strings.
  - A single backtick creates an inline raw string: e.g., `raw (typst)` or simply `typst`  (the latter is syntactic sugar for inline raw text).
  - Triple backticks create a block-level raw string: e.g., ```typst
  - The language tag (e.g., `typst` right after the opening triple backticks) is optional but specifies the programming language for syntax highlighting when the raw text is displayed (via the `#raw()` function). If omitted, it's just a plain raw block without highlighting.

- **Why It's Used as a Delimiter**:
  - This syntax is borrowed from Markdown's fenced code blocks (e.g., ```` ```python code``` ````), which many developers are familiar with. Typst adopts it to make writing documents intuitive, especially for technical content like code examples.
  - The triple backticks act as a "fence" to delimit multi-line content. Anything inside is treated as a literal string—no Typst evaluation happens there unless you explicitly process it later (as in your code with `#eval()`).
  - It's not unique to Typst; similar delimiters appear in languages like Rust (for raw strings: `r###"content"###`), Python (triple quotes: `"""content"""`), or GitHub Flavored Markdown. If you've never seen it, it might be because Typst is a newer typesetting system (inspired by LaTeX but with modern syntax).

- **In Your Code Snippet**:
  ```
  #let cetz-code = ```typst import "@preview/cetz:0.4.2" ;
  cetz.canvas({ import cetz.draw: * ;
  circle((0,0),radius:1);}) ``` ;
  ```
  - Here, ` ```typst ... ``` ` creates a raw text block with the language set to "typst" (for potential syntax highlighting).
  - The content inside is a multi-line string: `import "@preview/cetz:0.4.2" ; cetz.canvas({ import cetz.draw: * ; circle((0,0),radius:1);})`. 
  - This entire block is assigned to the variable `cetz-code` using `#let` (Typst's variable declaration keyword). The result is that `cetz-code` holds a **raw value** (not just a plain string—more on this below).
  - Note the trailing semicolon (`;`) after the closing backticks; this is required in Typst to end statements.

If you want to experiment, you could write a simpler version:
```
#let my-code = ```python
```
This stores a Python code snippet as a raw value.

### 2. The `text` Field on `cetz-code`
In Typst, when you create a raw text block (like with triple backticks), it doesn't just produce a plain string—it creates a **raw element** (a structured value of type `raw`). This element has several fields (properties) you can access using dot notation (e.g., `variable.field`). The `.text` field specifically extracts the raw string content from this element.

- **Why `.text` Exists**:
  - Typst distinguishes between the raw element (which includes metadata like language and formatting hints) and its underlying text content.
  - Accessing `.text` gives you the plain string inside the raw block, stripped of the metadata. This is useful for processing the content programmatically—e.g., evaluating it as code, displaying it without highlighting, or manipulating it.
  - Other fields on a raw element include:
    - `.lang`: The language tag (e.g., `"typst"` in your example).
    - `.block`: A boolean indicating if it's a block-level raw (true for triple backticks).
  - If you didn't use `.text`, trying to pass the whole raw element to functions like `#eval()` or `#raw()` might not work as expected, because they often require a string input.

- **In Your Code Snippet**:
  - `cetz-code` is a raw element created from the triple-backtick block.
  - Later in the `#grid()` function:
    ```
    #grid(..., {eval(cetz-code.text, mode:"code")}, {raw(cetz-code.text, lang:"typc", block:true)})
    ```
    - `cetz-code.text` extracts the string: `"import "@preview/cetz:0.4.2" ; cetz.canvas({ import cetz.draw: * ; circle((0,0),radius:1);})"`.
    - In the first grid cell: `#eval(cetz-code.text, mode:"code")` treats this string as Typst code and executes it (importing the CeTZ library and drawing a circle).
    - In the second grid cell: `#raw(cetz-code.text, lang:"typc", block:true)` displays the string as a syntax-highlighted code block (with language "typc", which is likely a shorthand for Typst, and `block:true` for block formatting).
  - Without `.text`, you'd get an error because `#eval()` and `#raw()` expect a string, not a full raw element.

This setup allows side-by-side rendering: the executed result (a circle) next to the raw code snippet.

### Overall Code Purpose
The snippet sets up a page, defines a raw code block for a CeTZ drawing, and uses a grid to show the evaluated output (left) alongside the highlighted source code (right). It's a clever way to demonstrate code examples in Typst documents.

If you have more questions or want to modify the code, feel free to provide details! For official reference, Typst's documentation covers raw elements in the "Text" and "Scripting" sections. 


## Problem 2 eval and raw function



```typst
//#set page(width:60em, height:auto)
#set align(left)

#let string= "1+2" ;
#grid(columns:(1fr,2fr), rows:auto, align:(horizon+left,horizon+left),stroke:(paint:black,thickness:1pt,dash:"solid"),inset:10pt,
grid.cell(colspan:2,[string= \"1+2\"]),
{"eval mode"},{"syntax highlighting by raw function"},
{"markup: "+eval(string, mode:"markup")},{raw(string,lang:"typst",block:true)},
{"math: "+eval(string, mode:"math")}, {raw(string,lang:"typ",block:true)},
//{eval(string, mode:"code")}, {raw(string,lang:"typc",block:true)},
{"code: " +str(eval(string, mode:"code"))}, {raw(string,lang:"typc",block:true)},
grid.cell(colspan:2,[`eval(string, mode:"code")` returns an integer instead of a content element.\ 
grid cell must accept a content element as an input value. ]),
grid.cell(colspan:2,[` "code: " +str(eval(string, mode:"code"))` combines two content element into one content element])
)
```


## Problem 3 content and code block

content
A piece of document content. This type is at the heart of Typst. All markup you write and most functions you call produce content values. You can create a content value by enclosing markup in square brackets. This is also how you pass content to functions.

Example
```typst
Type of *Hello!* is
#type([*Hello!*])
```

Content can be added with the + operator, joined together and multiplied with integers. Wherever content is expected, you can also pass a string or none.

[[Typst Language#Difference between code block and content block|Diffenence between code blocks and content blocks]]























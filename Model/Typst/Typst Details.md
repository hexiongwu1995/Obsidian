

## type

Describes a kind of value.

To style your document, you need to work with values of different kinds: Lengths specifying the size of your elements, colors for your text and shapes, and more. Typst categorizes these into clearly defined _types_ and tells you where it expects which type of value. 

Apart from basic types for numeric values and [typical](https://typst.app/docs/reference/foundations/int/) [types](https://typst.app/docs/reference/foundations/float/) [known](https://typst.app/docs/reference/foundations/str/) [from](https://typst.app/docs/reference/foundations/array/) [programming](https://typst.app/docs/reference/foundations/dictionary/) languages, Typst provides a special type for [_content._](https://typst.app/docs/reference/foundations/content/) A value of this type can hold anything that you can enter into your document: Text, elements like headings and shapes, and style information.

### Example

```
#let x = 10
#if type(x) == int [ #x is an integer! ] else [ #x is another value...]

An emoji is of type #type(emoji.face.stars) \
// An image is of type #type(image("glacier.jpg")). 
An image is of type content.
```

The type of `10` is `int`. Now, what is the type of `int` or even `type`?

```typ
#type(int) \
#type(type) \
#type("E=1") \
#type($E=1$) \
```

Unlike other types like `int`, [none](https://typst.app/docs/reference/foundations/none/ "none") and [auto](https://typst.app/docs/reference/foundations/auto/ "auto") do not have a name representing them. To test if a value is one of these, compare your value to them directly, e.g:

```typ
#let val = none
#if val == none [Yep, it's none.]
```

Note that `type` will return [`content`](https://typst.app/docs/reference/foundations/content/ "`content`") for all document elements. To programmatically determine which kind of content you are dealing with, see [`content.func`](https://typst.app/docs/reference/foundations/content/#definitions-func "`content.func`").

### Constructor

If a type has a constructor, you can call it like a function to creat a new value of the type.
Determines a value's type.

```
#type(12) \
#type(14.7) \
#type("hello") \
#type(<glacier>) \
#type([Hi]) \
#type(1+2 - 2/2) \
#type(x => x + 1) \
#type($a x^2 + b x + c =0$) \
#type(type)
```

```
type(any) -> type
```

`value`  any  Required  Positional

The value whose type's to determine.


## repr

Returns the string representation of a value.
When inserted into content, most values are displayed as this representation in monospace with syntax-highlighting. The exceptions are `none`, integers, floats, strings, content, and functions.

### Example

```typ
#none vs #repr(none) \
#"hello" vs #repr("hello") \
#(1, 2) vs #repr((1, 2)) \
#[*Hi*] vs #repr([*Hi*]) \
```


### For debugging purposes only

This function is for debugging purposes. Its output should not be considered stable and may change at any time.

To be specific, having the same `repr` does not guarantee that values are equivalent, and `repr` is not a strict inverse of [`eval`](https://typst.app/docs/reference/foundations/eval/ "`eval`"). In the following example, for readability, the [`length`](https://typst.app/docs/reference/layout/length/ "`length`") is rounded to two significant digits and the parameter list and body of the [unnamed `function`](https://typst.app/docs/reference/foundations/function/#unnamed) are omitted.

```typ
// #assert(2pt / 3 < 0.67pt) \
#repr(2pt / 3) \
#repr(x => x + 1) \
```


### Parameters

```
repr(any) -> str
```

`value`  any  Required  Positional

The value whose string representation to produce.

## eval

Evaluates a string as Typst code.
This function should only be used as a last resort.

### Example

```typ
#eval("1 + 1") \
#eval("(1, 2, 3, 4)").len() \
#eval("*Markup!*", mode: "markup") \
```


### Parameters

```
eval(str, mode: str, scope: dictionary,) -> any
```

`source`  [str](https://typst.app/docs/reference/foundations/str/)  Required  Positional
A string of Typst code to evaluate.

`mode`  [str](https://typst.app/docs/reference/foundations/str/)
The [syntactical mode](https://typst.app/docs/reference/syntax/#modes) in which the string is parsed.

```typ
#eval("= Heading", mode: "markup")
// #eval("= Heading", mode: "math")
// #eval("= Heading", mode: "code")
#eval("1_2^3", mode: "markup") \
#eval("1_2^3", mode: "math") \
#eval("1+2", mode: "code") \
#eval("1+2", mode: "math") \
#eval("1+2", mode: "markup") \
```

| Variant    | Details                                 |
| ---------- | --------------------------------------- |
| `"markup"` | Evaluate as markup, as in a Typst file. |
| `"math"`   | Evaluate as math, as in an equation.    |
| `"code"`   | Evaluate as code, as after a hash.      |

Default: "code"

`scope`  [dictionary](https://typst.app/docs/reference/foundations/dictionary/) 
A scope of definitions that are made available.

```typst
#eval("x + 1", mode:"code", scope: (x: 2)) \
#eval("x + 1", mode:"math", scope: (x: 2)) \
#eval("x + 1", mode:"markup", scope: (x: 2)) \
#eval(
  "abc/xyz",
  mode: "math",
  scope: (
    abc: $a + b + c$,
    xyz: $x + y + z$,
  ),
)
```

Default:  (:) 



## content

content means a piece of document content. 
This type is at the heart of Typst. All markup you write and most [functions](https://typst.app/docs/reference/foundations/function/) you call produce content values. You can create a content value by enclosing markup in square brackets. This is also how you pass content to functions. 

### Example

```typst
Type of [*Hello!*] is #type([*Hello!*]) \
Type of "*Hello!*" is #type("*Hello!*") \
Type of #emoji.face.stars is #type(emoji.face.stars) \
Type of $a x^2 + b x +c =0$ is #type($a x^2 + b x +c =0$)
```

Content can be added with the `+` operator,  [joined together](https://typst.app/docs/reference/scripting/#blocks) and multiplied with integers. Wherever content is expected, you can also pass a [string](https://typst.app/docs/reference/foundations/str/) or `none`. 

### Representation

Content consists of elements with fields. When constructing an element with its _element function,_ you provide these fields as arguments and when you have a content value, you can access its fields with [field access syntax](https://typst.app/docs/reference/scripting/#field-access). 

Some fields are required: These must be provided when constructing an element and as a consequence, they are always available through field access on content of that type. Required fields are marked as such in the documentation.

Most fields are optional: Like required fields, they can be passed to the element function to configure them for a single element. However, these can also be configured with [set rules](https://typst.app/docs/reference/styling/#set-rules) to apply them to all elements within a scope. Optional fields are only available with field access syntax when they were explicitly passed to the element function, not when they result from a set rule.

Each element has a default appearance. However, you can also completely customize its appearance with a [show rule](https://typst.app/docs/reference/styling/#show-rules). The show rule is passed the element. It can access the element's field and produce arbitrary content from it.

In the web app, you can hover over a content variable to see exactly which elements the content is composed of and what fields they have. Alternatively, you can inspect the output of the [`repr`](https://typst.app/docs/reference/foundations/repr/ "`repr`") function.

### Definitions

`func` 
The content's element function. This function can be used to create the element contained in this content. It can be used in set and show rules for the element. Can be compared with global functions to check whether you have a specific kind of element. 

```
self.func() -> function
```

Here's a simple example to illustrate the func property in Typst:
Suppose you have a content element like a heading, and you want to check its type or apply a show rule based on it.

```typ
// Define some content
#let my-content = heading("My Title",level:1)

// Check if it's a heading using func
#if my-content.func() == heading { "It's a heading!"}

// Use in a show rule to customize all headings, Make all headings bold
// #show heading: it => { if it.func() == heading {emph(it);}}
#my-content
```

Here's another example illustrating a common real-world usage of the func property in Typst: modifying an existing content element (e.g., in a custom function or show rule) by recreating it with adjusted fields while preserving its type. This is often used in templates or dynamic styling to transform elements without losing their original properties.

```
// A function that adds a prefix to headings, but leaves other content unchanged 
#let add-prefix(content, prefix) = {
  if content.func() == heading {
     // Recreate the heading with the modified body
     let f = content.func() ;
     f(prefix + content.body, level: content.level)} 
  else { content }
}

// Usage examples
#add-prefix(heading("Introduction",level:1), "Chapter 1: ")

#add-prefix([This is a regular paragraph.], "Unused prefix: ")  // No change, since it's not a heading
```


Here's a clear and simple example to help understand what content.func() does in Typst and how it's commonly used: 
Basic Example – Checking what kind of content you have

```typ
#set align(left)
#let item = [Hello *world* #emoji.face.stars] 

#let describe(it) = {
    if it.func() == dictionary {
    "This is a dictionary element"
  } else if it.func() == array {
    "This is an array element"
  } else if it.func() == str {
    "This is a string element"
  } else if it.func() == text {
    "This is a text element"
  }  else if it.func() == strong {
    "This is a strong (bold) element"
  } else if it.func() == emoji {
    "This is an emoji element"
  } else if it.func() == symbol {
    "This is a symbol element"
  } else {
    "This is Something else"
  }
}
#item \
#type(item) \
#repr(item) \
#describe(item) \
#describe(item.children.at(0)) \
#describe(item.children.at(1)) \
#describe(item.children.at(2)) \
#describe(item.children.at(3)) \
#describe(item.children.at(4)) \
```


`has` 
Whether the content has the specified field. 

```
self.has(str) -> bool
```


`field`  [str](https://typst.app/docs/reference/foundations/str/)   Required  Positional
The field to look for.

`at` 
Access the specified field on the content. Returns the default value if the field does not exist or fails with an error if no default value was specified. 

```
self.at(str, default: any,) -> any
```

`field`  [str](https://typst.app/docs/reference/foundations/str/)  Required  Positional
The field to access.

`default`  any
A default value to return if the field does not exist.

`fields` 
Returns the fields of this content.

```
self.fields() -> dictionary
```

```typ
#rect( width: 10cm, height: 10cm).fields() \
#rect( width: 10cm, height: 10cm).has("width") \
```

`location` 
The location of the content. This is only available on content returned by [query](https://typst.app/docs/reference/introspection/query/ "query") or provided by a [show rule](https://typst.app/docs/reference/styling/#show-rules), for other content it will be `none`. The resulting location can be used with [counters](https://typst.app/docs/reference/introspection/counter/), [state](https://typst.app/docs/reference/introspection/state/ "state") and [queries](https://typst.app/docs/reference/introspection/query/).

```
self.location() -> none location
```






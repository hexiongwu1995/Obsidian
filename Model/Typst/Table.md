


# table 
`Element`

A table of items.

Tables are used to arrange content in cells. Cells can contain arbitrary content, including multiple paragraphs and are specified in row-major order. For a hands-on explanation of all the ways you can use and customize tables in Typst, check out the [Table Guide](https://typst.app/docs/guides/tables/). 

Because tables are just grids with different defaults for some cell properties (notably `stroke` and `inset`), refer to the [grid documentation](https://typst.app/docs/reference/layout/grid/#track-size) for more information on how to size the table tracks and specify the cell appearance properties.

If you are unsure whether you should be using a table or a grid, consider whether the content you are arranging semantically belongs together as a set of related data points or similar or whether you are just want to enhance your presentation by arranging unrelated content in a grid. In the former case, a table is the right choice, while in the latter case, a grid is more appropriate. Furthermore, Assistive Technology (AT) like screen readers will announce content in a `table` as tabular while a grid's content will be announced no different than multiple content blocks in the document flow. AT users will be able to navigate tables two-dimensionally by cell. 

Note that, to override a particular cell's properties or apply show rules on table cells, you can use the [`table.cell`](https://typst.app/docs/reference/model/table/#definitions-cell "`table.cell`") element. See its documentation for more information.

Although the `table` and the `grid` share most properties, set and show rules on one of them do not affect the other. Locating most of your styling in set and show rules is recommended, as it keeps the table's actual usages clean and easy to read. It also allows you to easily change the appearance of all tables in one place. 

To give a table a caption and make it [referenceable](https://typst.app/docs/reference/model/ref/), put it into a [figure](https://typst.app/docs/reference/model/figure/ "figure").

## Example

The example below demonstrates some of the most common table options.

```typ
#table(
  columns: (1fr, auto, auto),
  inset: 10pt,
  align: horizon,
  table.header( [], [*Volume*], [*Parameters*], ),
  ["image("cylinder.svg")"], $ pi h (D^2 - d^2) / 4 $, [ $h$: height \  $D$: outer radius \  $d$: inner radius ],
  ["image("tetrahedron.svg")"], $ sqrt(2) / 12 a^3 $,  [$a$: edge length]
)
```


Much like with grids, you can use [`table.cell`](https://typst.app/docs/reference/model/table/#definitions-cell "`table.cell`") to customize the appearance and the position of each cell. 

```typ
#set table( stroke: none, gutter: 1em, 
 fill: (x, y) => if x == 0 or y == 0 { gray },
  inset: (left:2em, right:2em,top:1em, bottom:1em),
)

#show table.cell: it => {
  if it.x == 0 or it.y == 0 {
    set text(white)
    strong(it)
  } else if it.body == [] {
    // Replace empty cells with 'N/A'
    pad(..it.inset)[_N/A_]
  } else {
    it
  }
}

#let a = table.cell( fill: green.lighten(60%),)[A]
#let b = table.cell( fill: aqua.lighten(60%),)[B]

#table( columns: 4,
  [], [Exam 1], [Exam 2], [Exam 3],
  [John], [], a, [],
  [Mary], [], a, a,
  [Robert], b, a, b,
)
```



## Accessibility

Tables are challenging to consume for users of Assistive Technology (AT). To make the life of AT users easier, we strongly recommend that you use [`table.header`](https://typst.app/docs/reference/model/table/#definitions-header "`table.header`") and [`table.footer`](https://typst.app/docs/reference/model/table/#definitions-footer "`table.footer`") to mark the header and footer sections of your table. This will allow AT to announce the column labels for each cell.

Because navigating a table by cell is more cumbersome than reading it visually, you should consider making the core information in your table available as text as well. You can do this by wrapping your table in a [figure](https://typst.app/docs/reference/model/figure/ "figure") and using its caption to summarize the table's content.

## Parameters


```
table(
columns: auto int relative fraction array,
rows: auto int relative fraction array,
gutter: auto int relative fraction array,
column-gutter: auto int relative fraction array,
row-gutter: auto int relative fraction array,
inset: relative array dictionary function,
align: auto array alignment function,
fill: none color gradient array tiling function,
stroke: none length color gradient array stroke tiling dictionary function,
..content,
) -> content
```


 `columns`  [auto](https://typst.app/docs/reference/foundations/auto/) or [int](https://typst.app/docs/reference/foundations/int/) or [relative](https://typst.app/docs/reference/layout/relative/) or [fraction](https://typst.app/docs/reference/layout/fraction/) or [array](https://typst.app/docs/reference/foundations/array/)  Settable
The column sizes. See the [grid documentation](https://typst.app/docs/reference/layout/grid/#track-size) for more information on track sizing.
Default: `()`

 `rows`  [auto](https://typst.app/docs/reference/foundations/auto/) or [int](https://typst.app/docs/reference/foundations/int/) or [relative](https://typst.app/docs/reference/layout/relative/) or [fraction](https://typst.app/docs/reference/layout/fraction/) or [array](https://typst.app/docs/reference/foundations/array/)  Settable
The row sizes. See the [grid documentation](https://typst.app/docs/reference/layout/grid/#track-size) for more information on track sizing.
Default: `()`

`gutter`  [auto](https://typst.app/docs/reference/foundations/auto/) or [int](https://typst.app/docs/reference/foundations/int/) or [relative](https://typst.app/docs/reference/layout/relative/) or [fraction](https://typst.app/docs/reference/layout/fraction/) or [array](https://typst.app/docs/reference/foundations/array/)
The gaps between rows and columns. This is a shorthand for setting `column-gutter` and `row-gutter` to the same value. See the [grid documentation](https://typst.app/docs/reference/layout/grid/#parameters-gutter) for more information on gutters.
Default: `()`

`column-gutter`  [auto](https://typst.app/docs/reference/foundations/auto/) or [int](https://typst.app/docs/reference/foundations/int/) or [relative](https://typst.app/docs/reference/layout/relative/) or [fraction](https://typst.app/docs/reference/layout/fraction/) or [array](https://typst.app/docs/reference/foundations/array/)  Settable
The gaps between columns. Takes precedence over `gutter`. See the [grid documentation](https://typst.app/docs/reference/layout/grid/#parameters-gutter) for more information on gutters.
Default: `()`

 `row-gutter`  [auto](https://typst.app/docs/reference/foundations/auto/) or [int](https://typst.app/docs/reference/foundations/int/) or [relative](https://typst.app/docs/reference/layout/relative/) or [fraction](https://typst.app/docs/reference/layout/fraction/) or [array](https://typst.app/docs/reference/foundations/array/)  Settable
The gaps between rows. Takes precedence over `gutter`. See the [grid documentation](https://typst.app/docs/reference/layout/grid/#parameters-gutter) for more information on gutters.
Default: `()`

`inset`  [relative](https://typst.app/docs/reference/layout/relative/) or [array](https://typst.app/docs/reference/foundations/array/) or [dictionary](https://typst.app/docs/reference/foundations/dictionary/) or [function](https://typst.app/docs/reference/foundations/function/)  Settable
How much to pad the cells' content.
To specify the same inset for all cells, use a single length for all sides, or a dictionary of lengths for individual sides. See the [box's documentation](https://typst.app/docs/reference/layout/box/#parameters-inset) for more details.

To specify a varying inset for different cells, you can:
- use a single, uniform inset for all cells
- use an array of insets for each column
- use a function that maps a cell's X/Y position (both starting from zero) to its inset
See the [grid documentation](https://typst.app/docs/reference/layout/grid/#styling) for more details.

```
#table(
  columns: 2,
  inset: 10pt,
  [Hello],
  [World],
)

#table(
  columns: 2,
  inset: (x: 20pt, y: 10pt),
  [Hello],
  [World],
)
```

Default: `0% + 5pt`


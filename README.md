# typMisc

`typMisc` is a small R package providing miscellaneous helper functions and S3 methods to streamline the generation of Typst code within Quarto documents.

It has only been tested with the huxtable and typstable packages.

## Installation

To install the development version of `typMisc` locally:

```r
# install.packages("devtools")
# devtools::install_local("path/to/typMisc")
```

## Core Features

* **S3 `typstcode` Class**: A dedicated class to handle raw Typst strings and ensure they are emitted correctly into Quarto documents.
* **Breakable Tables**: Easily toggle the `#show figure: set block(breakable: true)` rule.
* **Table Notes**: Wrap `huxtable` or other table objects in a Typst block that includes notes below the table (as opposed to the bottom of the page or 
elsewhere).

## Example

There are example .qmd files in the examples directory (inst/examples in the
source).

```r
ex_path <- system.file("examples", package = "typMisc")
dir(ex_path)
```

o generate a PDF file from an example .qmd file copy it to the current 
directory and from the command line (not from R):

```
quarto render example.qmd --to typst
```

## Typst

Although one should only need the minimum of Typst knowledge to use this 
package this cheatsheet may be helpful: https://github.com/mewmew/typst-cheat-sheet

Also be aware that these characters have special meaning in Typst 
markup mode and can be escaped with `\`:  
`#` `[` `]` `*` `_` `$` `<` `>` `@` `=` `-` `+` `/` `` ` `` `~` `\`

In Typst string literals (strings within double quotes) these have special meaning:
`\"` `\\` `\n` `\r` `\t` `\u{...}`

The huxtable `sanitize` function with `format="typst"` argument can be used
to escape them, if needed.


# typMisc

`typMisc` is a small R package providing miscellaneous helper functions to 
streamline the generation of Typst code within Quarto documents
using the typstable R package.

`tt_env` is a `tt` wrapper allowing one to simultaneously assign `preamble`
and `epilogue` strings in a named list. `build_tt_env` will build such a list
from the output of the `feat_*` functions.

`encircle` can be used to build a cell with a circle around it.

`as.typstcode` creates a `"typstcode"` S3 object from a typst string.  It has
a `knit_print` method.

Other miscellaneous functions.

## Installation

To install the development version of `typMisc` locally:

``` r
pak::pak("ggrothendieck/typMisc")
```

See .build.R file source file to build documentation as well.

## Introduction

This package include `tt_env` which is a wrapper for `typstable::tt` taking
the same arguments except it takes an `env=` argument which accepts a `"feat"`
object, which is a character string with class `"feat"` or a list with
`preamble` or `epilogue` components.  The character string or list components
should be typst language code. `as.feat` can be used to convert 
a character string or such list to a `"feat"` object.  `"feat"` class has
a + method which can be used to combine other feat objects. For example
the following invokes typstable:tt adding footnotes, notes, and clipping
any lines that protrude outside the table.
``` r
tt_env(escape = FALSE, env = feat_notes(notes = notes) + feat_clip())
```

The package also defines a `"typstcode"` class which has a `knit_print` method
so that printing such as object in a quarto document will emit typst code.

There is also an `encircle` function.  If `x` is a character vector then
`encircle(x)` places typst code around it to enclode the string in a circle.
This is to highlight certain cells in a table in a more obvious way than
bold or italic.

## Typst

Although one should only need the minimum of Typst knowledge to use this 
package since the various functions hide typst code this cheatsheet may be
helpful: https://github.com/mewmew/typst-cheat-sheet

Also be aware that these characters have special meaning in Typst 
markup mode and can be escaped with `\`:  
`#` `[` `]` `*` `_` `$` `<` `>` `@` `=` `-` `+` `/` `` ` `` `~` `\`

In Typst string literals (strings within double quotes) these have special meaning:
`\"` `\\` `\n` `\r` `\t` `\u{...}`



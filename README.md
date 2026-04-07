# typMisc

`typMisc` is a small R package providing miscellaneous helper functions to 
streamline the generation of Typst code. Many are for use with the typstable R 
package in an .Rtyp or .qmd file.  Some are only for use in a .qmd file.

## Installation

To install the development version of `typMisc`:

``` r
pak::pak("ggrothendieck/typMisc")
```

See .build.R file source file to build documentation as well.

To load the package once installed:
```
library(typMisc)
```

## Introduction

This package includes `tt_env` which is a wrapper for `typstable::tt` having
the same arguments except it also takes an `env=` argument which accepts a
`"feat"` object, which is a character string with class `"feat"` or a list with
`preamble` or `epilogue` components.  The character string or list components
should be typst language code. `as.feat` can be used to convert a character
string or such list to a `"feat"` object.  `"feat"` class has a + method which
can be used to combine feat objects. 

There is also an `encircle` function.  If `x` is a character vector then
`encircle(x)` places typst code around each element to enclode the content in a
circle.  This can be used to highlight certain cells in a table in a more
obvious way than bold or italic.

For example

```
library(dplyr)
library(typstable)
library(typMisc)

notes <- paste("Note at bottom of table.",
  "Backslash space means newline.",
  "Thick vertical line protrudes from table so we clip the table.",
  sep = "\\ ")

mtcars %>%
  head %>%
  select(mpg, qsec, cyl, disp, hp) %>%
  mutate(mpg = if_else(. == max(.), encircle(.), as.character(.))) %>%
  tt_env(escape = FALSE, env = 
    feat_notes(notes = notes) +
    feat_clip() +
    feat_text_size(size = "8pt")
  ) %>%
  tt_column(2, stroke = "(right: 2pt)")
```

Independently of the above, the package defines a `"typstcode"` class
which has a `knit_print` method so that printing such as object in a quarto
document will emit typst code.

## Help

From R `help(package = "typMisc") will show a web page linking to the help 
files and a link to the example .qmd and .Rtyp files on github.

`examples_browse()` can be used to browse local versions of these files or 
`examples_dir()` can be used to get the full path to the local examples 
directory.

## Typst

Although one should only need the minimum of Typst knowledge to use this 
package since the various functions hide typst code this cheatsheet may be
helpful: https://github.com/mewmew/typst-cheat-sheet

Also be aware that these characters have special meaning in Typst 
markup mode and can be escaped with `\`:  
`#` `[` `]` `*` `_` `$` `<` `>` `@` `=` `-` `+` `/` `` ` `` `~` `\`

In Typst string literals (strings within double quotes), these strings have 
tspecial meaning:
`\"` `\\` `\n` `\r` `\t` `\u{...}`



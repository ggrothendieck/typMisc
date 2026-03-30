# typMisc

`typMisc` is a small R package providing miscellaneous helper functions and S3 methods to streamline the generation of Typst code within Quarto documents
and typstable R package.

## Installation

To install the development version of `typMisc` locally:

```r
# install.packages("devtools")
# devtools::install_local("path/to/typMisc")

or see .build.R file to build documentation as well.
```

## Typst

Although one should only need the minimum of Typst knowledge to use this 
package this cheatsheet may be helpful: 
https://github.com/mewmew/typst-cheat-sheet

Also be aware that these characters have special meaning in Typst 
markup mode and can be escaped with `\`:  
`#` `[` `]` `*` `_` `$` `<` `>` `@` `=` `-` `+` `/` `` ` `` `~` `\`

In Typst string literals (strings within double quotes) these have special meaning:
`\"` `\\` `\n` `\r` `\t` `\u{...}`



# typMisc 0.2.0

* added feat_* functions

* now depends on R 4.4.0 or greater

# typMisc 0.1.0

* Initial github release of `typMisc`.

## Features

* Added `as.typstcode()` S3 class and methods to handle raw Typst markup safely within R.
* Added `breakable()` function to globally toggle page-breaking for Typst figures/blocks.
* Added `table_note()` to allow easy addition of footer notes to `huxtable` objects with Typst-specific alignment and vertical spacing controls.
* Implemented `knit_print.typstcode()` to automatically wrap output in ````{=typst}` fences for Quarto.

## Documentation and Examples

* Included sample Quarto documents in `inst/examples` 
* Added instructions in `README.md` for accessing internal package example using `system.file()`.
* Added vignette using readme2vignette


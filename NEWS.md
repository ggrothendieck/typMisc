# typMisc 0.3.1

* improve README.md and vignette

* render_rtyp, typst_version

* examples_dir, examples_browse

* add an .Rtyp example to the examples directory

# typMisc 0.3.0

* add tt_env

* add feat class and methods

* add encircle function

# typMisc 0.2.0

* add feat_*

* now depends on R 4.4.0 or greater

# typMisc 0.1.0

* Initial github release of `typMisc`.

## Features

* Add `as.typstcode()` S3 class and methods to handle raw Typst markup safely within R.
* Add `breakable()` function to globally toggle page-breaking for Typst figures/blocks.
* Added `table_note()` to allow easy addition of footer notes to `huxtable` objects with Typst-specific alignment and vertical spacing controls.
* Implemented `knit_print.typstcode()` to automatically wrap output in ````{=typst}` fences for Quarto.

## Documentation and Examples

* Included sample Quarto documents in `inst/examples` 
* Add instructions in `README.md` for accessing internal package example using `system.file()`.
* Add vignette using readme2vignette


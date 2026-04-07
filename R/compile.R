#' render .Rtyp file processing it with knitr and then typst
#' Must install binary from https://github.com/typst/typst/releases
#'  or build from rust source: cargo install --locked typst-cli
#'
#' Assumes typst is on PATH.
#' param x input file.  Use path if not in current directory.
#' ... not used
#' @export
render_rtyp <- function(x, ...) {
  stopifnot(endsWith(x, ".rtyp") || endsWith(x, ".Rtyp"))
  y <- sub("\\.[rR]typ", ".typ", x)
  knitr::knit(x, y)
  system2("typst", c("compile", y))
}

#' show typst version.  Assumes typst is on PATH.
#' @export
typst_version <- function() {
  system2("typst", c("--version"))
}

#' show full path to examples directory
#' @export
examples_dir <- function() {
  system.file("examples", package = "typMisc")
}

#' bring up web page with links to examples
#' @export
examples_browse <- function() {
  tmp <- tempfile(fileext = ".html")
  on.exit(if (file.exits(tmp)) file.remove(tmp))
  ex_dir <- examples_dir()
  files <- list.files(ex_dir, full.names = TRUE)
  html_content <- paste0('<a href="file://', files, '" target="_blank">', 
    basename(files), '</a><br>')
  writeLines(c("<html><body><h3>Click to open in new tab:</h3>", 
    html_content, "</body></html>"), tmp)
  browseURL(tmp)
}


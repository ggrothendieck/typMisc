#' Create a typstcode object
#' 
#' @param x An object to be coerced to class typstcode
#' @return The object with class typstcode prepended
#' @export
as.typstcode <- function(x) structure(x, class = c("typstcode", class(x)))

#' Format string as a Typst raw block
#' 
#' @param x A character string
#' @return A string wrapped in Quarto's Typst raw attribute fences
#' @export
emit_typstcode <- function(x) paste("\n\n```{=typst}\n", x, "\n```\n\n")

#' knit_print method for typstcode objects
#' 
#' @param x A typstcode object
#' @param ... Unused
#' @export
knit_print.typstcode <- function(x, ...) {
  if (is.list(x)) lapply(x, knit_print)
  else x |> emit_typstcode() |> knitr::asis_output()
}

#' Print method for typstcode objects
#' 
#' @param x A typstcode object
#' @param ... Unused
#' @return The object x, invisibly
#' @export
print.typstcode <- function(x, ...) {
  if (is.list(x)) lapply(x, print)
  else x |> emit_typstcode() |> cat()
  invisible(x)
}

#' Wrap a table with a footer note in Typst
#' 
#' @param ht A huxtable object
#' @param notes Character string or vector of notes
#' @param size Typst text size for the note
#' @param vert Vertical spacing before the note
#' @param align Alignment of the block: "center", "left" or "right"
#' @return A typstcode object
#' @export
table_note <- function(ht, notes = "", size = "0.8em", vert = "-1em",
                        align = c("center", "left", "right")) {
  align <- match.arg(align)
  notes <- paste(notes, collapse = "\n")
  list( 
    paste0("#align(", align, ")[#block[#set align(left)\n") |> 
      as.typstcode(),
    ht,
    paste0("#v(", vert, ") #text(size: ",  size, ")[", notes, "]\n]\n]\n") |>
      as.typstcode()
  ) |> as.typstcode()
}

#' Set figure breakability in Typst
#' 
#' @param x Logical indicating if figures should be breakable
#' @return A typstcode object containing the Typst show rule
#' @export
breakable <- function(x = TRUE) {
  paste0("#show figure: set block(breakable:", tolower(x), ")\n") |> as.typstcode()
}

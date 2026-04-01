#' Create a feat object
#' @param pre Preamble string.
#' @param epi Epilogue string.
#' @return An S3 object of class 'feat'.
#' @export
feat <- function(pre = "", epi = "") {
  structure(list(pre = pre, epi = epi), class = "feat")
}

#' Convert objects to feat class
#' @param x Object to convert (character, list, or feat).
#' @return A feat object.
#' @export
as.feat <- function(x) UseMethod("as.feat")

#' @export
as.feat.feat <- function(x) x

#' @export
as.feat.character <- function(x) feat(pre = x, epi = "")

#' @export
as.feat.list <- function(x) {
  feat(pre = x$pre %||% x$preamble %||% "", 
       epi = x$epi %||% x$epilogue %||% "")
}

#' Combine Typst features
#' @param e1 A feat object or character string.
#' @param e2 A feat object or character string.
#' @description Combines features. Preambles are concatenated in order. 
#' Epilogues are concatenated in reverse (LIFO) to ensure nested blocks close correctly.
#' @export
`+.feat` <- function(e1, e2) {
  e1 <- as.feat(e1)
  e2 <- as.feat(e2)
  feat(pre = paste0(e1$pre, e2$pre), epi = paste0(e2$epi, e1$epi))
}

#' @export
`+.character` <- function(e1, e2) {
  if (inherits(e2, "feat")) return(as.feat(e1) + e2)
  stop("Binary operator + only defined for feat objects or character strings.")
}

#' Print method for feat objects
#' @param x A feat object.
#' @param ... Unused.
#' @export
print.feat <- function(x, ...) {
  cat("--- Typst Preamble ---\n", x$pre, "\n", sep = "")
  cat("--- Typst Epilogue ---\n", x$epi, "\n", sep = "")
}

#' Generate Typst clipping rule for tables
#' @description Injects a show rule to clip table content and remove default strokes.
#' Useful for fixing border rendering issues ("butt fix").
#' @return A feat object.
#' @export
feat_clip <- function() {
  as.feat(list(pre = "#show table: it => { block(clip: true, stroke: none)[#it] }\n", epi = ""))
}

#' Set table font size
#' @param size String. The font size (e.g., "9pt").
#' @return A feat object.
#' @export
feat_text_size <- function(size = "8pt") {
  as.feat(list(pre = paste0("#set text(size: ", size, ")\n"), epi = ""))
}

#' Align all cells in table
#' @param align Character. One of "left", "center", or "right".
#' @return A feat object.
#' @export
feat_align_cells <- function(align = c("left", "center", "right")) {
  align <- match.arg(align)
  as.feat(list(pre = paste0("#set table(align: ", align, ")\n"), epi = ""))
}

#' Generate Typst table notes and environment
#' @param notes String. The text of the note to appear below the table.
#' @param notes_size String. Font size of the note (e.g., "0.8em").
#' @param align String. Outer alignment of the table on the page.
#' @param table_font_size String. Font size for the table body.
#' @param vert String. Vertical adjustment to "glue" the note to the table.
#' @return A feat object.
#' @export
feat_notes <- function(notes, notes_size = "0.8em", align = "center", 
                       table_font_size = "8pt", vert = "-1em") {
  as.feat(list(
    pre = paste0("#align(", align, ")[#block[#set align(left)\n#set text(size: ", table_font_size, ")\n"),
    epi = paste0("#v(", vert, ") #text(size: ", notes_size, ")[", notes, "]\n]\n]\n")
  ))
}

#' Style spanned table cells
#' @param num Integer. The colspan value to target.
#' @param size String. The font size for these specific cells.
#' @return A feat object.
#' @export
feat_colspan_font_size <- function(num, size = "8pt") {
  as.feat(list(pre = paste0("#show table.cell.where(colspan: ", num, "): set text(size: ", size, ")\n"), epi = ""))
}

#' Wrapper for typstable::tt with environment support
#' @param x A data frame.
#' @param ... Additional arguments passed to typstable::tt.
#' @param env A feat object (or combined feat objects using +).
#' @param preamble Optional character string (ignored if env is provided).
#' @param epilogue Optional character string (ignored if env is provided).
#' @export
tt_env <- function(x, ..., env = NULL, preamble = NULL, epilogue = NULL) {
  if (!is.null(env)) {
    env <- as.feat(env)
    preamble <- env$pre
    epilogue <- env$epi
  }
  typstable::tt(x, ..., preamble = preamble, epilogue = epilogue)
}


# Depends: R (>= 4.4.0)

#' Generate Typst clipping rule for tables
#' @description Injects a show rule to clip table content and remove default strokes, 
#' useful for fixing border rendering issues ("butt fix").
#' @return A list containing the preamble string.
#' @export
feat_clip <- function() {
  list(pre = "#show table: it => { block(clip: true, stroke: none)[#it] }\n",
       epi = "")
}

#' Generate a Typst font environment
#' @param size String. The font size (e.g., "9pt").
#' @return A list with pre and epi strings.
#' @export
feat_text_size <- function(size = "8pt") {
  list(
    pre = paste0("#set text(size: ", size, ")\n"),
    epi = ""
  )
}

#' Align all cells in table
#' @param align.  Can be "left", "center" or "right".
#' @export
feat_align_cells <- function(align = c("left", "center", "right")) {
  align = match.arg(align)
  list(
    pre = paste0("#set table(align:", align, ")\n"),
    epi = ""
  )
}

# Not used in my reports. Remove?
#' Generate a Typst layout environment (Alignment & Blocks)
#' @param align String. Outer alignment of the block (e.g., "center").
#' @param inner_align String. Alignment inside the block (e.g., "left").
#' @export
feat_align <- function(align = "center", inner_align = "left") {
  list(
    pre = paste0("#align(", align, ")[#block[#set align(", inner_align, ")\n"),
    epi = "]\n]\n"
  )
}

#' Generate Typst table notes
#' @param notes.  String giving text of notes.
#' @param notes_size.  Font size of notes.
#' @param align String. Alignment of table on page.
#' @param text String. The text of the note to appear below the table.
#' @param size String. Font size of the note (e.g., "0.8em").
#' @param vert String. Vertical adjustment to "glue" the note to the table (e.g., "-1em").
#' @return A list containing the epilogue string.
#' @export
feat_notes <- function(notes, notes_size = "0.8em", 
    align = "center", table_font_size = "8pt", vert = "-1em") {
  list(
     preamble = paste0("#align(", align, ")[#block[#set align(left)\n", 
                       "#set text(size: ", table_font_size, ")\n"),
     epilogue = paste0("#v(", vert, ") #text(size: ", notes_size, ")[", notes, "]\n]\n]\n")
  )
}

#' Generate Typst styling for spanned table cells
#' @param num Integer. The colspan value to target (e.g., 6).
#' @param size String. The font size for these specific cells (e.g., "8pt").
#' @return A list containing the preamble string.
#' @export
feat_colspan_font_size <- function(num, size = "8pt") {
  list(pre = paste0("#show table.cell.where(colspan: ", num, "): set text(size: ", size, ")\n"))
}

#' Combine Typst features or raw strings into preamble and epilogue strings
#' @param ... Multiple lists returned by feat_* functions or raw character strings.
#' @description Stitches together multiple Typst rules. Character strings are 
#' treated as preambles. Preambles are concatenated in order; epilogues are 
#' reversed to ensure nested blocks close correctly (LIFO).
#' @return A list with named elements 'preamble' and 'epilogue' for use in tt().
#' @examples
#' \dontrun{
#' # Example usage in a Quarto document:
#' env <- build_tt_env(
#'   feat_env(font_size = "8pt", align = "center"),
#'   "#set table(stroke: 0.5pt + blue)\n",
#'   feat_clip(),
#'   feat_notes("Source: xyz")
#' )
#' 
#' df %>% tt(preamble = env$preamble, epilogue = env$epilogue)
#' }
#' @export
build_tt_env <- function(...) {
  items <- list(...)
  
  # Normalize everything into a list(pre=..., epi=...)
  normalized <- lapply(items, function(x) {
    if (is.character(x)) {
      list(pre = x, epi = "")
    } else {
      # Use base R 4.4.0+ %||% for safety
      list(pre = x$pre %||% "", epi = x$epi %||% "")
    }
  })
  
  # Extract pre components in original order
  pre_parts <- sapply(normalized, function(f) f$pre)
  preamble <- paste(pre_parts, collapse = "")
  
  # Extract epi components and reverse them (LIFO)
  epi_parts <- rev(sapply(normalized, function(f) f$epi))
  epilogue <- paste(epi_parts, collapse = "")
  
  list(preamble = preamble, epilogue = epilogue)
}

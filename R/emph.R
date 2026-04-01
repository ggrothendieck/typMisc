
#' draw circle around a string
#' @param x character scalar/vector.  
#' @param radius string defining adius of circule surrounding x
#' @param stroke string defining thickness of circle
#' @param color string defining color of circle
#' @export
encircle <- function(x, radius = "8pt", stroke = "1pt", color = "black") {
  paste0(
   "#box(circle(stroke: ", stroke, " + ", color, ", radius: ", radius, 
     ", align(center + horizon)[", 
   x,
   "]))"
  )
}


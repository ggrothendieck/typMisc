library(readme2vignette)
add_readme_to_vignette(".", vignette_slug = "typMisc")

library(devtools)
document()
build()
install(build_vignettes = TRUE)

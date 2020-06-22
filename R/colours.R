
#' Celltype colours for Jackson Basel 2020
#' @export
jackson_basel_colours <- function() {
  pal <- ggthemes::tableau_color_pal(palette = "Classic Green-Orange 12")(12)

  celltype_colours <- c(
    "Stromal" = pal[7],
    "B cells" = pal[3],
    "T cells" = pal[8],
    "Macrophage" = pal[1],
    "Epithelial (basal)" = pal[9],
    "Epithelial (luminal)" = pal[10],
    "Epithelial (other)" = pal[5],
    "Monocyte" = pal[11],
    "Other" = "grey60",
    "Unknown" = "grey70"
  )
  celltype_colours
}

#' @export
patient_clinSubtype_colours <- function(){
  pal <- c("#648FFF", "#785EF0", "#DC267F", "#FE6100", "#FFB000")

  clinSubtype_colours <- c(
    "HR+HER2-" = pal[1],
    "TripleNeg" = pal[3],
    "HR+HER2+" = pal[4],
    "HR-HER2+" = pal[5]
  )
  clinSubtype_colours
}

#' @export
patient_response_colours <- function(){
  pal <- c("#648FFF", "#785EF0", "#DC267F", "#FE6100", "#FFB000")

  clinSubtype_colours <- c(
    "Resistant" = pal[3],
    "Refractory" = pal[4],
    "Sensitive" = pal[1]
  )
  clinSubtype_colours
}


#' Celltype colours for Jackson Basel 2020
#' @export
jackson_basel_colours <- function() {
  pal <- c("#8B5B42", "#AF4EA9", "#FFB60A", "#0AC694", "#0024DD", "#6CC1FF",
           "#0496FF", "#1DA05B", "#E11E00", "#A78882")
  
  celltype_colours <- c(
    "Stromal" = pal[1],
    "B cells" = pal[2],
    "T cells" = pal[3],
    "Macrophage" = pal[4],#
    "Epithelial (basal)" = pal[5],
    "Epithelial (luminal)" = pal[6],
    "Epithelial (other)" = pal[7],
    "Monocyte" = pal[8], #
    "Endothelial" = pal[9],
    "Fibroblasts" = pal[10],
    "Other" = "grey70",
    "Unknown" = "grey90"
  )
  celltype_colours
}

#' Color maps of patient clinical subtypes
#'  @export
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

#' Set Wagner colour maps to patient clinical subtypes
#' @export
patient_clinSubtype_colours_wagner <- function(){
  pal <- c("#648FFF", "#785EF0", "#DC267F", "#FE6100", "#FFB000")
  
  clinSubtype_colours <- c(
    "LumB" = pal[1],
    "LumA" = pal[2],
    "TN" = pal[3],
    "HER2" = pal[4],
    "LumB-HER2" = pal[5]
  )
  clinSubtype_colours
}

#' Colour maps of patient responses
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

#' Group colors
#' @export
cohort_colours <- function(){
  pal <- wes_palette("Darjeeling2", 4, type = c("discrete"))
  
  cohort_cols <- c(
    "Basel" = pal[1],
    "Zurich1" = pal[2],
    "Wagner" = pal[3],
    "Schapiro" = pal[4]
  )
}

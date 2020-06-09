#' Create a theme for all plot for the astir paper
#' @export
astir_paper_theme <- function() {
  cowplot::theme_cowplot(font_size = 12) +
    theme(strip.background = element_rect(fill = "white"))
}
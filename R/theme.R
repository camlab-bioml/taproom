#' Create a theme for all plot for the astir paper
#' 
#' @import cowplot
#' @import ggplot2
#' @examples astir_paper_theme()
#' @export
astir_paper_theme <- function() {
  cowplot::theme_cowplot(font_size = 12) +
    theme(strip.background = element_rect(fill = "white"),
          strip.text = element_text(face="bold"),
          legend.text=element_text(size=12),
          legend.title=element_text(face = "bold", size=14))
}
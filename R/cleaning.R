
#' Get a QC score for the mutually exclusive expression of 2 markers
#'
#' Implements a very basic QC test: CD45 and keratin should exhibit mutually
#' exclusive expression, so performs a robust regression to check this trend,
#' and reports the z-statistic. The more negative this is, the better the
#' mutually-exclusive expression (to a first approximation).
#'
#' @param sce An input \code{SummarizedExperiment} or \code{SingleCellExperiment}
#' @param marker_1 The name of the first marker (normally keratin)
#' @param marker_2 The name of the second marker (normally CD45/PTPRC)
#'
#' @importFrom MASS rlm
#' @importFrom SummarizedExperiment assay
#' @importFrom broom tidy
#'
#' @export
imc_exclusive_marker_score <- function(sce,
                                       marker_1 = "pan Cytokeratin",
                                       marker_2 = "CD45",
                                       assay_name = "logcounts") {

  gex <- t(assay(sce, assay_name)[c(marker_1, marker_2),])

  tidy((rlm(cbind(1, gex[,marker_2]), gex[,marker_1])))$statistic[2]

}


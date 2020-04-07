

#' Plot the spatial variation in gene expression or colData
#'
#' @param sce SingleCellExperiment containing IMC data
#' @param colour_by Either a feature name or column of \code{colData(sce)}
#' @param x_str The column of \code{colData(sce)} that codes for the x coordinate
#' @param y_str The column of \code{colData(sce)} that codes for the Y coordinate
#' @param ... Additional arguments to pass to \code{plotColData}
#'
#' @importFrom scater plotColData
#' @importFrom SummarizedExperiment colData
#'
#' @export
plotSpatial <- function(sce,
                        colour_by = NULL,
                        x_str = "Location_Center_X",
                        y_str = "Location_Center_Y",
                        winsorize = FALSE,
                        w_limits = c(0.05, 0.95),
                        exprs_values = "logcounts",
                        ...) {

  if(!(x_str %in% names(colData(sce)) || y_str %in% names(colData(sce)))) {
    stop("x_str or y_str not in colData(sce)")
  }

  w_name <- NULL

  if(winsorize) {
    stopifnot(colour_by %in% rownames(sce))

    y <- assay(sce, exprs_values)[colour_by,]
    q <- quantile(y, p = w_limits)
    y[y < q[1]] <- q[1]
    y[y > q[2]] <- q[2]

    w_name <- paste0(colour_by, "_w")
    colData(sce)[[ w_name ]] <- y
    colour_by <- w_name
  }


  cb <- colour_by
  plotColData(sce,
              x = x_str,
              y = y_str,
              colour_by = cb,
              ...)
}

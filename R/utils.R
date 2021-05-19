



#' @keywords internal
winsorize_one <- function(y,
                          w_limits) {
  q <- quantile(y, p = w_limits)
  y[y < q[1]] <- q[1]
  y[y > q[2]] <- q[2]
  y
}

#' Winsorize the (log) counts
#'
#' @export
winsorize <- function(sce,
                      exprs_values = "logcounts",
                      w_limits = c(0.05, 0.95)) {

  ## Save unwinsorized expression values
  assay(sce, paste0(exprs_values, "_unwinsorized")) <- assay(sce, exprs_values)

  assay(sce, exprs_values) <- t(apply(assay(sce, exprs_values),
                                    1,
                                    winsorize_one,
                                    w_limits))

  sce
}

#' Write to a CSV file to be read in by python
#'
#' Writes the cell names as row names, and the (X,Y) co-ordinates
#' as the first two columns (named \code{X} and \code{Y}).
#'
#' @param sce SingleCellExperiment containing IMC data
#' @param x_str The column of \code{colData(sce)} that codes for the x coordinate
#' @param y_str The column of \code{colData(sce)} that codes for the Y coordinate
#' @param file The output file to write to
#' @param include_xy Logical: should spatial location be written as first two
#' columns?
#'
#' @export
to_csv <- function(sce,
                   file,
                   include_xy = TRUE,
                   x_str = "Location_Center_X",
                   y_str = "Location_Center_Y",
                   exprs_values = "logcounts") {

  mat <- t(assay(sce, exprs_values))

  if(include_xy) {
    mat <- cbind(
      data.frame(X = colData(sce)[[x_str]],
                 Y = colData(sce)[[y_str]]),
      mat
    )
  }

  write.csv(mat, file)

}

#' Get cell type assignments given probability matrix
#'
#' @export
get_celltypes <- function(prob_mat, thresh = 0.5) {
  if(is.data.frame(prob_mat)) {
    prob_mat <- as.matrix(prob_mat)
  }
  celltypes <- apply(prob_mat, 1, function(x) {
    colnames(prob_mat)[which.max(x)]
  })

  celltypes[rowMaxs(prob_mat) < thresh] <- "Unknown"
  celltypes
}

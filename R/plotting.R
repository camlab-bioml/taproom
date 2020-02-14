

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
                        ...) {
  
  if(!(x_str %in% names(colData(sce)) || y_str %in% names(colData(sce)))) {
    stop("x_str or y_str not in colData(sce)")
  }
  
  
  cb <- colour_by
  plotColData(sce, 
              x = x_str, 
              y = y_str,
              colour_by = cb)
}
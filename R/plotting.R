

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

#' Create an expression heatmap
#' 
#' Note that this creates a \code{Heatmap} object. To plot,
#' call \code{draw(...)} on the returned object.
#' 
#' @param sce A \code{SingleCellExperiment} containing expression values
#' @param cell_type_column The column of \code{colData(sce)} that contains 
#' cell type annotation
#' @param assay The assay of \code{sce} containg expression data to plot
#' @param thresh The threshold to winsorize expression values at
#' 
#' @return A heatmap of class \code{ComplexHeatmap::Heatmap}
#' 
#' @importFrom SummarizedExperiment assay colData
#' @importFrom ComplexHeatmap Heatmap HeatmapAnnotation
#' @importFrom viridis viridis
createHeatmap <- function(sce,
                          cell_type_column = "cell_type",
                          assay = "logcounts",
                          thresh = 2) {
  
  lc <- t(as.matrix(assay(sce, assay)))
  lc <- scale(lc)

  lc[lc > thresh] <- thresh
  lc[lc < -thresh] <- -thresh
  
  cell_types = colData(sce)[[ cell_type_column ]]

  celltype_annot <- HeatmapAnnotation(`Cell type` = cell_types, 
                                      which="column",
                                      col = list(Cell type` = jackson_basel_colours()))  
  
  type_exprs <- Heatmap(t(lc), 
                        name = "Expression",
                        column_title = "Cell",
                        col=viridis(100),
                        top_annotation = celltype_annot,
                        show_column_names = FALSE,
                        column_order = order(cell_types))
  type_exprs
}

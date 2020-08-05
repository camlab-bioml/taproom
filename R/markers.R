

#' Read a marker yaml file
#' 
#' @param path Input file path (yaml file)
#' 
#' @examples 
#'         counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
#' @export
#' 
#' @return A marker list including cell type and state markers
#' 
#' @importFrom yaml read_yaml
read_markers <- function(path) {
  
  markers <- read_yaml(path)
  
  has_types <- "cell_types" %in% names(markers)
  has_states <- "cell_states" %in% names(markers)
  
  if(!(has_types | has_states)) {
    stop("Marker yaml file must have cell type or state information")
  }
  if(!has_types) {
    warning("Marker yaml file has no cell type information")
  }
  if(!has_states) {
    warning("Marker yaml file has no cell state information")
  }

  markers
}

#' Print information about marker genes
#' 
#' Print cell type and cell state marker info
#' 
#' @param markers A marker list from \code{read_markers}
#' 
#' @return Prints marker information
#' 
#' @examples 
#'         counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
#' @export
#' 
print_marker_info <- function(markers) {
  cell_types <- names(markers$cell_types)
  cat(crayon::bold("Cell types: "), paste(cell_types, collapse = ", "),"\n")
  
  cat(crayon::bold("Cell states:\n"))
  cell_states <- names(markers$cell_states)
  for(state in cell_states) {
    for(substate in names(markers$cell_states[[state]])) {
      cat(state, "|", crayon::silver(substate),'\n')
    }
  }
}



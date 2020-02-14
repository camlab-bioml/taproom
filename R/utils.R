

#' Convert from original SC_Dat.csv rownames to understandable ones
#' 
#' @param sce Input SingleCellExperiment
#' 
#' @importFrom utils data
#' @importFrom BiocGenerics rownames
#' @importFrom stringr str_locate str_sub
#' @importFrom plyr mapvalues
#' 
#' @export
tidy_rownames_jackson <- function(sce) {
  
  rn <- rownames(sce)
  
  ## The metal tag is always the 5 characters
  ## preceeding "Di"
  di_loc_start <- str_locate(rn, "Di")[,'start']
  metal_name <- str_sub(rn, di_loc_start -5, di_loc_start-1)
  metal_name[is.na(metal_name)] <- rn[is.na(metal_name)]
  
  
  suppressMessages({
    target_names <- mapvalues(metal_name, 
                    jackson_2020_tag_target$`Metal Tag`,
                    jackson_2020_tag_target$Target)
  })
  
  rownames(sce) <- target_names
  
  sce <- sce[rownames(sce) %in% jackson_2020_tag_target$Target,]
  blacklist <- c(
    "RutheniumTetroxide",
    "undefined"
  )
  
  sce <- sce[!(rownames(sce) %in% blacklist)]
  
  sce
}



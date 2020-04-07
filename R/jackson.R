## Methods for reading data from Jackson et al. 2020


#' Convert from original SC_Dat.csv rownames to understandable ones
#'
#' @param sce Input SingleCellExperiment
#'
#' @importFrom utils data
#' @importFrom BiocGenerics rownames
#' @importFrom stringr str_locate str_sub
#' @importFrom plyr mapvalues
#' @importFrom dplyr left_join mutate case_when filter
#' @importFrom tibble tibble
#'
#' @export
tidy_rownames_jackson <- function(sce) {

  jackson_2020_tag_target <- dplyr::rename(
    jackson_2020_tag_target,
    metal = `Metal Tag`,
    target = Target
  )

  ## this is duplicated with pan-cytokeratin
  jackson_2020_tag_target <- dplyr::filter(jackson_2020_tag_target, target != "Keratin Epithelial")

  rn <- rownames(sce)

  ## The metal tag is always the 5 characters
  ## preceeding "Di"
  di_loc_start <- str_locate(rn, "Di")[,'start']
  metal_name <- str_sub(rn, di_loc_start -5, di_loc_start-1)

  df <- tibble(
    original_rowname = rn,
    metal = metal_name
  )

  df <- left_join(df, jackson_2020_tag_target, by = "metal")

  df <- mutate(df,
               target = case_when(
                 original_rowname == "1031747Er167Di ECadhe" ~ "E-Cadherin",
                 original_rowname == "phospho Histone" ~ "phospho Histone",
                 original_rowname == "phospho mTOR" ~ "phospho mTOR",
                 original_rowname == "phospho S6" ~ "phospho S6",
                 target == "c-erbB-2 - Her2" ~ "Her2",
                 target == "Keratin 14 (KRT14)" ~ "Cytokeratin 14",
                 TRUE ~ target
               ))

  ## at this stage we don't care if the target is NA or ruthenium
  df <- filter(df, !(grepl("Ruthenium", target) | is.na(target)))

  ## there are 2 Histone H3s and 2 PR receptors that need renamed
  histone_rows <- grep("Histone H3", df$target)
  df$target[histone_rows] <- paste(df$target[histone_rows],
                                   "antibody", seq_along(histone_rows))

  pr_rows <- grep("Progesterone Receptor A/B", df$target)
  df$target[pr_rows] <- paste(df$target[pr_rows],
                                   "antibody", seq_along(pr_rows))



  sce <- sce[df$original_rowname,]
  rownames(sce) <- df$target

  sce
}

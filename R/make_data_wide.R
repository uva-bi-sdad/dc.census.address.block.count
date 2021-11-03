#' Cast the dataset to wide format with every measure in its own column
#'
#' @param df data.frame or data.table.
#' @import data.table
#' @export
#' @examples
#' data("de_bl_abc_2021_address_block_counts")
#' make_data_wide(de_bl_abc_2021_address_block_counts)
#' 
#' geoid year total_group_quarters total_housing_units
#' 1: 100010401001000 2021                    0                  41
#' 2: 100010401001001 2021                    0                  16
#' 3: 100010401001002 2021                    0                  30
#' 4: 100010401001003 2021                    0                  29
#' 5: 100010401001004 2021                    0                   2
#' ---                                                              
#' 20195: 100059900000007 2021                    0                   0
#' 20196: 100059900000008 2021                    0                   0
#' 20197: 100059900000009 2021                    0                   0
#' 20198: 100059900000010 2021                    0                   0
#' 20199:           TOTAL 2021                  508              448735
make_data_wide <- function(df) {
  df_copy <- data.table::copy(df)
  dt <- data.table::setDT(df_copy)
  data.table::dcast(dt, geoid + year ~ measure, value.var = "value")
}

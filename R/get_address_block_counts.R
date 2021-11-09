#' Get the address block count data for a state.
#' Leaving outdir blank will provide the data directly.
#' If outdir is not blank, the data file will be saved to the directory specified.
#'
#' @param state_abbrv 2-letter state abbreviation.
#' @param outdir target directory if downloading the file.
#' @import dataverse
#' @import readr
#' @export
#' @examples
#' get_address_block_counts("AL")
# # A tibble: 371,954 × 4
# # geoid            year measure             value
# # <chr>           <dbl> <chr>               <dbl>
# # 1 010010201001000  2021 total_housing_units     8
# # 2 010010201001001  2021 total_housing_units    19
# # 3 010010201001002  2021 total_housing_units    17
# # 4 010010201001003  2021 total_housing_units    11
# # 5 010010201001004  2021 total_housing_units     0
# # 6 010010201001005  2021 total_housing_units     0
# # 7 010010201001006  2021 total_housing_units     1
# # 8 010010201001007  2021 total_housing_units     0
# # 9 010010201001008  2021 total_housing_units     0
# # 10 010010201001009  2021 total_housing_units     0
# # … with 371,944 more rows
get_address_block_counts <- function(state_abbrv = "AL", outdir = "") {
  srv <- "dataverse.lib.virginia.edu"
  doi <- "doi:10.18130/V3/NAZO4B"
  state <- tolower(state_abbrv)
  data_file_name <- paste0(state, "_bl_abc_2021_address_block_counts.csv.xz")
  meta_file_name <- "us_bl_abc_2021_address_block_counts_metadata.json"
  
  f <- dataverse::get_file_by_name(
    filename = data_file_name,
    dataset = doi,
    server = srv
  )
  
  d <- dataverse::dataset_metadata(
    dataset = doi,
    version = ":latest",
    block = "citation",
    server = srv
  )
  
  if (outdir == "") {
    tmp_file <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".xz")
    writeBin(f, tmp_file, data_file_name)
    pkg <- list(data = readr::read_csv(xzfile(tmp_file)),
         metadata = jsonlite::toJSON(d))
    return(pkg)
  } else {
    data_file_path <- paste0(outdir, "/", data_file_name) 
    writeBin(f, data_file_path)
    lines <- readr::read_lines(df <- xzfile(data_file_path))
    readr::write_lines(lines, gsub(".xz$", "", data_file_path))
    jsonlite::write_json(d, paste0(outdir, "/", meta_file_name), pretty = TRUE)
  }
}

# pkg <- get_address_block_counts(outdir = "data-raw")


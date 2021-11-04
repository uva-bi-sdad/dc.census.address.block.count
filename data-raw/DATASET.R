## code to prepare `DATASET` goes here

# download and save census address block counts
library(readr)
library(stringr)
library(rvest)
library(data.table)
library(usethis)
library(dataverse)
library(here)

state_codes <- setDT(unique(tigris::fips_codes[, c("state", "state_code", "state_name")]))

url <- "https://www.census.gov/geographies/reference-files/2020/geo/2020addcountlisting.html"
urls_page_html <- read_html(url) 
urls <- data.table( url = paste0("https://", str_match_all(urls_page_html, "www2.census.gov/geo/docs/reference/2020addresscountlist.*?\\.txt")[[1]][,1]))
urls[, state_code := str_match(url, "([0-9][0-9])_")[,2]]
urls_state <- unique(merge(urls, state_codes, by = "state_code", all.x = TRUE))

for (i in 1:nrow(urls_state)) {
  url <- urls_state[i]$url
  print(url)
  ds_name <- paste0(tolower(urls_state[i]$state), "_bl_abc_2021_address_block_counts")
  ds <- setDT(read_delim(url, "|"))
  ds <- ds[, c("BLOCK_GEOID", "TOTAL HOUSING UNITS", "TOTAL GROUP QUARTERS")]
  colnames(ds) <- c("geoid", "total_housing_units", "total_group_quarters")
  ds[, year := as.integer(2021)]
  
  ds <- melt(ds, id.vars = c("geoid", "year"), variable.name = "measure")
  ds[, measure := as.character(measure)]
  
  attr(ds, "variables") <- c("geoid" = "Concatenation of U.S. Census STATE, COUNTY, TRACT, and BLOCK ids (15 digits).", 
                             "year" = "Year in which data was collected.", 
                             "measure" = "Name of the measurement variable.", 
                             "value" = "Recorded value of the measurement value.")
  attr(ds, "rows") <- nrow(ds)
  attr(ds, "region_types") <- c("block" = "U.S. Census Block, 15 digits")
  attr(ds, "measures") <- c("total_housing_units" = "Total number of addresses in the entity count list identified as housing units or transitory units by data in the Master Address File (MAF).",
                            "total_group_quarters" = "Total number of addresses in the entity count list identified as group quarters by data in the MAF.")
  attr(ds, "measure_types") <- c("total_housing_units" = "count", "total_group_quarters" = "count")
  attr(ds, "measure_units") <- c("total_housing_units" = "housing unit", "total_group_quarters" = "group quarters")
  attr(ds, "source") <- url
  
  
  # create package dataset with usethis::use_data
  assign(ds_name, ds)
  # do.call("use_data", list(as.name(ds_name), compress = "xz", overwrite = TRUE))
  # do.call("rm", list(as.name(ds_name)))
  
  # readr::write_csv(get(ds_name), here::here(paste0("data/", ds_name, ".csv")))
  # zip(here::here(paste0("data/", ds_name, ".csv.zip")), here::here(paste0("data/", ds_name, ".csv")))
  # rm(here::here(paste0("data/", ds_name, ".csv")))
  
  readr::write_csv(get(ds_name), xzfile(here::here(paste0("data/", ds_name, ".csv.xz")), compression = 9))
  
  
  dat_file_path <- here::here(paste0("data/", ds_name, ".csv.xz"))
  add_dataset_file(file = dat_file_path,
                   dataset = "doi:10.18130/V3/NAZO4B",
                   server   = "dataverse.lib.virginia.edu",
                   description = ds_name)
}

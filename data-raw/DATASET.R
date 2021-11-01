## code to prepare `DATASET` goes here

# download and save census address block counts
library(readr)
library(stringr)
library(rvest)
library(data.table)
library(usethis)

state_codes <- setDT(unique(tigris::fips_codes[, c("state", "state_code")]))

url <- "https://www.census.gov/geographies/reference-files/2020/geo/2020addcountlisting.html"
urls_page_html <- read_html(url) 
urls <- data.table( url = paste0("https://", str_match_all(urls_page_html, "www2.census.gov/geo/docs/reference/2020addresscountlist.*?\\.txt")[[1]][,1]))
urls[, state_code := str_match(url, "([0-9][0-9])_")[,2]]
urls_state <- unique(merge(urls, state_codes, by = "state_code", all.x = TRUE))

for (i in 1:nrow(urls_state)) {
  url <- urls_state[i]$url
  print(url)
  ds_name <- paste0(tolower(urls_state[i]$state), "_bl_abc_2021_address_block_counts")
  ds <- read_delim(url, "|")
  ds <- ds[, c("BLOCK_GEOID", "TOTAL HOUSING UNITS", "TOTAL GROUP QUARTERS")]
  colnames(ds) <- c("geoid", "total_housing_units", "total_group_quarters")
  ds$total_housing_units <- as.integer(ds$total_housing_units)
  ds$total_group_quarters <- as.integer(ds$total_group_quarters)
  assign(ds_name, ds)
  do.call("use_data", list(as.name(ds_name), overwrite = TRUE))
  do.call("rm", list(as.name(ds_name)))
}

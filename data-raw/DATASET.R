## code to prepare `DATASET` goes here

# download and save census address block counts
library(readr)
url <- "https://www2.census.gov/geo/docs/reference/2020addresscountlist/51_Virginia_AddressBlockCountList_092021.txt"
va_bl_abc_2021_address_block_counts <- read_delim(url, "|")
va_bl_abc_2021_address_block_counts$STATE <- as.character(va_bl_abc_2021_address_block_counts$STATE)
va_bl_abc_2021_address_block_counts$BLOCK <- as.character(va_bl_abc_2021_address_block_counts$BLOCK)
usethis::use_data(va_bl_abc_2021_address_block_counts, overwrite = TRUE)

library(stringr)
library(readr)

state_codes <- setDT(unique(tigris::fips_codes[, c("state", "state_code", "state_name")]))

tbl_frmt_txt <- read_lines("data-raw/table_format.txt")

datasets <- list.files("data/")
datasets_no_suffix <- str_replace(datasets, ".rda", "")

for (d in datasets_no_suffix) {
  stateabbrev <- toupper(str_sub(d, 1, 2))
  statename <- state_codes[state==stateabbrev, state_name]
  statecode <- state_codes[state==stateabbrev, state_code]
  url <- urls_state[state_code==statecode, url]
  source_txt <- paste0("#' @source \\url{", url, "}")
  
  file_path <- paste0("R/", d, ".R")
  
  write_lines(paste0("#' Address Counts per Census Block for ", statename, "."), file_path, append = FALSE)
  write_lines("#.", file_path, append = TRUE)
  write_lines(tbl_frmt_txt, file_path, append = TRUE)
  write_lines(source_txt, file_path, append = TRUE)
  write_lines(paste0("\"", d, "\""), file_path, append = TRUE)
}

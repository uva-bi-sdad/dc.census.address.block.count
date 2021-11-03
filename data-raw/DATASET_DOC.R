library(stringr)
library(readr)

# document dataset
datasets_name <- "census_block_address_counts_2021"
datasets <- list.files("data", pattern = ".*block_counts.rda", full.names = TRUE)
ds <- load(datasets[2])

col_types <- sapply(get(ds), typeof)
col_names <- names(col_types)
col_types <- str_replace_all(col_types, c("character" = "chr", "integer" = "int", "double" = "dbl"))
names(col_types) <- col_names
source_txt <- paste0("#' @source \\url{", "https://www.census.gov/geographies/reference-files/2020/geo/2020addcountlisting.html", "}")
file_path <- paste0("R/", datasets_name, ".R")

write_lines(paste0("#' Address Counts of Housing Units and Group Quarters per Census Block for each U.S. State"), file_path, append = FALSE)
write_lines("#'", file_path, append = TRUE)
write_lines("#' Includes total housing units (including transitory units) and total group quarters counts, by 2020 census tabulation block.", file_path, append = TRUE)
write_lines("#' These housing unit and group quarters counts represent final counts for the 2020 Census.", file_path, append = TRUE)
write_lines("#'", file_path, append = TRUE)
write_lines(paste0("#' @format A tibble with variable rows and ", length(attr(get(ds), "variables")), " variables:"), file_path, append = TRUE)
write_lines("#' \\describe{", file_path, append = TRUE)
for (j in 1:length(attr(get(ds), "variables"))) {
  if (names(attr(get(ds), "variables")[j]) == "measure") {
    m_dt <- data.table(measure = names(attr(get(ds), "measures")), description = unname(attr(get(ds), "measures")))
    ms <- paste(m_dt$measure, "-", m_dt$description, collapse = "  ")
    # ms <- paste0("{\"measures\": ", jsonlite::toJSON(m_dt), "}")
    
    write_lines(paste0("#'   \\item{", names(attr(get(ds), "variables")[j]), "}{", col_types[[j]], " ", attr(get(ds), "variables")[[j]], "  ", ms, "}"), file_path, append = TRUE)
  } else {
    write_lines(paste0("#'   \\item{", names(attr(get(ds), "variables")[j]), "}{", col_types[[j]], " ", attr(get(ds), "variables")[[j]], "}"), file_path, append = TRUE)
  }
}
write_lines("#' }", file_path, append = TRUE)
write_lines(source_txt, file_path, append = TRUE)

write_lines(paste0("#' @name ", datasets_name), file_path, append = TRUE)
write_lines("#' @keywords datasets", file_path, append = TRUE)
write_lines(paste0("\"", ds, "\""), file_path, append = TRUE)

for (d in str_replace(basename(datasets), ".rda", "")) {
  write_lines(paste0("#' @rdname ", datasets_name), file_path, append = TRUE)
  write_lines(paste0("\"", d, "\""), file_path, append = TRUE)  
}


library(dataverse)
dataverse <- "biocomplexity"
dataset <- "doi:10.18130/V3/NAZO4B"

dataverse_search(
  "Biocomplexity",
  type = c("dataverse"),
  subtree = NULL,
  sort = c("name", "date"),
  order = c("asc", "desc"),
  per_page = 10,
  start = NULL,
  show_relevance = FALSE,
  show_facets = FALSE,
  fq = NULL,
  key = Sys.getenv("DATAVERSE_KEY"),
  server = Sys.getenv("DATAVERSE_SERVER"),
  verbose = TRUE,
  http_opts = NULL
)

two <- get_dataframe_by_id("24110", .f = readr::read_csv)

df_tab <-
  get_dataframe_by_name(
    filename = "BaiduNet_in_20200402.csv",
    dataset  = "doi:10.18130/V3/YQLJ5W",
    server   = "dataverse.lib.virginia.edu",
    .f = readr::read_csv
  )


publish_dataset(
  dataset = "doi:10.18130/V3/NAZO4B",
  minor = FALSE,
  key = Sys.getenv("DATAVERSE_KEY"),
  server = "dataverse.lib.virginia.edu"
)


ds_meta <- dataset_metadata(
  dataset,
  version = ":latest",
  block = "citation",
  key = Sys.getenv("DATAVERSE_KEY"),
  server = Sys.getenv("DATAVERSE_SERVER")
)

dv_meta <- dataverse_metadata(
  dataverse,
  key = Sys.getenv("DATAVERSE_KEY"),
  server = Sys.getenv("DATAVERSE_SERVER")
)

saveRDS(mtcars, tmp <- tempfile(fileext = ".rds"))
f <- add_dataset_file(tmp,
                      dataset = "doi:10.18130/V3/NAZO4B",
                      server   = "dataverse.lib.virginia.edu",
                      description = "mtcars")

rda <- load("../dc.census.address.block.count/data/mi_bl_abc_2021_address_block_counts.rda")

save(ak_bl_abc_2021_address_block_counts, tmp2 <- tempfile(fileext = ".rda"))


f <- add_dataset_file("",
                      dataset = "doi:10.18130/V3/NAZO4B",
                      server   = "dataverse.lib.virginia.edu",
                      description = "ak_bl_abc_2021_address_block_counts")


fo <- get_file_by_name(
  filename = "ak_bl_abc_2021_address_block_counts.rda",
  dataset = "doi:10.18130/V3/NAZO4B",
  key = Sys.getenv("DATAVERSE_KEY"),
  server = "dataverse.lib.virginia.edu"
)
writeBin(fo, "ak_bl_abc_2021_address_block_counts.rda")



seatblts <- Seatbelts
write.csv(seatblts, "seatbelts.csv", row.names = F)

add_dataset_file(file = "seatbelts.csv",
         dataset = "doi:10.18130/V3/NAZO4B",
         server   = "dataverse.lib.virginia.edu",
         description = "seatbelts")

ds_files <- dataset_files(
  dataset = "doi:10.18130/V3/NAZO4B",
  version = ":latest",
  key = Sys.getenv("DATAVERSE_KEY"),
  server = "dataverse.lib.virginia.edu"
)

f <- get_file_by_name(
  filename = "file54f7b5a2a41.rds",
  dataset = "doi:10.18130/V3/NAZO4B",
  key = Sys.getenv("DATAVERSE_KEY"),
  server = "dataverse.lib.virginia.edu"
)

df <- get_dataframe_by_name(
  filename = "file54f7b5a2a41.rds",
  dataset = "doi:10.18130/V3/NAZO4B",
  key = Sys.getenv("DATAVERSE_KEY"),
  server = "dataverse.lib.virginia.edu",
  .f = readr::read_rds
)

dft <- get_dataframe_by_name(
  filename = "ak_bl_abc_2021_address_block_counts.tab",
  dataset = "doi:10.18130/V3/NAZO4B",
  key = Sys.getenv("DATAVERSE_KEY"),
  server = "dataverse.lib.virginia.edu",
  .f = readr::read_tsv
)



update_dataset(
  dataset,
  body = '{"id":36437,"identifier":"V3/NAZO4B","persistentUrl":"https://doi.org/10.18130/V3/NAZO4B","protocol":"doi","authority":"10.18130","publisher":"University of Virginia Dataverse","publicationDate":"2021-11-04","storageIdentifier":"file://10.18130/V3/NAZO4B","datasetVersion":{"id":816,"datasetId":36437,"datasetPersistentId":"doi:10.18130/V3/NAZO4B","storageIdentifier":"file://10.18130/V3/NAZO4B","versionNumber":1,"versionMinorNumber":0,"versionState":"RELEASED","productionDate":"2021-11-04","lastUpdateTime":"2021-11-04T15:53:35Z","releaseTime":"2021-11-04T15:53:35Z","createTime":"2021-11-04T15:46:28Z","license":"CC0","termsOfUse":"CC0 Waiver","fileAccessRequest":false,"metadataBlocks":{"citation":{"displayName":"Citation Metadata","fields":[{"typeName":"title","multiple":false,"typeClass":"primitive","value":"Data Commons"},{"typeName":"author","multiple":true,"typeClass":"compound","value":[{"authorName":{"typeName":"authorName","multiple":false,"typeClass":"primitive","value":"Schroeder, Aaron"},"authorIdentifierScheme":{"typeName":"authorIdentifierScheme","multiple":false,"typeClass":"controlledVocabulary","value":"ORCID"}}]},{"typeName":"datasetContact","multiple":true,"typeClass":"compound","value":[{"datasetContactName":{"typeName":"datasetContactName","multiple":false,"typeClass":"primitive","value":"Schroeder, Aaron"}}]},{"typeName":"dsDescription","multiple":true,"typeClass":"compound","value":[{"dsDescriptionValue":{"typeName":"dsDescriptionValue","multiple":false,"typeClass":"primitive","value":"Dataset for the Data Commons"}}]},{"typeName":"subject","multiple":true,"typeClass":"controlledVocabulary","value":["Social Sciences (Ex: Education, Politics, Sociology, Economics, Psychology)"]},{"typeName":"productionDate","multiple":false,"typeClass":"primitive","value":"2021-11-04"},{"typeName":"depositor","multiple":false,"typeClass":"primitive","value":"Schroeder, Aaron"},{"typeName":"dateOfDeposit","multiple":false,"typeClass":"primitive","value":"2021-11-04"}]}},"files":[],"citation":"Schroeder, Aaron, 2021, \"Data Commons\", https://doi.org/10.18130/V3/NAZO4B, University of Virginia Dataverse, V1"}}',
  key = Sys.getenv("DATAVERSE_KEY"),
  server = Sys.getenv("DATAVERSE_SERVER")
)

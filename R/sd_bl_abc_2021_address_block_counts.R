#' Address Counts per Census Block for South Dakota.
#.
#'
#' Includes total housing units (including transitory units) and total group quarters counts, by 2020 census tabulation block.
#' These housing unit and group quarters counts represent final counts for the 2020 Census.
#'
#' @format A tibble with 163,492 rows and 7 variables:
#' \describe{
#'   \item{geoid}{chr Concatenation of STATE, COUNTY, TRACT, and BLOCK geo codes}
#'   \item{TOTAL HOUSING UNITS}{num Total number of addresses in the entity count list identified as housing units or transitory units by data in the Census Master Address File (MAF).}
#'   \item{TOTAL GROUP QUARTERS}{num Total number of addresses in the entity count list identified as group quarters by data in the MAF.}
#' }
#' @source \url{https://www2.census.gov/geo/docs/reference/2020addresscountlist/46_SouthDakota_AddressBlockCountList_092021.txt}
"sd_bl_abc_2021_address_block_counts"

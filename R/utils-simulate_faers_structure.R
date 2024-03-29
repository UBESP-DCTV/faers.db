# The following function it's just for testing!
# It generates a series of folders and files simulating the correct structure of
# FAERS data folder (sorry for the for loop, but it's a function that will not
# be used anyway...)
simulate_faers_structure <- function(path) {
  faers_meta <- fetch_faers_meta()
  for (i in seq_len(nrow(faers_meta))) {
    cyear <- faers_meta[[i, "year"]]
    cquarter <- faers_meta[[i, "quarter"]]
    dir.create(
      file.path(
        glue::glue("{path}"),
        "faers_raw_data",
        glue::glue("{cyear}/{cquarter}")
      ),
      recursive = TRUE
    )
    file.create(
      file.path(
        glue::glue("{path}"),
        "faers_raw_data",
        glue::glue("{cyear}/{cquarter}"),
        glue::glue("faers_ascii_{cyear}{cquarter}.zip")
      )
    )
    file.create(
      file.path(
        glue::glue("{path}"),
         "faers_raw_data",
        glue::glue("{cyear}/{cquarter}"),
        glue::glue("faers_xml_{cyear}{cquarter}.zip")
      )
    )
  }
}

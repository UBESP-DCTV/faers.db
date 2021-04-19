#' Read faers data
#'
#' The `read_faers()` functions read FAERS data into a well formatted
#' tibble.
#'
#' @param path (chr) path to the FAERS `.txt` to read.
#'
#' @export
#'
#' @return a [tibble][tibble::tibble-package] for the FAERS table in `path`.
#'
#' @name read_faers
#'
#' @details The `read_faers()` function can automaticaly read seven different
#' FAERS dataset: demo, drug, indi, outc, reac, rpsr and ther.
#' It convert and adapt dataset before version 2014Q4 with the new version.
#' Moreover, it adds a new coloums called 'period', in order to identify
#' the time release of dataset
#' @examples
#'   \dontrun{
#'     faers_db <- read_faers(
#'     path = "path_demo21Q1.txt"
#'     )
#'
#'     demo_db <- read_demo(
#'     path = "path_demo21Q1.txt"
#'     )
#'
#'     identical(faers_db, demo_db)
#'     TRUE
#'   }
#'

read_faers <- function(path) {
  switch(name_from_path(path),
    demo = read_demo(path),
    drug = read_drug(path),
    indi = read_indi(path),
    outc = read_outc(path),
    reac = read_reac(path),
    rpsr = read_rpsr(path),
    ther = read_ther(path),
    stop(paste0("Path not found or incorrect form.",
               "Path must end as xxx/demo21q1.txt"
    ))
  )
}



read_demo <- function(path) {
    if ((year_from_path(path) < 14L) |
        (year_from_path(path) == 14L & quarter_from_path(path) < 4L)) {
      readr::read_delim(path, delim = "$") %>%
        dplyr::rename(sex = .data$gndr_cod) %>%
        dplyr::mutate(
          auth_num = NA_character_,
          lit_ref = NA_character_,
          age_grp = NA_character_,
          period = period_from_path(path),
          dplyr::across(
            dplyr::all_of(c(
              "i_f_code", "rept_cod", "mfr_sndr", "sex", "e_sub", "to_mfr",
              "occp_cod"
            )),
            as.factor
          ),
          dplyr::across(dplyr::all_of(c("caseid", "caseversion", "age")),
            as.integer
          ),
          dplyr::across(dplyr::ends_with("dt"),
           ~lubridate::parse_date_time(.x,
            orders = c("%Y%m%d", "%Y%m", "%Y"))
          )
        ) %>%
        dplyr::rename(, rept_dt = .data$` rept_dt`)
    }
    else{
      readr::read_delim(path, delim = "$",
                        col_types = readr::cols(
                          auth_num = readr::col_character(),
                          lit_ref = readr::col_character()
                        )
      ) %>%
        dplyr::mutate(
          dplyr::across(
            dplyr::all_of(c(
              "i_f_code", "rept_cod", "mfr_sndr", "sex", "e_sub", "to_mfr",
              "occp_cod"
            )),
            as.factor
          ),
          dplyr::across(dplyr::all_of(c("caseid", "caseversion", "age")),
            as.integer
          ),
          dplyr::across(dplyr::ends_with("dt"),
            ~lubridate::parse_date_time(.x,
              orders = c("%Y%m%d", "%Y%m", "%Y")
            )
          ),
          period = period_from_path(path))
    }
  }


read_drug <- function(path) {
  if ((year_from_path(path) < 14L) |
      (year_from_path(path) == 14L & quarter_from_path(path) < 4L))  {
    readr::read_delim(path, delim = "$",
                      col_types = readr::cols(
                        exp_dt = readr::col_double(),
                        cum_dose_unit = readr::col_character(),
                        lot_nbr = readr::col_character(),
                        nda_num = readr::col_double()
      )
    ) %>%
      dplyr::rename(lot_num = .data$lot_nbr) %>%
      dplyr::mutate(
        dplyr::across(dplyr::all_of(c("role_cod",  "dechal", "rechal")),
                      as.factor
        ),
        dplyr::across(dplyr::all_of(c("caseid", "dose_amt", "drug_seq")),
          as.integer
        ),
        dplyr::across("cum_dose_chr", as.numeric),
        dplyr::across(dplyr::ends_with("dt"),
          ~lubridate::parse_date_time(.x,
            orders = c("%Y%m%d", "%Y%m", "%Y")
          )
        ),
        period = period_from_path(path),
        prod_ai = NA_character_
      )
  }
  else{
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(
      exp_dt = readr::col_double(),
      cum_dose_unit = readr::col_character(),
      lot_num = readr::col_character(),
      nda_num = readr::col_double()
    )
  ) %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("role_cod",  "dechal", "rechal")),
        as.factor
      ),
      dplyr::across(dplyr::all_of(c("caseid", "dose_amt", "drug_seq")),
        as.integer
      ),
      dplyr::across("cum_dose_chr", as.numeric),
      dplyr::across(dplyr::ends_with("dt"),
        ~lubridate::parse_date_time(.x,
          orders = c("%Y%m%d", "%Y%m", "%Y")
        )
      ),
      period = period_from_path(path)
    )
  }
}


read_indi <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("caseid", "indi_drug_seq")),
        as.integer
      )
    ) %>%
    dplyr::mutate(period = period_from_path(path))
}


read_outc <- function(path) {
  if ((year_from_path(path) < 14L) |
      (year_from_path(path) == 14L & quarter_from_path(path) < 4L)) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::rename(outc_cod = .data$outc_code) %>%
    dplyr::mutate(
      dplyr::across("outc_cod", as.factor),
      dplyr::across(dplyr::all_of("caseid"), as.integer),
      period = period_from_path(path)
    )
  }
  else {
    readr::read_delim(path, delim = "$") %>%
      dplyr::mutate(
        dplyr::across("outc_cod", as.factor),
        dplyr::across(dplyr::all_of("caseid"), as.integer),
        period = period_from_path(path)
      )
  }
}


read_reac <- function(path) {
  if ((year_from_path(path) < 14L) |
      (year_from_path(path) == 14L & quarter_from_path(path) < 4L)) {
    readr::read_delim(path, delim = "$") %>%
      dplyr::mutate(
        dplyr::across(dplyr::all_of("caseid"), as.integer),
        drug_rec_act = NA_character_,
        period = period_from_path(path)
      )
  }
  else {
    readr::read_delim(path, delim = "$",
      col_types = readr::cols(drug_rec_act = readr::col_character())) %>%
      dplyr::mutate(
        dplyr::across(dplyr::all_of("caseid"), as.integer),
        period = period_from_path(path)
      )
  }
}

read_rpsr <- function(path) {
  readr::read_delim(path, delim = "$") %>%
    dplyr::mutate(
      dplyr::across("rpsr_cod", as.factor),
      dplyr::across("caseid", as.integer),
      period = period_from_path(path)
    )
}

read_ther <- function(path) {
  readr::read_delim(path, delim = "$",
    col_types = readr::cols(
      dur = readr::col_double(),
      dur_cod =  readr::col_character()
    )
  ) %>%
    dplyr::mutate(
      dplyr::across(dplyr::all_of(c("caseid", "dsg_drug_seq")),
        as.integer
      ),
      dplyr::across(dplyr::ends_with("dt"),
        ~lubridate::parse_date_time(.x,
          orders = c("%Y%m%d", "%Y%m", "%Y")
        )
      ),
      period = period_from_path(path)
    )
}


period_from_path <- function(path) {
  start_substring <- -8L
  end_substring <- -5L
  stringr::str_sub(path, start_substring, end_substring)
}


year_from_path <- function(path) {
  start_substring <- -8L
  end_substring <- -7L
  stringr::str_sub(path, start_substring, end_substring)
}

quarter_from_path <- function(path) {
  start_substring <- -5L
  end_substring <- -5L
  stringr::str_sub(path, start_substring, end_substring)
}

name_from_path <- function(path) {
  start_substring <- -12L
  end_substring <- -9L
  name <- stringr::str_sub(path, start_substring, end_substring)
  stringr::str_to_lower(name)
}

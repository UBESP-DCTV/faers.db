#' ---
#' title: "Setup (with `{renv}`)"
#' author: "Corrado Lanera"
#' date: "`r date()`"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#'     keep_md: true
#' ---
#'
#' ```{r setup, include=FALSE}
#' knitr::opts_chunk$set(
#'   echo = TRUE,
#'   eval = FALSE
#' )
#' ```
#'
#' > NOTE: For projects which would not use `{renv}` support,
#'         see `01-pkgsetup.R` (here, in this gist).
#'


#'
#' Prerequisites
#' ====================================================================
#'

# install.packages("usethis")
# install.packages("available")
available::available("faers.db")
usethis::create_package("~/Documents/ubep/faers.db")

usethis::use_directory("dev", ignore = TRUE)
# install.packages("fs")
fs::file_create("dev/01-setup.R")
rstudioapi::navigateToFile("dev/01-setup.R")

#'
#' Copy there the whole content of this file, and keep track there
#' of everything you do in the setup process. You can omit
#' unnecessary comments and packages' installations.
#'

usethis::use_roxygen_md()
usethis::use_news_md()

#'
#' From now on, document everything into the `NEWS.md`
#' To fill the NEWS, refer to
#' [this](https://style.tidyverse.org/news.html)
#'


#'
#' Documentiation
#' ====================================================================
#'
#' DESCRIPTION
#' --------------------------------------------------------------------
#'
#' Update/fill the DESCRIPTION file. Remember to include in the
#' `Authors@R` field at least:
#'
#' - aut: author(s)
#' - cre: mantainer of the package (only one)
#' - cph: copyright holder(s)
#'
#' eg:
#'
c(
  person(
    given = "Corrado",
    family = "Lanera",
    role = c("aut", "cre"),
    email = "corrado.lanera@gmail.com",
    comment = c(ORCID = "0000-0002-0520-7428")
  ),
  person(
    given = "UBESP",
    role = c("cph")
  )
)

usethis::use_package_doc()




#'
#' README
#' --------------------------------------------------------------------
#'
#' Initialize the README file (ie the package's landing page)
#'

# install.packages("rmarkdown")
usethis::use_readme_rmd()
# usethis::use_logo("path/to/package_logo.png") # not in the pkg folder!
usethis::use_cran_badge()
usethis::use_lifecycle_badge("Maturing")

#'
#' Our package is not on CRAN, change the README accordingly:
#'
#'    You can install the development version from
#'    [GitHub](https://github.com/) with the following procedure:
#'
#'    ```{r, eval = FALSE}
#'    # install.packages("devtools")
#'    devtools::install_github("CorradoLanera/<package_name>")
#'    ```
#'
#' Remove everything else that is not necessary and
#'

usethis::use_code_of_conduct()

usethis::use_spell_check()
spelling::spell_check_package()
spelling::update_wordlist()

#'
#' > knit the README
#'








#'
#' Supporting Folders
#' ====================================================================
#'
#' Data raw
#' --------------------------------------------------------------------
#'
#' If raw data are stored inside the main package folder call

# usethis::use_data_raw() # at the moment we do not need data-raw
# on github

#'
#' and comment the line with `usethis::use_data(...)` in it until it
#' will be used.
#'




#'
#' Add pipe (`|>`) support
#' --------------------------------------------------------------------
#'
usethis::use_pipe()




#'
#' Test suit
#' ====================================================================
#'
usethis::use_testthat()

#'
#' Create a simple test to check everything works.
#' You can delete it AFTER you have written another test at least.
#'
#' Check it works:
#'
usethis::use_test("foo") # `test_that("foo works", expect_null(foo()))`
devtools::test()         # see it fails!!
usethis::use_r("foo")    # define `foo <- function() NULL`
devtools::test()         # see it passes!!

#'
#' delete `foo` only after have included another function!
#'








#'
#' Quality assurance
#' ====================================================================
#'
usethis::use_tidy_description()

# install.packages("lintr)
lintr::lint_package()

#'
#' and fix the spelling script that lint
#' have opened... ;-)
#'
if (requireNamespace("spelling", quietly = TRUE)) {
  spelling::spell_check_test(
    vignettes = TRUE,
    error = FALSE,
    skip_on_cran = TRUE
  )
}

#'
#' Check again:
#'
lintr::lint_package()

devtools::check_man()
devtools::test()
devtools::check()








#'
#' Activate Git/GitHub
#' ====================================================================
#'
usethis::use_git()
usethis::git_vaccinate()
#'
#' Commit everything before to continue!
#'
# remember to open and activate PuTTY
usethis::use_github("UBESP-DCTV")

#'
#' > NOTE: If required set the upstream using your preferred
#' GUI^[GitKraken: https://www.gitkraken.com/invite/fas3vkyk is free,
#' multiplatform (Win, Mac, Linux),and super cool :-).], or by command
#' line running (on the Terminal):
#'
#'     git push --set-upstream origin master
#'

usethis::use_tidy_github()





#'
#' Activate {renv} for reproducibility
#' ====================================================================
#'
#' > Note: This should be done AFTER git initialization
#'
#' We will use "explicit" snapshot whith the intent
#' of capture what is included in the
#' DESCRIPTION file only.
#'
renv::init(settings = list(snapshot.type = "explicit"))
renv::status() # just to check








#'
#' Package website documentation
#' ====================================================================
#'
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/CorradoLanera/actions/master/pkgdown.yaml"
)
usethis::use_github_actions_badge("pkgdown")

#'
#' Bonus:
#'
renv::install("GuangchuangYu/badger")
badger::badge_custom("WEBsite", "click-me", "orange", "http://ubesp-dctv.github.io/faers.db/")
#'
#' And add it between title and logo in the README and knit it.
#'


#'
#' Continuous Integration
#' ====================================================================
#'
#' Lint (static code-quality checks)
#' --------------------------------------------------------------------
#'

usethis::use_github_action(
  url = "https://raw.githubusercontent.com/CorradoLanera/actions/master/lint-renv.yaml"
)
usethis::use_github_actions_badge("lint")

#'
#' WARNING: if you do not use {renv} for your project, call
#'
#'     usethis::use_github_action("lint")
#'     usethis::use_github_actions_badge("lint")
#'


#' R-CDM-check and coverage
#' --------------------------------------------------------------------
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/CorradoLanera/actions/master/R-CMD-check-renv.yaml"
)
usethis::use_github_actions_badge("R-CMD-check")

usethis::use_github_action(
  url = "https://raw.githubusercontent.com/CorradoLanera/actions/master/covr-renv.yaml"
)
usethis::use_github_actions_badge("test-coverage")



#'
#' Final checks and update version
#' ====================================================================
#'
usethis::use_tidy_description()
devtools::check_man()

spelling::spell_check_package()
spelling::update_wordlist()

lintr::lint_package()
renv::status()
devtools::check()

#'
#' > Update and knit the `README.Rmd`
#'
usethis::use_dev_version()








#'
#' Start to develop
#' ====================================================================
#'
fs::file_create("dev/02-development.R")
rstudioapi::navigateToFile("dev/02-development.R")
#'
#' commit and push...
#' Happy packaging!
#'









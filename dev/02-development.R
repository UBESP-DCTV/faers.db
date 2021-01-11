#' ---
#' title: "Development"
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


#'
#' Development history
#' ====================================================================
#' List here all the command executed during development of the package
#'

usethis::use_test("read_faers")
 usethis::use_r("read_faers")


# ...
# ...
# ...




#'
#' Check cycles
#' ====================================================================
#'
#' Before pushes
#' --------------------------------------------------------------------
#'
usethis::use_tidy_description()
spelling::spell_check_package()
spelling::update_wordlist()
devtools::check_man()




#'
#' Before pull requests
#' --------------------------------------------------------------------
#'
lintr::lint_package()
goodpractice::gp()

# The following calls run into your (interactive) session
# Use the corresponding RStudio button under the "Build"
# tab to execute them maintaining free your console
# (and running them in a non-interactive session)
devtools::test()
devtools::check()

#'
#' > Update the `NEWS.md` file
#'




#'
#' After pull request is merged
#' --------------------------------------------------------------------
#'
usethis::use_version()  # on master branch, w/ "major", "minor", "patch"
usethis::use_dev_version()  # on develop branch


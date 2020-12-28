# faers.db (development version)

* added the draft of the function for downloading FAERS data
* added `.lintr` to set the default linters
* added development skeleton `dev/02-development.R`

# faers.db 0.0.0.9000

* Added support to use the __pipe__ (`%>%`) operator.
* Added GitHub action for CI/CD automating lint, coverage, tests, and
  checks.
* Added support from `{renv}` package management system for
  reproducibility of all the results.
* Added instructions for contributions and getting help in the 
  `README.Rmd` and added them in the GitHub templates
  (including issues).
* Added support for unit test powered by the `{testthat}` package.
* Added support for potentially useful raw data to include in the
  package: created and `.Rbuildignore`d the `data-raw/` folder.
* Added support for spellcheck powered by the `{spelling}` package.
* Added a `README.Rmd` file to produce `README.md`, i.e., the project's
  home page.
* Added a `NEWS.md` file to track changes to the package.

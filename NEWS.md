# faers.db (development version)

* rename and refactor `list_of_faers_year()` into
  `years_from_faers_html()`
* refactored `fetch_faers_meta()` and `years_from_faers_html()` to have
  in input the FAERS' meta html. This way it is possible to download 
  the HTML only once.
* rename and refactor `import faers_html()` into `current_faers_html()`
  to directly access to `current_faers_meta_url()`.
* rename and refactor `list_of_faers_data` into `fetch_faers_meta()`.
    Now it always return a `tible`, using fixed internal parametrization
    for FAERS meta-data's URL. Internal computationl service function
    are extracted and tested.
* refactor `compose_faers_link()` with the updated `check_year()`.
* refactor `check_year()` to always return booleans.
* added a function to download FAERS data.
* added `.lintr` to set the default linters.
* added development skeleton `dev/02-development.R`.

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

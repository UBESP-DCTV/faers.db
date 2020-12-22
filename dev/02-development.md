---
title: "Development"
author: "Corrado Lanera"
date: "Tue Dec 22 16:39:27 2020"
output:
  html_document:
    toc: true
    toc_float: true
    keep_md: true
---




Development history
====================================================================
List here all the command executed during development of the package



```r
# usethis::use_test("<function_name>")
# usethis::use_r("<function_name>")


# ...
# ...
# ...
```


Check cycles
====================================================================

Before pushes
--------------------------------------------------------------------



```r
usethis::use_tidy_description()
spelling::spell_check_package()
spelling::update_wordlist()
```


Before pull requests
--------------------------------------------------------------------



```r
lintr::lint_package()
goodpractice::gp()

# The following calls run into your (interactive) session
# Use the corresponding RStudio button under the "Build"
# tab to execute them maintaining free your console
# (and running them in a non-interactive session)
devtools::test()
devtools::check()
```


> Update the `NEWS.md` file


After pull request is merged
--------------------------------------------------------------------



```r
usethis::use_version()  # on master branch, w/ "major", "minor", "patch"
usethis::use_dev_version()  # on develop branch
```


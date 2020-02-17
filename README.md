
<!-- README.md is generated from README.Rmd. Please edit that file -->

# yamlpack

<!-- badges: start -->

<!-- badges: end -->

The goal of yamlpack is to …

## Installation

You can install the released version of yamlpack from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("yamlpack")
```

Or the development version from: -

``` r
# install.packages("devtools")
devtools::install_github("combiz/yamlpack")
```

## Example

The complete set of package names and sources currently installed can be
written to a YAML file using `write_yamlpack()`: -

``` r
library(yamlpack)
write_yamlpack()
#> 
#> ── Finding Installed Packages ─────────────────────────────────────────
#> ✓ Found 446 CRAN packages
#> ✓ Found 56 Bioconductor packages
#> ✓ Found 23 GitHub packages
#> 
#> ── Writing yamlpack YAML File ─────────────────────────────────────────
#> Writing: /home/ckhozoie/Documents/yamlpack/yamlpack.yml
#> ✓ Successfully exported 525 packages.
```

A YAML file previously saved with `write_yamlpack()` can be read using
`read_yamlpack()`: -

``` r
read_yamlpack()
#> 
#> ── Reading yamlpack YAML File ─────────────────────────────────────────
#> Reading: /home/ckhozoie/Documents/yamlpack/yamlpack.yml
#> ✓ Imported 446 CRAN packages
#> ✓ Imported 56 Bioconductor packages
#> ✓ Imported 23 GitHub packages
#> ✓ Successfully imported 525 packages.
```

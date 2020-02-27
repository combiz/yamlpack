################################################################################
#' Install Packages From a yamlpack YAML File
#'
#' @param yamlpack A yamlpack list read in with `read_yamlpack()`
#' @param repo one or more repos from the yamlpack to install (default all)
#' @param method Use conventional install or parallelize with the `pak` package
#' @param cran_url the CRAN url to use for CRAN packages
#'
#' @importFrom yaml read_yaml
#' @importFrom assertthat assert_that
#' @importFrom cli cli_h1
#' @importFrom BiocManager install
#' @importFrom devtools install_github
#' @importFrom pak pkg_install
#'
#' @export
install_yamlpack <- function(yamlpack,
                             repo = c("CRAN", "Bioconductor", "GitHub"),
                             method = "pak",
                             cran_url = "https://cran.ma.imperial.ac.uk/") {

  valid_repos <- c("CRAN", "Bioconductor", "GitHub")
  valid_methods <- c("standard", "pak")
  assertthat::assert_that(class(yamlpack) == "list")
  assertthat::assert_that(all(names(yamlpack) %in% valid_repos))
  assertthat::assert_that(all(repo %in% valid_repos))
  assertthat::assert_that(method %in% valid_methods)

  cli::cli_h1("Installing Packages")

  if (method == "standard") {
    for (repo_name in repo) {
      if (repo_name == "CRAN") {
        install.packages(pkgs = yamlpack$CRAN, dependencies = TRUE, repos = cran_url)
      } else if (repo_name == "Bioconductor") {
          BiocManager::install(yamlpack$Bioconductor)
      } else if (repo_name == "Github") {
          lapply(yamlpack$GitHub, devtools::install_github)
      }
    }
  } else if (method == "pak") {
      for (repo_name in repo) {
        lapply(yamlpack[[repo_name]], pak::pkg_install)
    }
  }


}

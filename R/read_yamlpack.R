################################################################################
#' Read a Previously Saved yamlpack File
#'
#' @param file_path Path to a yaml file previous saved with `write_yamlpack()`
#'
#' @return yml a YAML object
#'
#' @importFrom yaml read_yaml
#' @importFrom assertthat assert_that
#' @importFrom cli cli_h1
#'
#' @export
read_yamlpack <- function(file_path = file.path(getwd(), "yamlpack.yml")) {

  assertthat::assert_that(file.exists(file_path))

  cli::cli_h1("Reading {.emph yamlpack} YAML File")

  cli::cli_text("Reading: {.path {file_path}}")
  yamlpack_l <- yaml::read_yaml(file = file_path)

  for (repo in names(yamlpack_l)) {
    cli::cli_alert_success(
      sprintf("Imported %s {.strong %s} packages",
              length(yamlpack_l[[repo]]),
              repo))
  }

  n_packages <- sum(purrr::map_int(yamlpack_l, length))

  cli::cli_alert_success(
    "Successfully imported {.val {n_packages}} packages.")



}

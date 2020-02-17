################################################################################
#' Write Installed Packages And Sources To A yamlpack File
#'
#' @param file_path Path to save the yamlpack file
#'
#' @importFrom yaml write_yaml
#' @importFrom assertthat assert_that
#' @importFrom devtools package_info
#' @importFrom purrr map map_int
#' @importFrom dplyr filter select mutate
#' @importFrom data.table %like%
#' @importFrom cli cli_h1 cli_h2 cli_text cli_alert_success
#'
#' @export
write_yamlpack <- function(file_path = file.path(getwd(), "yamlpack.yml"),
                           overwrite = TRUE) {

  if (overwrite == FALSE) {
    assertthat::assert_that(
      !file.exists(file_path),
      msg = "This file already exists. To overwrite set TRUE.")
  }

  cli::cli_h1("Finding Installed Packages")
  yamlpack_l <- list()

  yamlpack_l[["CRAN"]] <- .find_cran_packages()
  yamlpack_l[["Bioconductor"]] <- .find_bioc_packages()
  yamlpack_l[["GitHub"]] <- .find_github_packages()
  .write_yamlpack_l(yamlpack_l, file_path)

}

#' @keywords internal
.find_cran_packages <- function() {

  pkgs <- installed.packages() %>%
    rownames() %>%
    devtools::package_info() %>%
    dplyr::filter(source %like% "CRAN") %>%
    dplyr::select(package) %>%
    unlist() %>%
    as.character()

  cli::cli_alert_success(
    sprintf("Found %s {.strong CRAN} packages", length(pkgs)))

  return(pkgs)

}

#' @keywords internal
.find_bioc_packages <- function() {

  pkgs <- installed.packages() %>%
    rownames() %>%
    devtools::package_info() %>%
    dplyr::filter(source %like% "Bioconductor") %>%
    dplyr::select(package) %>%
    unlist() %>%
    as.character()

  cli::cli_alert_success(
    sprintf("Found %s {.strong Bioconductor} packages", length(pkgs)))

  return(pkgs)

}

#' @keywords internal
.find_github_packages <- function() {

  pkgs <- installed.packages() %>%
    rownames() %>%
    devtools::package_info() %>%
    dplyr::filter(source %like% "Github") %>%
    dplyr::select(source) %>%
    dplyr::mutate(
      source = purrr::map(
        source,
        function(x) unlist(strsplit(x, "\\(|@"))[2])) %>%
    unlist() %>%
    as.character()

  cli::cli_alert_success(
    sprintf("Found %s {.strong GitHub} packages", length(pkgs)))

  return(pkgs)

}

#' Write the list to a yaml file
#' @param yamlpack_l a list of packages
#' @param file_path file path to save
#' @keywords internal
.write_yamlpack_l <- function(yamlpack_l, file_path) {

  cli::cli_h1("Writing {.emph yamlpack} YAML File")

  n_packages <- sum(purrr::map_int(yamlpack_l, length))

  yaml::write_yaml(yamlpack_l, file = file_path)

  cli::cli_text("Writing: {.path {file_path}}")

  cli::cli_alert_success(
    "Successfully exported {.val {n_packages}} packages.")

}


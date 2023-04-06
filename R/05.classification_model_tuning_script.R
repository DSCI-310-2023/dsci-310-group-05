#' Create a nearest neighbor specification object
#'
#' This function creates a specification object for use in training k-nearest
#' neighbor models for classification.The `weight_func` parameter specifies the
#' weight function to use and the specification object is returned for use in a
#' modeling workflow.
#'
#' @param weight_func A string specifying the weight function to use.
#' @return returns the specification object
#' @examples
#' create_knn_spec("rectangular")
create_knn_spec <- function(weight_func) {
  if (missing(weight_func)) {
    stop("weight_func must be provided.")
  }
  if (!is.character(weight_func)) {
    stop("weight_func must be a character string.")
  }
  if (nchar(weight_func) == 0) {
    stop("weight_func must not be an empty string.")
  }
  spec <-
    parsnip::nearest_neighbor(
      weight_func = weight_func,
      neighbors = tune()
    ) %>%
    parsnip::set_engine("kknn") %>%
    parsnip::set_mode("classification")
  return(spec)
}
#' Create a recipe for a dataframe
#'
#' This function creates a recipe object for use in a modeling workflow.
#' The recipe includes a formula where the response variable is the
#' `response_var`and all other columns in the input dataframe are used as
#' predictors. The recipe object also includes steps for scaling and centering
#' the predictor variables.
#'
#' @param data A dataframe containing the data.
#' @param response_var A string specifying the name of the response variable.
#' @return A recipe object for use in a workflow.
#' @examples
#' create_recipe(drug_data, "Cannabis")
create_recipe <- function(data, response_var) {
  if (is.null(data)) {
    stop("data must be provided.")
  }
  if (is.null(response_var)) {
    stop("response_var must be provided.")
  }
  if (!is.character(response_var)) {
    stop("response_var must be a character string.")
  }
  if (!response_var %in% colnames(data)) {
    stop("response_var must be a column in data.")
  }
  recipe <-
    recipes::recipe(as.formula(paste0(response_var, " ~ .")), data = data) %>%
    recipes::step_scale(all_predictors()) %>%
    recipes::step_center(all_predictors())
  return(recipe)
}
#' Create a v-fold cross-validation object
#'
#' This function creates a v-fold cross-validation object for use in a modeling
#' workflow.The number of folds is specified by the `v` argument. If a `strata`
#' argument is given, then the cross-validation will be stratified by that
#' variable.
#'
#' @param data A dataframe containing the data.
#' @param v An integer specifying the number of folds.
#' @param strata A string specifying the name of the strata variable, if any.
#' @return A v-fold cross-validation object for use in a workflow.
#' @examples
#' create_vfold(drug_data, 5, "Cannabis")
create_vfold <- function(data, v, strata) {
  if (is.null(v)) {
    stop("v must be provided.")
  }
  if (!is.numeric(v)) {
    stop("v must be a numeric value.")
  }
  if (v < 2) {
    stop("v must be greater than or equal to 2.")
  }
  vfold <-
    rsample::vfold_cv(data, v = v, strata = strata)
  return(vfold)
}

#' Create a grid of values to tune over
#'
#' This function generates a grid of values to tune over for the
#' number of nearest neighbors in the k-nearest neighbor classification model.
#' The grid includes integers ranging from the specified min_neighbors to
#' max_neighbors, inclusive.
#'
#' @param min_neighbors An integer specifying the minimum number of neighbors to
#'  include in the grid.
#' @param max_neighbors An integer specifying the maximum number of neighbors to
#'  include in the grid.
#' @return A tibble containing the grid of values to tune over.
#' @examples
#' create_grid(1, 30)
create_grid <- function(min_neighbors, max_neighbors) {
  if (is.null(min_neighbors)) {
    stop("min_neighbors must be provided.")
  }
  if (is.null(max_neighbors)) {
    stop("max_neighbors must be provided.")
  }
  if (!is.numeric(min_neighbors)) {
    stop("Input values must be numeric.")
  }
  if (!is.numeric(max_neighbors)) {
    stop("Input values must be numeric.")
  }
  if (min_neighbors < 1 || max_neighbors < 1) {
    stop("Input values must be greater than or equal to 1.")
  }
  if (min_neighbors > max_neighbors) {
    stop("Minimum value cannot be greater than maximum value.")
  }
  gridvals <-
    tibble::tibble(neighbors = seq(min_neighbors, max_neighbors))
  return(gridvals)
}

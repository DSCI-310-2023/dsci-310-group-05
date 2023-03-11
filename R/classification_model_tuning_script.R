
#' Create a nearest neighbor specification object
#' 
#' @param weight_func A string specifying the weight function to use.
#' @param neighbors An integer specifying the number of neighbors to use.
#' @return A nearest neighbor specification object for use in a workflow.
#' @export
create_knn_spec <- function(weight_func, neighbors) {
  nearest_neighbor(weight_func = weight_func, neighbors = neighbors) %>% 
    set_engine("kknn") %>% 
    set_mode("classification")
}


#' Create a recipe for a dataframe
#' 
#' @param data A dataframe containing the data.
#' @param response_var A string specifying the name of the response variable.
#' @return A recipe object for use in a workflow.
#' @export
create_recipe <- function(data, response_var) {
  recipe(as.formula(paste0(response_var, " ~ .")), data = data) %>% 
    step_scale(all_predictors()) %>% 
    step_center(all_predictors()) %>%
    prep() %>%
    return()
}


#' Create a v-fold cross-validation object
#' 
#' @param data A dataframe containing the data.
#' @param v An integer specifying the number of folds.
#' @param strata A string specifying the name of the strata variable, if any.
#' @return A v-fold cross-validation object for use in a workflow.
#' @export
create_vfold <- function(data, v, strata) {
  vfold_cv(data, v = v, strata = strata)
  return(vfold)
}


#' Create a grid of values to tune over
#' 
#' @param min_neighbors An integer specifying the minimum number of neighbors to include in the grid.
#' @param max_neighbors An integer specifying the maximum number of neighbors to include in the grid.
#' @return A tibble containing the grid of values to tune over.
#' @export
create_grid <- function(min_neighbors, max_neighbors) {
  gridvals <- tibble(neighbors = seq(min_neighbors, max_neighbors))
  return(gridvals)
}


#' Create a workflow object for the k-NN classification analysis
#' 
#' @param recipe A recipe object specifying the preprocessing steps.
#' @param spec A nearest neighbor specification object specifying the model.
#' @param vfold A v-fold cross-validation object specifying the resampling scheme.
#' @param gridvals A tibble specifying the grid of values to tune over.
#' @return A workflow object for the k-NN classification analysis.
#' @export
create_workflow <- function(recipe, spec, vfold, gridvals) {
  workflow() %>% 
    add_recipe(recipe) %>% 
    add_model(spec) %>% 
    tune_grid(resamples = vfold, grid = gridvals) %>% 
    collect_metrics() %>%
    return()
}

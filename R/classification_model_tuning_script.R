#' Create a nearest neighbor specification object
#' 
#' @param weight_func A string specifying the weight function to use.
#' @return returns the specification object
#' @examples create_knn_spec("rectangular")

create_knn_spec <- function(weight_func) {
  spec <- nearest_neighbor(weight_func = weight_func, neighbors = tune()) %>% 
    set_engine("kknn") %>% 
    set_mode("classification") 
    
    return(spec)
}


#' Create a recipe for a dataframe
#' 
#' @param data A dataframe containing the data.
#' @param response_var A string specifying the name of the response variable.
#' @return A recipe object for use in a workflow.
#' @examples create_recipe(drug_data, "Cannabis")

create_recipe <- function(data, response_var) {
  recipe <- recipe(as.formula(paste0(response_var, " ~ .")), data = data) %>% 
    step_scale(all_predictors()) %>% 
    step_center(all_predictors()) 
    
    return(recipe)
}


#' Create a v-fold cross-validation object
#' 
#' @param data A dataframe containing the data.
#' @param v An integer specifying the number of folds.
#' @param strata A string specifying the name of the strata variable, if any.
#' @return A v-fold cross-validation object for use in a workflow.
#' @examples create_vfold(drug_data, 5, "Cannabis")

create_vfold <- function(data, v, strata) {
  vfold <- vfold_cv(data, v = v, strata = strata)
  return(vfold)
}


#' Create a grid of values to tune over
#' 
#' @param min_neighbors An integer specifying the minimum number of neighbors to include in the grid.
#' @param max_neighbors An integer specifying the maximum number of neighbors to include in the grid.
#' @return A tibble containing the grid of values to tune over.
#' @examples create_grid(1, 30)

create_grid <- function(min_neighbors, max_neighbors) {
  gridvals <- tibble(neighbors = seq(min_neighbors, max_neighbors))
  return(gridvals)
}
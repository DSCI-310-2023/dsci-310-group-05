
set.seed(2)

library(tidymodels)

#' Tune k-Nearest Neighbor Classifier
#'
#' This function tunes a k-nearest neighbor (KNN) classifier for a binary classification problem using a rectangular weight function. It uses the kknn package to fit the KNN model and the rsample package for cross-validation. The number of neighbors is tuned over a specified range using a grid search approach. The function returns a workflow object that contains the performance metrics for each model trained over the hyperparameter grid.
#'
#' @param data A data frame containing the input data.
#' @param outcome_var A string indicating the name of the outcome variable in \code{data}.
#' @param nfolds An integer indicating the number of folds for cross-validation.
#'
#' @return A workflow object containing the performance metrics for each model trained over the hyperparameter grid.
#'
#' @import dplyr
#' @import kknn
#' @import rsample
#'
#' @examples
#' data("drug_data")
#' tune_kknn_classifier(drug_data, "Cannabis", 5)
#'
#' @export
tune_kknn_classifier <- function(data, outcome_var, nfolds) {
  # Define recipe for data preprocessing
  recipe <- recipe(as.formula(paste(outcome_var, "~ .")), data = data) %>% 
    step_scale(all_predictors()) %>% 
    step_center(all_predictors())
  
  # Define cross-validation object
  cv <- vfold_cv(data, v = nfolds, strata = data[[outcome_var]])
  
  # Define hyperparameter grid
  grid <- tibble(neighbors = seq(1, 30))
  
  # Define workflow for model training and hyperparameter tuning
  workflow <- workflow() %>% 
    add_recipe(recipe) %>% 
    add_model(nearest_neighbor(weight_func = "rectangular", neighbors = tune()) %>% 
                set_engine("kknn") %>% 
                set_mode("classification")) %>% 
    tune_grid(resamples = cv, grid = grid) %>% 
    collect_metrics()
  
  return(workflow)
}

result <- tune_kknn_classifier(drug_data, "Cannabis", 5)


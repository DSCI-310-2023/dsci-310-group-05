#' Train and Tune k-Nearest Neighbor Classifier
#'
#' This function takes a data frame containing the outcome variable and predictor variables,
#' and trains and tunes a k-nearest neighbor (KNN) classifier using the kknn package. 
#' The function returns a trained workflow object that can be used to make predictions on 
#' new data.
#'
#' @param data A data frame containing the outcome variable and predictor variables.
#' @param outcome The name of the outcome variable in \code{data}.
#'
#' @return A trained workflow object containing a tuned KNN classifier.
#'
#' @import kknn
#' @import dplyr
#' @import recipes
#' @import workflowsets
#' @import rsample
#'
#' @examples
#' data("drug_data")
#' trained_classifier <- train_and_tune_kknn_classifier(drug_data, "Cannabis")
#'
#' @export
train_and_tune_kknn_classifier <- function(data, outcome, nfolds) {
  # Set seed for reproducibility
  set.seed(2)
  
  # Specify KNN classifier with tuning parameter
  knn_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = tune()) %>% 
    set_engine("kknn") %>% 
    set_mode("classification")
  
  # Specify recipe for data pre-processing
  knn_recipe <- recipe(as.formula(paste(outcome, "~ .")), data = data) %>% 
    step_scale(all_predictors()) %>% 
    step_center(all_predictors())
  
  # Create cross-validation folds
  knn_vfold <- vfold_cv(data, v = nfolds, strata = !!sym(outcome))
  
  # Specify grid of tuning parameters
  knn_grid <- tibble(neighbors = seq(1, 30))
  
  # Train and tune KNN classifier using workflow
  knn_workflow <- workflow() %>% 
    add_recipe(knn_recipe) %>% 
    add_model(knn_spec) %>% 
    tune_grid(resamples = knn_vfold, grid = knn_grid) %>% 
    collect_metrics()
  
  return(knn_workflow)
}

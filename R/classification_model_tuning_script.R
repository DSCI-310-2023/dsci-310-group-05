#' Fit a k-nearest neighbor classifier and tune hyperparameters using cross-validation
#' 
#' 
#' @param data A data frame containing the predictor variables and "Cannabis" response variable
#' @param neighbors A vector of integers specifying the number of nearest neighbors to consider.
#' @param weight_func The weight function to use for prediction. 
#' @param v The number of folds for cross-validation.
#' 
#' @return A tibble containing the hyperparameters, metric values, and other information for each model evaluated during cross-validation
#' 
#' @examples
#' # Fit and tune k-nearest neighbor classifier
#' knn_result <- knn_tune(data = drug_data, neighbors = 1:30, v = 5)
#' }
#' 

knn_tune <- function(data, neighbors, weight_func = "rectangular", v) {
  
  # Define nearest neighbor specification
  knn_spec <- nearest_neighbor(weight_func = weight_func, neighbors = tune()) %>% 
    set_engine("kknn") %>% 
    set_mode("classification")
  
  # Define recipe
  recipe_obj <- recipe(as.formula(paste0(response_var, "~ .")), data = data) %>% 
    step_scale(all_predictors()) %>% 
    step_center(all_predictors())
  
  # Define cross-validation
  knn_vfold <- vfold_cv(data, v = v, strata = data[[response_var]])
  
  # Define grid of hyperparameters
  knn_grid <- tibble(neighbors = neighbors)
  
  # Define workflow
  knn_wf <- workflow() %>% 
    add_recipe(recipe_obj) %>% 
    add_model(knn_spec)
  
  # Tune hyperparameters and evaluate models
  knn_results <- knn_wf %>% 
    tune_grid(resamples = knn_vfold, grid = knn_grid) %>% 
    collect_metrics()
  
  write.csv(grouped, "data/knn_tune.csv")
}


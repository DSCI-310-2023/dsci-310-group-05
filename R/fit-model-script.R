#' Fit a k-nearest neighbor model with specified hyperparameters
#' 
#' @param data A data frame containing the predictor variables and "Cannabis" response variable
#' @param neighbors An integer specifying the number of nearest neighbors to consider.
#' @param weight_func The weight function to use for prediction. 
#' @param recipe_obj A pre-defined recipe object to use for data preprocessing.
#' 
#' @return A workflow object representing the fitted k-nearest neighbor model
#' 
#' @examples
#' # Fit k-nearest neighbor model with 23 neighbors
#' knn_fit <- fit_knn(data = drug_data, neighbors = 23)
#' 

fit_knn <- function(data = drug_data, recipe_obj, neighbors = 23, weight_func = "rectangular") {
  # Define nearest neighbor specification
  knn_real_spec <- nearest_neighbor(weight_func = weight_func, neighbors = neighbors) %>% 
    set_engine("kknn") %>% 
    set_mode("classification")
  
  # Define workflow
  knn_real_wf <- workflow() %>% 
    add_recipe(recipe_obj) %>% 
    add_model(knn_real_spec) %>% 
    fit(data = data)
  
  return(knn_wf)
}

# function inputs 

#Data
n <- 1000
mock_pred_data <- data.frame(
  predicted_outcome = sample(c("no", "yes"), n, replace = TRUE),
  X1 = rnorm(n),
  X2 = rnorm(n),
  X3 = rnorm(n)
)

#Test data
test_data <- data.frame(
  X1 = c(0.5, 0.1, 0.7),
  X2 = c(0.9, 0.3, 0.6),
  X3 = c(0.2, 0.4, 0.8)
)

mock_spec <- nearest_neighbor(weight_func = "rectangular", neighbors = tune()) %>% 
    set_engine("kknn") %>% 
    set_mode("classification")

mock_recipe <- recipe(as.formula(paste0("predicted_outcome", " ~ .")), data = mock_pred_data) %>% 
    step_scale(all_predictors()) %>% 
    step_center(all_predictors()) 

mock_knn_wf <- workflow() %>% 
  add_recipe(mock_recipe) %>% 
  add_model(mock_spec) %>% 
  fit(data = mock_pred_data)

# Call the function with the test data
result <- predict_drugs_workflow(mock_knn_wf, test_data)

# Define the expected outputs
mock_predictions <- predict(mock_knn_wf, test_data)

#expected outputs
expected_columns <- c(".pred_class", "X1", "X2", "X3")
expected_results <- c("no", "yes")
expected_predictions <- mock_predictions$.pred_class
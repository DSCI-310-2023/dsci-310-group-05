# function inputs

# Data
n <- 1000
mock_pred_data <- data.frame(
  predicted_outcome = sample(c("no", "yes"), n, replace = TRUE),
  X1 = rnorm(n),
  X2 = rnorm(n),
  X3 = rnorm(n)
)

# Test data
test_data <- data.frame(
  X1 = c(0.5, 0.1, 0.7),
  X2 = c(0.9, 0.3, 0.6),
  X3 = c(0.2, 0.4, 0.8)
)

mock_spec <- parsnip::nearest_neighbor(
  weight_func = "rectangular",
  neighbors = tune()
) %>%
  parsnip::set_engine("kknn") %>%
  parsnip::set_mode("classification")

mock_recipe <- recipes::recipe(as.formula(paste0("predicted_outcome", " ~ .")),
  data = mock_pred_data
) %>%
  recipes::step_scale(all_predictors()) %>%
  recipes::step_center(all_predictors())

mock_knn_wf <- workflows::workflow() %>%
  workflows::add_recipe(mock_recipe) %>%
  workflows::add_model(mock_spec) %>%
  parsnip::fit(data = mock_pred_data)

# Call the function with the test data
result <- pred_data <- stats::predict(mock_knn_wf, test_data) %>%
  dplyr::bind_cols(test_data)

# Define the expected outputs
mock_predictions <- stats::predict(mock_knn_wf, test_data)

# expected outputs
expected_columns <- c(".pred_class", "X1", "X2", "X3")
expected_results <- c("no", "yes")
expected_predictions <- mock_predictions$.pred_class
mock_pred_class <- "data.frame"
not_dataframe <- list(a = 1, b = 2, c = 3)

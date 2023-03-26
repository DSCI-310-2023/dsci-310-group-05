# function inputs for tests

df <- data.frame(
  Age = c(3, 5, 6, 7, 8, 9),
  Gender = c(-0.95197, 0.48246, -0.48246, -0.48246, 0.48246, -0.48246),
  Nscore = c(-0.14882, -0.67825, -0.46725, -1.32828, 0.62967, -0.24649),
  Escore = c(-0.80615, -0.30033, -1.09207, 1.93886, 2.57309, 0.00332),
  Oscore = c(-0.01928, -1.55521, -0.45174, -0.84732, -0.97631, -1.42424),
  Ascore = c(0.59042, 2.03972, -0.30172, -0.30172, 0.76096, 0.59042),
  Nicotine = c(0, 1, 1, 0, 1, 1),
  Cannabis = c("no", "no", "no", "no", "no", "no")
)

v_good <- 5
v_small <- 1
v_string <- "five"
min_neighbors <- 5
max_neighbors <- 10
response_var <- "Cannabis"
not_response_var <- "Test"
grid <- create_grid(min_neighbors, max_neighbors)
spec <- create_knn_spec(weight_func = "rectangular")
recipe <- create_recipe(df, response_var)
vfold <- create_vfold(df, v_good, response_var)

test_recipe <- create_recipe(df, response_var)
test_spec <- create_knn_spec("rectangular")
test_vfold <- create_vfold(df, v, response_var)
test_gridvals <- create_grid(min_neighbors, max_neighbors)


# expected function outputs

expected_mode <- "classification"
empty_weight_func <- ""
expected_engine <- "kknn"
expected_spec_class <- "model_spec"
expected_recipe_class <- "recipe"
expected_num_splits <- v
expected_vfold_class <- "vfold_cv"
expected_num_rows_grid <- max_neighbors - min_neighbors + 1
expected_tibble <- "tbl_df"

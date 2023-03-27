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
test_grid <- tibble::tibble(neighbors = seq(min_neighbors, max_neighbors))
test_spec <- parsnip::nearest_neighbor(
  weight_func = "rectangular",
  neighbors = tune()
) %>%
  parsnip::set_engine("kknn") %>%
  parsnip::set_mode("classification")

test_recipe <- recipes::recipe(as.formula(paste0(response_var, " ~ .")),
  data = df
) %>%
  recipes::step_scale(all_predictors()) %>%
  recipes::step_center(all_predictors())

test_vfold <- rsample::vfold_cv(df, v = v_good, strata = response_var)

# expected function outputs

expected_mode <- "classification"
empty_weight_func <- ""
expected_engine <- "kknn"
expected_spec_class <- "model_spec"
expected_recipe_class <- "recipe"
expected_num_splits <- v_good
expected_vfold_class <- "vfold_cv"
expected_num_rows_grid <- max_neighbors - min_neighbors + 1
expected_tibble <- "tbl_df"

library(testthat)
library(tidymodels)
library(dplyr)
library(purrr)

source("./R/classification_model_tuning_script.R")
source("./test/helper_classification-model-tuning-script.R")

# Test create_knn function

# Test case 1
test_that("create_knn_spec sets the mode to classification", {
  spec <- create_knn_spec(weight_func = "rectangular")
  expect_equal(spec$mode, expected_mode)
})

# Test case 2
test_that("create_knn_spec sets the engine to kknn", {
  expect_equal(spec$engine, expected_engine, "Expected engine to be kknn")
})

# Test case 3
test_that("create_knn_spec returns a model specification object", {
  expect_s3_class(spec, expected_spec_class)
})

# Test case 4
test_that("weight_func is a character", {
  expect_error(create_knn_spec(123), "weight_func must be a character")
})

# Test case 5
test_that("create_knn_spec throws an error when weight_func is empty", {
  expect_error(
    create_knn_spec(empty_weight_func),
    "weight_func must not be an empty string"
  )
})

# Test case 6
test_that("create_knn_spec throws an error when no weight_func is passed", {
  expect_error(
    create_knn_spec(),
    "weight_func must be provided"
  )
})


# Test create_recipe function

# Test case 1
test_that("create_recipe returns a recipe object", {
  expect_s3_class(recipe, expected_recipe_class)
})

# Test case 2
test_that("create_recipe throws an error if response variable not in dataset", {
  expect_error(
    create_recipe(df, not_response_var),
    "response_var must be a column in data."
  )
})

# Test case 3
test_that("create_recipe throws an error when data is missing", {
  expect_error(create_recipe(NULL, response_var), "data must be provided.")
})

# Test case 4
test_that("create_recipe throws an error when data is missing", {
  expect_error(create_recipe(df, NULL), "response_var must be provided.")
})

# Test case 5
test_that("create_recipe throws an error when data is missing", {
  expect_error(
    create_recipe(df, 123),
    "response_var must be a character string."
  )
})

# Test create_vfold function

# Test case 1
test_that("create_vfold returns a valid vfold object", {
  expect_is(vfold, expected_vfold_class)
  expect_equal(length(vfold$splits), expected_num_splits)
})

# Test case 2
test_that("create_vfold throws an error when v is missing", {
  expect_error(create_vfold(df, NULL, response_var), "v must be provided.")
})

# Test case 3
test_that("create_vfold throws an error when v is not numeric", {
  expect_error(
    create_vfold(df, v_string, response_var),
    "v must be a numeric value."
  )
})

# Test case 4
test_that("create_vfold throws an error when v is less than 2", {
  expect_error(
    create_vfold(df, v_small, response_var),
    "v must be greater than or equal to 2."
  )
})

# Test cases for create_grid

# Test case 1
test_that("create_grid creates a grid with the correct number of neighbors", {
  expect_equal(nrow(grid), expected_num_rows_grid)
})

# Test case 2
test_that("create_grid throws an error when input values are not numeric", {
  expect_error(create_grid("a", 5), "Input values must be numeric.")
  expect_error(create_grid(1, "b"), "Input values must be numeric.")
})

# Test case 3
test_that("create_grid throws an error when input values are less than 1", {
  expect_error(
    create_grid(0, 5),
    "Input values must be greater than or equal to 1."
  )
  expect_error(
    create_grid(1, -2),
    "Input values must be greater than or equal to 1."
  )
})

# Test case 4
test_that("create_grid throws an error when min_neighbors is greater
          than max_neighbors", {
  expect_error(
    create_grid(5, 2),
    "Minimum value cannot be greater than maximum value."
  )
})

# Test case 5
test_that("create_grid throws an error when min_neighbors is missing", {
  expect_error(create_grid(NULL, 5), "min_neighbors must be provided.")
})

# Test case 6
test_that("create_grid throws an error when max_neighbors is missing", {
  expect_error(create_grid(2, NULL), "max_neighbors must be provided.")
})

# Test case 7
test_that("create_grid returns a tibble", {
  expect_s3_class(create_grid(2, 5), expected_tibble)
})

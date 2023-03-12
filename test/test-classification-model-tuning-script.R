library(testthat)
library(tidymodels)
library(dplyr)
library(purrr)

source("./R/classification_model_tuning_script.R")
source("./test/helper_classification-model-tuning-script.R")

#Test create_knn function

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
  expect_s3_class(spec, expected_model_spec)
})

-------------------------------------------------------------------------------------

# Test create_recipe function

# Test case 1
test_that("create_recipe returns a recipe object", {
  expect_s3_class(recipe, expected_recipe_class)
})

# Test case 2
test_that("create_recipe throws an error if response variable not in dataset", {
  expect_error(create_recipe(df, "not_in_dataset"))
})

----------------------------------------------------------------------------------

#Test create_vfold function

#Test case 1 
test_that("create_vfold returns a valid vfold object", {
  expect_is(vfold, expected_vfold_class)
  expect_equal(length(vfold$splits), expected_num_splits)
})

--------------------------------------------------------------------------------

#Test cases for create_grid

#Test case 1
test_that("create_grid creates a grid with the correct number of neighbors", {
  expect_equal(nrow(grid), expected_num_rows_grid)
})

--------------------------------------------------------------------------------
#Test cases for create_workflow 
test_that("create_workflow creates a workflow correctly", {

  # Test case 1
  expect_s3_class(test_workflow, expected_workflow_class)
  
  # Test case 2
  expect_identical(names(test_workflow$steps), expected_workflow_steps)
  
  #Test case 3
  expect_identical(names(test_workflow$parameters), expected_workflow_parameters)
  
  #Test case 4
  expect_s3_class(test_workflow$model, expected_workflow_model)
})




















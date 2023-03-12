library(testthat)
source("./R/train-test-script.R")
source("./test/helper_train-test.R")

# Define test cases
test_that("split_dataset function returns a list with two data frames", {
  # Call the function
  set.seed(123)
  actual_split <- split_dataset(data_set, strata_variable, predictor)
  
  # Test that the function returns a list with two data frames
  expect_is(actual_split, "list")
  expect_equal(length(actual_split), 2)
  expect_is(actual_split[[1]], "data.frame")
  expect_is(actual_split[[2]], "data.frame")
})

test_that("split_dataset function splits data set into training and testing sets correctly", {
  # Call the function
  set.seed(123)
  actual_split <- split_dataset(data_set, strata_variable, predictor)
  
  # Test that the training set has the expected number of observations
  expect_equal(nrow(actual_split[[1]]), nrow(expected_training_data))
  
  # Test that the testing set has the expected number of observations
  expect_equal(nrow(actual_split[[2]]), nrow(expected_testing_data))
  
  # Test that the training set and testing set are mutually exclusive
  expect_equal(intersect(rownames(actual_split[[1]]), rownames(actual_split[[2]])), character(0))
})

test_that("split_dataset function splits data set into training and testing sets with correct proportion", {
  # Call the function
  set.seed(123)
  actual_split <- split_dataset(data_set, strata_variable, predictor)
  
  # Test that the proportion of observations in the training set is correct
  expect_equal(nrow(actual_split[[1]]) / nrow(data_set), 0.75, tolerance = 0.02)
  
  # Test that the proportion of observations in the testing set is correct
  expect_equal(nrow(actual_split[[2]]) / nrow(data_set), 0.25, tolerance = 0.02)
})



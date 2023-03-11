library(testthat)
source("./../R/train-test-script.R")

# Define test data
test_data <- data.frame(strata = c("a", "a", "b", "b"), predictor = c("no", "yes", "no", "yes"))

# Define expected output
expected_training_data <- data.frame(strata = c("a", "a"), predictor = c(0, 1))
expected_testing_data <- data.frame(strata = c("b", "b"), predictor = c(0, 1))

# Test that split_dataset() creates the correct training data
test_that("split_dataset creates correct training data", {
  split_dataset(test_data, "strata", "predictor")
  training_data <- read.csv("data/training_data.csv")
  expect_equal(nrow(training_data), nrow(expected_training_data))
  expect_equal(ncol(training_data), ncol(expected_training_data))
  expect_identical(training_data, expected_training_data)
})

# Test that split_dataset() creates the correct testing data
test_that("split_dataset creates correct testing data", {
  split_dataset(test_data, "strata", "predictor")
  testing_data <- read.csv("data/testing_data.csv")
  expect_equal(nrow(testing_data), nrow(expected_testing_data))
  expect_equal(ncol(testing_data), ncol(expected_testing_data))
  expect_identical(testing_data, expected_testing_data)
})

# Test that split_dataset() throws an error if strata variable is missing
test_that("split_dataset throws an error if strata variable is missing", {
  expect_error(split_dataset(test_data, "", "predictor"))
})

# Test that split_dataset() throws an error if predictor variable is missing
test_that("split_dataset throws an error if predictor variable is missing", {
  expect_error(split_dataset(test_data, "strata", ""))
})
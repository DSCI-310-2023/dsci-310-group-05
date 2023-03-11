library(testthat)
source("../../R/model-accuracy-script.R")

# Create a test data frame with known Cannabis values
test_data <- data.frame(Cannabis = c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No"), 
                        .pred_class = c("Yes", "No", "No", "No", "Yes", "Yes", "Yes", "No", "No", "Yes"))

# Define the test cases
test_that("calculate_accuracy calculates the accuracy correctly", {
  expect_equal(calculate_accuracy(test_data), 0.6)
})

test_that("calculate_accuracy returns 1 when all predictions are correct", {
  test_data_all_correct <- data.frame(Cannabis = c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No"), 
                                      .pred_class = c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No"))
  expect_equal(calculate_accuracy(test_data_all_correct), 1)
})

test_that("calculate_accuracy returns 0 when all predictions are incorrect", {
  test_data_all_incorrect <- data.frame(Cannabis = c("Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No"), 
                                        .pred_class = c("No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes", "No", "Yes"))
  expect_equal(calculate_accuracy(test_data_all_incorrect), 0)
})

test_that("calculate_accuracy returns NA when the input data frame is empty", {
  test_data_empty <- data.frame()
  expect_equal(calculate_accuracy(test_data_empty), NA)
})


library(testthat)
library(dplyr)
source("./R/clean-wrangle-data.R")
source("./test/helper_clean-wrangle.R")
library(testthat)


test_that("wrangle_training_data should return a data frame", {
  expect_is(wrangle_training_data(training_data, predictor, strata_variable, group_labels), "data.frame")
})


test_that("wrangle_training_data should return correct output for accurate input", {
  expect_identical(
    wrangle_training_data(training_data, predictor, strata_variable, group_labels),
    output
  )
})


test_that("wrangle_training_data throws an error if predictor or strata_variable are not in training_data", {
  expect_error(
    wrangle_training_data(training_data, error, strata_variable, group_labels),
    "Unexpected input: predictor or strata_variable not found in the training_data"
  )
  
  expect_error(
    wrangle_training_data(training_data, predictor, error, group_labels),
    "Unexpected input: predictor or strata_variable not found in the training_data"
  )
})

test_that("wrangle_training_data throws an error if group_labels is an empty vector", {
  expect_error(
    wrangle_training_data(training_data, predictor, strata_variable, NULL),
    "Unexpected input: group_labels must be a vector that is not-empty"
  )
  
  expect_error(
    wrangle_training_data(training_data, predictor, strata_variable, character()),
    "Unexpected input: group_labels must be a vector that is not-empty"
  )
})

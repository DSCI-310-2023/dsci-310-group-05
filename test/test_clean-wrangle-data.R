library(testthat)
source("../R/clean-wrangle-data.R")
source("../test/helper_clean-wrangle.R")

library(dplyr)

# Test output and test if column types are matching
test_that("wrangle_training_data handles and groups the data accurately", {
  output <- wrangle_training_data(training_data, predictor, strata_variable, group_labels)
  expect_equal(as.data.frame(output), expected_output)
  expect_equal(typeof(output$predictor) , typeof(expected_output$predictor))
  expect_equal(typeof(output$strata_variable) , typeof(expected_output$strata_variable))
  expect_equal(typeof(output$label) , typeof(expected_output$label))
  expect_equal(typeof(output$n) , typeof(expected_output$n))
})

# Test whether the output is a data.frame.
test_that("wrangle_training_data returns a data.frame", {
  output1 <- wrangle_training_data(training_data, predictor, strata_variable, group_labels)
  expect_is(output1, "data.frame")
})

# Test case for missing group_labels
test_that("wrangle_training_data handles missing group_labels", {
  no_labels <- c()
  output2 <- wrangle_training_data(training_data, predictor, strata_variable, no_labels)
  expect_identical(output2$label, c())
})



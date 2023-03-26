library(testthat)

# Load expected input and output data, and initial_data script
source("./R/load-data-script.R")
source("./test/helper_load-data.R")

# Test cases
test_that("initial_data function reads data and sets column names correctly", {
  # Call the function
  actual_data <- initial_data("./data/data_set.csv", col_names)
  
  # Test that the data has the expected number of observations
  expect_equal(nrow(actual_data), nrow(expected_data))
  
  # Test that the data has the expected column names
  expect_equal(colnames(actual_data), colnames(expected_data))
  
  # Test that the function returns a data frame
  expect_is(actual_data, "data.frame")
})


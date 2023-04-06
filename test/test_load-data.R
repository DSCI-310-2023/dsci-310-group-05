library(testthat)

# Load expected input and output data, and initial_data script from R folder
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

test_that("initial_data function raises error if input data file does
          not exist", {
  # Call the function with a non-existent file path
  expect_error(initial_data("./data/nonexistent_file.csv", col_names))
})

test_that("initial_data function raises error if input data is not a CSV file", {
  # Create a non-CSV file
  file.create("./data/noncsv_file.txt")

  # Call the function with the non-CSV file
  expect_error(initial_data("./data/noncsv_file.txt", col_names))

  # Delete the non-CSV file
  file.remove("./data/noncsv_file.txt")
})

test_that("initial_data function raises error if input data file is empty", {
  # Create an empty CSV file
  write.csv(data.frame(), "./data/empty_file.csv")

  # Call the function with the empty CSV file
  expect_error(initial_data("./data/empty_file.csv", col_names))

  # Delete the empty CSV file
  file.remove("./data/empty_file.csv")
})

test_that("initial_data function raises error if number of column names does
          not match number of columns in input data", {
  # Create a column names vector with a different length than the number of
  # columns in the input data
  col_names_wrong <- c("col1", "col2")

  # Call the function with the mismatched column names vector
  expect_error(initial_data("./data/data_set.csv", col_names_wrong))
})

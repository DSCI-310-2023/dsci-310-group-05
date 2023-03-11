library(testthat)
source("../../R/load-data-script.R")

# Define a data frame for testing
test_data <- data.frame(a = c(1,2,3), b = c(4,5,6))

# Define column names for testing
test_col_names <- c("col1", "col2")

# Test that initial_data() creates a CSV file with the correct column names
test_that("initial_data creates a CSV file with correct column names", {
  initial_data(test_data, test_col_names)
  raw_data <- read.csv("data/raw_data.csv")
  expect_equal(colnames(raw_data), test_col_names)
})s

# Test that initial_data() creates a CSV file that can be read correctly
test_that("initial_data creates a CSV file that can be read correctly", {
  initial_data(test_data, test_col_names)
  raw_data <- read.csv("data/raw_data.csv")
  expect_equal(nrow(raw_data), nrow(test_data))
  expect_equal(ncol(raw_data), ncol(test_data))
  expect_identical(raw_data, test_data)
})

# Test that initial_data() throws an error if data file is missing
test_that("initial_data throws an error if data file is missing", {
  expect_error(initial_data("non_existent_file.csv", test_col_names))s
})
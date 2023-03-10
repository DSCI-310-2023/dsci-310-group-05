library(testthat)
source("../../R/clean-wrangle-data.R")

# Create sample data for testing
data <- data.frame(group = c("A", "A", "B", "B", "C"),
                   value = c(1, 2, 3, 4, 5))

# Define the function to test
my_grouped_function <- function(data) {
  group_summary <- data %>%
    group_by(group) %>%
    summarize(avg_value = mean(value))
  return(group_summary)
}

# Test if function returns a data frame with expected columns
test_that("my_grouped_function() returns a data frame with expected columns", {
  result <- my_grouped_function(data)
  expect_is(result, "data.frame")
  expect_identical(colnames(result), c("group", "avg_value"))
})

# Test if function groups data correctly
test_that("my_grouped_function() groups data correctly", {
  result <- my_grouped_function(data)
  expected_result <- data.frame(group = c("A", "B", "C"),
                                avg_value = c(1.5, 3.5, 5))
  expect_identical(result, expected_result)
})

# Test if function calculates average correctly
test_that("my_grouped_function() calculates average correctly", {
  result <- my_grouped_function(data)
  expect_equal(result$avg_value[1], 1.5)
})
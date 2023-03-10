library(testthat)
source("../../R/classification-model-tuning-script.R")

# Create a sample data frame with two predictor variables and one response variable
set.seed(123)
n <- 100
drug_data <- data.frame(
  Cannabis = sample(c("Yes", "No"), size = n, replace = TRUE),
  Nicotine = rnorm(n),
  Alcohol = rnorm(n),
  Gender = sample(c("Male", "Female"), size = n, replace = TRUE)
)

# Test case 1: Check if function returns a tibble object
test_that("knn_tune() returns a tibble object", {
  result <- knn_tune(data = drug_data, neighbors = 1:3, v = 3)
  expect_s3_class(result, "tbl_df")
})

# Test case 2: Check if function returns correct number of rows
test_that("knn_tune() returns correct number of rows", {
  result <- knn_tune(data = drug_data, neighbors = 1:3, v = 3)
  expect_equal(nrow(result), length(1:3))
})

# Test case 3: Check if function returns correct columns
test_that("knn_tune() returns correct columns", {
  result <- knn_tune(data = drug_data, neighbors = 1:3, v = 3)
  expect_identical(colnames(result), c("neighbors", "mean_accuracy", "stddev_accuracy"))
})

# Test case 4: Check if function works with different weight functions
test_that("knn_tune() works with different weight functions", {
  result1 <- knn_tune(data = drug_data, neighbors = 1:3, weight_func = "rectangular", v = 3)
  result2 <- knn_tune(data = drug_data, neighbors = 1:3, weight_func = "triangular", v = 3)
  expect_identical(result1$neighbors, result2$neighbors)
  expect_not_identical(result1$mean_accuracy, result2$mean_accuracy)
})

# Test case 5: Check if function works with different number of folds
test_that("knn_tune() works with different number of folds", {
  result1 <- knn_tune(data = drug_data, neighbors = 1:3, v = 3)
  result2 <- knn_tune(data = drug_data, neighbors = 1:3, v = 5)
  expect_identical(result1$neighbors, result2$neighbors)
  expect_not_identical(result1$mean_accuracy, result2$mean_accuracy)
})

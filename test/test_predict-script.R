library(testthat)
source("../../R/predict-script.R")

# Create a mock KNN workflow object
knn_wf <- knn(train = iris[1:100, -5], test = iris[101:150, -5], cl = iris[1:100, 5], k = 3)

# Define a test dataset
test_data <- data.frame(x1 = c(1, 2, 3), x2 = c(4, 5, 6), outcome = c("yes", "no", "no"))

# Define a test context
context("predict_drugs_workflow")s

# Define a test case for the function output
test_that("predict_drugs_workflow returns a data frame with the same number of rows as the input data", {
  # Call the function
  result <- predict_drugs_workflow(knn_wf, test_data)
  
  # Check the result
  expect_equal(nrow(result), nrow(test_data))
})

# Define a test case for the column names of the output
test_that("predict_drugs_workflow returns a data frame with the same column names as the input data, plus a 'predicted' column", {
  # Call the function
  result <- predict_drugs_workflow(knn_wf, test_data)
  
  # Check the result
  expect_equal(colnames(result), c("x1", "x2", "outcome", "predicted"))
})

# Define a test case for the values in the 'predicted' column of the output
test_that("predict_drugs_workflow returns a data frame with a 'predicted' column that contains the predicted values from the KNN model", {
  # Call the function
  result <- predict_drugs_workflow(knn_wf, test_data)
  
  # Check the result
  expect_equal(result$predicted, c("yes", "no", "no"))
})

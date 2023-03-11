library(testthat)
source("./../R/predict-script.R")

data(mtcars)

# Dummy test data
test_data <- mtcars %>%
  select(mpg, cyl, disp)

# Dummy knn workflow object
knn_wf <- knn(train = test_data, test = test_data$mpg, k = 3)

# Test cases
test_that("predict_drugs_workflow returns expected output", {
  # Call the function
  predict_drugs_workflow(knn_wf, test_data)
  
  # Check if the output file was created
  expect_true(file.exists("data/prediction_data.csv"))
  
  # Check if the output file is not empty
  expect_true(file.size("data/prediction_data.csv") > 0)
  
  # Check if the number of rows in the output matches the number of rows in the test data
  expect_equal(nrow(read.csv("data/prediction_data.csv")), nrow(test_data))
  
  # Check if the output file has the expected column names
  expect_equal(colnames(read.csv("data/prediction_data.csv")), c("pred", "mpg", "cyl", "disp"))
  
  # Check if the predicted values are within the range of actual values
  expect_true(all(read.csv("data/prediction_data.csv")$pred >= min(test_data$mpg) & read.csv("data/prediction_data.csv")$pred <= max(test_data$mpg)))
})

library(ggplot2)
library(dplyr)
library(testthat)
source("./R/plots-script.R")

# Tests for the horizontal_hist function
# Test 1: Test with mtcars dataset
test_that("horizontal_hist works with mtcars dataset", {
  # Call the function with mtcars dataset
  plot <- horizontal_hist(mtcars, x = "carb", y = "mpg", xlabel = "Carburetors", ylabel = "Miles per gallon", title = "MPG vs Carburetors")
  
  # Check that the output is a ggplot object
  expect_true(is.ggplot(plot))
  
  # Check that the x-axis label is correct
  expect_equal(ggplot2::xlab(plot)$label, "Carburetors")
  
  # Check that the y-axis label is correct
  expect_equal(ggplot2::ylab(plot)$label, "Miles per gallon")
  
  # Check that the plot title is correct
  expect_equal(ggplot2::ggtitle(plot)$labels, "MPG vs Carburetors")
})

# Test 2: Test with missing axis labels and title
test_that("horizontal_hist works without axis labels and title", {
  # Call the function with mtcars dataset without axis labels and title
  plot <- horizontal_hist(mtcars, x = "carb", y = "mpg")
  
  # Check that the output is a ggplot object
  expect_true(is.ggplot(plot))
  
  # Check that the x-axis label is blank
  expect_equal(ggplot2::xlab(plot)$label, "")
  
  # Check that the y-axis label is blank
  expect_equal(ggplot2::ylab(plot)$label, "")
  
  # Check that the plot title is blank
  expect_equal(ggplot2::ggtitle(plot)$labels, "")
})

# Tests for the scatterplot function
# Test 1: Test that the function returns a ggplot object
test_that("Function returns ggplot object", {
  data <- mtcars
  plot <- scatterplot(data, "mpg", "wt", "cyl")
  expect_s3_class(plot, "ggplot")
})

# Test 2: Test that the x-axis label is correctly set
test_that("X-axis label is correctly set", {
  data <- mtcars
  plot <- scatterplot(data, "mpg", "wt", "cyl", xlabel = "Miles per gallon")
  expect_equal(ggplot2::ggtitle(plot)$labels[[1]], "Miles per gallon")
})

# Test 3: Test that the y-axis label is correctly set
test_that("Y-axis label is correctly set", {
  data <- mtcars
  plot <- scatterplot(data, "mpg", "wt", "cyl", ylabel = "Weight")
  expect_equal(ggplot2::ylab(plot)$label, "Weight")
})

# Test 4: Test that the color legend label is correctly set
test_that("Color legend label is correctly set", {
  data <- mtcars
  plot <- scatterplot(data, "mpg", "wt", "cyl", colorLabel = "Number of cylinders")
  expect_equal(ggplot2::scale_color_continuous(plot)$name, "Number of cylinders")
})

# Test 5: Test that the plot title is correctly set
test_that("Plot title is correctly set", {
  data <- mtcars
  plot <- scatterplot(data, "mpg", "wt", "cyl", title = "Miles per gallon vs. weight")
  expect_equal(ggplot2::ggtitle(plot)$labels[[1]], "Miles per gallon vs. weight")
})

# Test for the accuracy plot function
# Test 1: Test that the function returns a ggplot object
test_that("accuracy_plot returns a ggplot object", {
  
  # Create a mock dataset for testing
  data <- mtcars %>%
    mutate(.metric = rep("accuracy", nrow(.)))
  
  # Call the function under test
  plot <- accuracy_plot(data, x = "mpg", y = "hp")
  
  # Check that the returned object is a ggplot object
  expect_s3_class(plot, "ggplot")
  
})

# Test 5: Test that the plot title is correctly set
test_that("accuracy_plot sets the plot title correctly", {
  
  # Create a mock dataset for testing
  data <- mtcars %>%
    mutate(.metric = rep("accuracy", nrow(.)))
  
  # Call the function under test with a custom title
  plot <- accuracy_plot(data, x = "mpg", y = "hp", title = "Custom Title")
  
  # Check that the plot title matches the custom title
  expect_equal(ggtitle(plot)$label, "Custom Title")
  
})

# Test 3: Test that the x-axis and y-axis labels is correctly set
test_that("accuracy_plot sets the x and y labels correctly", {
  
  # Create a mock dataset for testing
  data <- mtcars %>%
    mutate(.metric = rep("accuracy", nrow(.)))
  
  # Call the function under test with custom x and y labels
  plot <- accuracy_plot(data, x = "mpg", y = "hp", xlabel = "Miles per gallon", ylabel = "Horsepower")
  
  # Check that the x and y labels match the custom labels
  expect_equal(xlab(plot)$label, "Miles per gallon")
  expect_equal(ylab(plot)$label, "Horsepower")
  
})
#library(ggplot2)
#library(dplyr)
library(testthat)
source("./R/plots-script.R")

# Tests for the horizontal_hist function

# Test case 1 
test_that("horizontal_hist produces a plot", {
  plot <- horizontal_hist(test_data, "x", "y", "x", "y", "Test Plot", plot_width = 6, plot_height = 4)
  expect_true(is.ggplot(plot))
})

# Test case 2 
test_that("horizontal_hist produces the correct x-axis label", {
  plot <- horizontal_hist(test_data, "x", "y", "x", "y", "Test Plot", plot_width = 6, plot_height = 4)
  expect_equal(xlab(plot)$label, xlab(expected_hist_plot)$label)
})

# Test case 3
test_that("horizontal_hist produces the correct y-axis label", {
  plot <- horizontal_hist(test_data, "x", "y", "x", "y", "Test Plot", plot_width = 6, plot_height = 4)
  expect_equal(ylab(plot)$label, ylab(expected_hist_plot)$label)
})

# Test case 4 
test_that("horizontal_hist produces the correct title", {
  plot <- horizontal_hist(test_data, "x", "y", "x", "y", "Test Plot", plot_width = 6, plot_height = 4)
  expect_equal(ggtitle(plot)$labels, ggtitle(expected_hist_plot)$labels)
})

----------------------------------------------------------------------------------------------
# Tests for the scatterplot function
# Test case 1 
test_that("scatterplot produces a plot", {
  plot <- scatterplot(test_data, "x", "y", "color", "x", "y", "Color", "Test Plot", plot_width = 6, plot_height = 4)
  expect_true(is.ggplot(plot))
})

# Test case 2 
test_that("scatterplot produces the correct x-axis label", {
  plot <- scatterplot(test_data, "x", "y", "color", "x", "y", "Color", "Test Plot", plot_width = 6, plot_height = 4)
  expect_equal(xlab(plot)$label, xlab(expected_scatter_plot)$label)
})

# Test case 3
test_that("scatterplot produces the correct y-axis label", {
  plot <- scatterplot(test_data, "x", "y", "color", "x", "y",  "Color", "Test Plot", plot_width = 6, plot_height = 4)
  expect_equal(ylab(plot)$label, ylab(expected_scatter_plot)$label)
})

# Test case 4 
test_that("scatterplot produces the correct title", {
  plot <- scatterplot(test_data, "x", "y", "color", "x", "y",  "Color", "Test Plot", plot_width = 6, plot_height = 4)
  expect_equal(ggtitle(plot)$labels, ggtitle(expected_scatter_plot)$labels)
})

----------------------------------------------------------------------------------------------
# Tests for the accuracy_plot function

# Test case 1 
test_that("accuracy_plot produces a plot", {
  plot <- accuracy_plot(input_data, x_label = "Neighbors", y_label = "Mean", plot_title = "Accuracy Plot")
  expect_true(is.ggplot(plot))
})

# Test case 2 
test_that("accuracy_plot produces the correct x-axis label", {
  plot <- accuracy_plot(input_data, x_label = "Neighbors", y_label = "Mean", plot_title = "Accuracy Plot")
  expect_equal(xlab(plot)$label, xlab(expected_accuracy_plot)$label)
})

# Test case 3
test_that("accuracy_plot produces the correct y-axis label", {
  plot <- accuracy_plot(input_data, x_label = "Neighbors", y_label = "Mean", plot_title = "Accuracy Plot")
  expect_equal(ylab(plot)$label, ylab(expected_accuracy_plot)$label)
})

# Test case 4 
test_that("accuracy_plot produces the correct title", {
  plot <- accuracy_plot(input_data, x_label = "Neighbors", y_label = "Mean", plot_title = "Accuracy Plot")
  expect_equal(ggtitle(plot)$labels, ggtitle(expected_accuracy_plot)$labels)
})
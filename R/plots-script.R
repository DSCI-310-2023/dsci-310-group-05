library(tidyverse)
library(ggplot2)

#' Build a horizontal histogram that will help understand the pattern between two variables
#' 
#' Creates a horizontal histogram depicts relationship between 2 variables,
#' naming the axes and the plot with the given labels,
#' in a given size
#' 
#' @param data A data frame containing 
#' @param x_var The column that consists of the x values for the graph
#' @param y_var The column that consists of the y values for the graph 
#' @param x_label Name given to the x axis 
#' @param y_label Name given to the y axis
#' @param plot_title Name given to the entire graph
#' @param plot_width Width of the plot
#' @param plot_height Height of the plot
#' 
#' @return  a visualization of a horizontal histogram
#' 
#' @examples horizontal_hist(cannabis_and_nicotine, label, n, "", "Amount of participants", "Nicotine usage vs. Cannabis usage", plot_width = 8, plot_height = 6) 

horizontal_hist <- function(data, x_var, y_var, x_label, y_label, plot_title, plot_width, plot_height) {
  options(repr.plot.width = plot_width, repr.plot.height = plot_height)
  
  plot <- ggplot(data, aes(x = reorder({{x_var}}, -{{y_var}}), y = {{y_var}})) +
    geom_bar(stat = "identity") +
    coord_flip() +
    labs(x = x_label, y = y_label, title = plot_title) +
    theme(text = element_text(size = 20))
  
  return(plot)
}


#' Build a scatter plot to help understand the relationship between two variables.
#' 
#' Creates a scatterplot depicting relationship between 2 variables,
#' color-coding the different points into different groups,
#' naming the axes and the plot with the given labels,
#' in a given size
#' 
#' @param data A data frame containing 
#' @param x_var The column that consists of the x values for the graph
#' @param y_var The column that consists of the y values for the graph 
#' @param color_var The variable based on which colors will be assigned to points in the plot
#' @param x_label Name given to the x axis 
#' @param y_label Name given to the y axis 
#' @param color_Label Name gioven to the color legend
#' @param plot_title Name given to the entire graph
#' @param plot_width Width of the plot
#' @param plot_height Height of the plot
#' 
#' @return a visualization of a scatter plot
#' 
#' @examples scatterplot(OpenNicWeed, Oscore, rate, Nicotine, "Openness", "Percentage of People Who Use Cannabis", "Use Nicotine", "Openness vs. Cannabis use", plot_width = 9, plot_height = 7)

scatterplot <- function(data, x_var, y_var, color_var, x_label, y_label, color_label, plot_title, plot_width, plot_height) {
  options(repr.plot.width = plot_width, repr.plot.height = plot_height)
  
  plot <- ggplot(data, aes(x = {{x_var}}, y = {{y_var}}, color = {{color_var}})) +
    geom_point() +
    theme(text = element_text(size = 18)) +
    labs(x = x_label, y = y_label, color = color_label, title = plot_title)
  
  return(plot)
}


#' Build a plot to help understand the accuracies
#' 
#' Creates a line plot depicting the relationship between two variables, one of them being the accuracy
#' naming the axes and the plot with the given labels,
#' 
#' @param workflow_data A data frame containing the workflow
#' @param x_label Name given to the x axis 
#' @param y_label Name given to the y axis 
#' @param plot_title Name given to the entire graph
#' 
#' @return  a visualization of the accuracy of the estimates with respect to the number of neighbors
#' 
#' @examples accuracy_plot(drugs_workflow, x_label = "Number of Neighbors", y_label = "Accuracy Estimate", plot_title = "Neighbors vs. Accuracy")

accuracy_plot <- function(workflow_data, x_label, y_label, plot_title) {
    options(repr.plot.width = 12, repr.plot.width = 12)
    accuracy <- filter(workflow_data, .metric == "accuracy")
    
    acc_plot <- ggplot(accuracy, aes(x = neighbors, y = mean)) +
    geom_point() +
    geom_line() +
    labs(x = x_label, y = y_label, title = plot_title) +
    theme(text = element_text(size = 20)) +
    scale_x_continuous(breaks = c(1:30))
    
    return(acc_plot)
}


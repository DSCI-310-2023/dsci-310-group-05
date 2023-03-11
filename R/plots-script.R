library(tidyverse)

#' Build a horizontal histogram that will help understand the pattern between two variable
#' 
#' @param data A data frame containing 
#' @param x The column that consists of the x values for the graph
#' @param y The column that consists of the y values for the graph 
#' @param xlabel Name given to the x axis 
#' @param ylabel Name given to the y axis 
#' @param title Name given to the entire graph
#' 
#' @return  a visualization of a horizontal histogram
#' 
#' @examples 
#' horizontal_hist(cannabis_and_nicotine, label, n, "", "Amount of participants", "Nicotine usage vs Cannabis usage")
#' 
horizontal_hist <- function(data, x, y, xlabel = "", ylabel = "", title = ""){
  
  options(repr.plot.height = 6, repr.plot.width = 8)
  
  hist_plot <- ggplot(data, aes(x = reorder(x, -y), y = y)) +
    geom_bar(stat = "identity") +
    coord_flip() + 
    labs(x = xlabel, y = ylabel, title = title) +
    theme(text = element_text(size = 20))
  
  return(hist_plot)
}

#' Build a scatter plot to help understand the relationship between two variables.
#' 
#' @param data A data frame containing 
#' @param x The column that consists of the x values for the graph
#' @param y The column that consists of the y values for the graph 
#' @param colorvariable The variable based on which colors will be assigned to points in the plot
#' @param xlabel Name given to the x axis 
#' @param ylabel Name given to the y axis 
#' @param colorLabel Name gioven to the color legend
#' @param title Name given to the entire graph
#' 
#' @return  a visualization of a scatter plot
#' 
#' @examples 
#' scatterplot(OpenNicWeed, Oscore, rate, Nicotine, Openness", "Percentage of People Who Use Cannabis", "Use Nicotine", "Openness vs. Cannabis use")

scatterplot <- function(data, x, y, colorVariable, xlabel = "", ylabel = "", colorLabel = "", title = ""){
  options(repr.plot.height = 7, repr.plot.width = 9)
  
  scatterplot_graph <- ggplot(data, aes(x = x, y = y, color = colorVariable)) +
    geom_point() +
    theme(text = element_text(size = 18)) +
    labs(x = xlabel, y = ylabel, color = colorLabel, title = title)
  
  return(scatterplot_graph)
}

#' Build a plot to help understand the accuraces
#' 
#' @param data A data frame containing 
#' @param x The column that consists of the x values for the graph
#' @param y The column that consists of the y values for the graph 
#' @param xlabel Name given to the x axis 
#' @param ylabel Name given to the y axis 
#' @param title Name given to the entire graph
#' 
#' @return  a visualization of the accuracy of the estimates with respect to the number of neighbors
#' 
#' @examples 
#' accuracy_plot(drugs_workflow, neighbors, mean, xlabel = "Number of Neighbors", ylabel = "Accuracy Estimate", title = "Neighbors vs. Accuracy")

accuracy_plot <- function(data, x, y, xlabel = "", ylabel = "", title = ""){
  options(repr.plot.width = 12, repr.plot.width = 12)
  
  accuracy <- filter(data, .metric == "accuracy")
  
  acc_plot <- ggplot(accuracy, aes(x = x, y = y)) +
    geom_point() +
    geom_line() +
    labs(x = xlabel, y = ylabel, title = title) +
    theme(text = element_text(size = 20)) +
    scale_x_continuous(breaks = c(1:30))
  
  return(acc_plot)
}

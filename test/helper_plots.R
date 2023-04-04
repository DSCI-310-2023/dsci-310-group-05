library(ggplot2)
library(dplyr)

# Defining input data for horizontal-hist function
test_data_1 <- data.frame(
  x = c(1, 2, 3, 4), y = c(10, 20, 30, 40),
  color = c("red", "blue", "green", "red")
)
x_var <- "x"
y_var <- "y"
color_var <- "color"
x_label <- "x"
y_label <- "y"
color_label <- "Color"
plot_title <- "Test Plot"
plot_width <- 6
plot_height <- 4

test_data_2 <- data.frame(
  .metric = rep("accuracy", 30),
  neighbors = 1:30,
  mean = rnorm(30)
)

# Defining expected output for horizontal_hist function
options(repr.plot.width = plot_width, repr.plot.height = plot_height)

expected_hist_plot <- ggplot(test_data_1, aes(x = reorder(x, -y), y = y)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(x = x_label, y = y_label, title = plot_title) +
  theme(text = element_text(size = 20))

# Defining expected output for scatterplot function
options(repr.plot.width = plot_width, repr.plot.height = plot_height)

expected_scatter_plot <- ggplot(test_data_1, aes(x = x, y = y, color = color)) +
  geom_point() +
  theme(text = element_text(size = 18)) +
  labs(x = "x", y = "y", color = "Color", title = "Test Plot")

# Defining expected output for accuracy_plot function
expected_accuracy_plot <- ggplot(test_data_2, aes(x = neighbors, y = mean)) +
  geom_point() +
  geom_line() +
  labs(x = "Neighbors", y = "Mean", title = "Accuracy Plot") +
  theme(text = element_text(size = 20)) +
  scale_x_continuous(breaks = c(1:30))

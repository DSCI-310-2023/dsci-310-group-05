library(dplyr)

# Defining input data
# Define test data
training_data <- data.frame(predictor = c(rep("A", 4), rep("B", 4)),
                            strata_variable = c(rep("X", 2), rep("Y", 2), rep("X", 2), rep("Y", 2)),
                            value = 1:8)
predictor <- "predictor"
strata_variable <- "strata_variable"
group_labels <- c("group1", "group2", "group3", "group4")

# Defining expected output
expected_output <- data.frame(predictor = c("A", "A", "B", "B"),
                              strata_variable = c("X", "Y", "X", "Y"),
                              n = as.integer(c(2, 2, 2, 2)),
                              label = group_labels)





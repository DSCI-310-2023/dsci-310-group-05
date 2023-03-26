source("./R/clean-wrangle-data.R")
library(dplyr)


# Training data
training_data <- data.frame(
  predictor = c("yes", "no", "yes", "no"),
  strata_variable = c("yes", "yes", "no", "no"),
  outcome = c(1, 1, 0, 1)
)

# Test variables
predictor <- "predictor"
strata_variable <- "strata_variable"
group_labels <- c("Group 1")

output <- training_data %>%
  dplyr::group_by({{ predictor }}, {{ strata_variable }}) %>%
  dplyr::summarize(n = n()) %>%
  dplyr::mutate(label = group_labels)
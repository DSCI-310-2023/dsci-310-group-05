library(rsample)

# Define the split_dataset function
split_dataset <- function(data_set, strata_variable, predictor) {
  split <- initial_split(data_set, prop = 0.75, strata = strata_variable)
  training_data <- training(split)
  testing_data <- testing(split)
  return(list(training_data, testing_data))
}

# Create a helper script to provide data for the tests
# Example data
set.seed(123)
data_set <- data.frame(
  x = rnorm(100),
  y = sample(c("A", "B", "C"), 100, replace = TRUE),
  z = rnorm(100)
)

strata_variable <- "y"
predictor <- "x"

# Create expected training and testing datasets
split <- initial_split(data_set, prop = 0.75, strata = strata_variable)
expected_training_data <- training(split)
expected_testing_data <- testing(split)


#' Split the dataset into training and testing sets based on a strata variable
#'
#' Splits the data into testing/training and ensures variables are appropriate
#' for classification algorithm
#'
#'
#' @param data_set the data set to be used for the algorithm
#' @param strata_variable a string representing the variable that will be set
#' as the strata in initial_split
#' @param predictor a string representing the variable to be used as the
#' predictor for the algorithm
#'
#' @return a list containing the training and the testing data sets
#' @example split_dataset(drugs, Cannabis, Nicotine)

split_dataset <- function(data_set, strata_variable, predictor) {
  split <- initial_split(data_set, prop = 0.75, strata = strata_variable)
  training_data <- training(split)
  testing_data <- testing(split)

  return(list(training_data, testing_data))
}

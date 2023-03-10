#' split_dataset function
#' Purpose: splits the data into testing/training and ensures variables are appropriate for classification algorithm
#' @param data_set the data set to be used for the algorithm
#' @param strata_variable a string representing the variable that will be set as the strata in initial_split
#' @param predictor a string representing the variable to be used as the predictor for the algorithm
#' @return writes training and testing data into the data folder
#' @example split_dataset(drugs, Cannabis, Nicotine)

split_dataset <- function(data_set, strata_variable, predictor) {
  split <- initial_split(data_set, prop = 0.75, strata = strata_variable)
  training_data <- training(split)
  testing_data <- testing(split)
  
  #setting predictor as numeric value
  testing_data <- mutate(testing_data, predictor = str_replace_all(predictor, c("no" = "0", "yes" = "1"))) %>% 
    mutate(predictor = as.numeric(predictor))
  
  write.csv(training_data, "data/training_data.csv")
  write.csv(testing_data, "data/testing_data.csv")
}

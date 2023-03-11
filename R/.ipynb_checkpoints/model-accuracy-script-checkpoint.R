#' Calculate accuracy of KNN model
#'
#' This function takes in a data frame with predicted cannabis use and calculates
#' the accuracy of the KNN model.
#'
#' @param pred_data A data frame with predicted cannabis use.
#' 
#' @return A numeric value representing the accuracy of the KNN model.
#' @export
calculate_accuracy <- function(pred_data, truth_variable) {
  drug_acc <- pred_data %>% 
    metrics(truth = truth_variable, estimate = .pred_class) %>% 
    filter(.metric == "accuracy") %>% 
    select(.estimate) %>% 
    pull()
  return(drug_acc)
}
#' Predict the outcome of cannabis usage using the fitted knn workflow model
#'
#' This function takes a fitted knn workflow object and new data as input and predicts the outcome of cannabis usage for the new data.
#' @param knn_wf A fitted knn workflow object
#' @param test_data A dataframe containing test data to predict the outcome of cannabis usage
#' @return Writes the predicted outcome of cannabis usage for the new data in the data folder
#' 
#' @examples
#' predict_drugs_workflow(drugs_workflow, drugs_test)
#' 
predict_drugs_workflow <- function(knn_wf, test_data = testing_drug_data) {
  
  # Predict the outcome of cannabis usage for the new data
  pred_data <- predict(knn_wf, test_data) %>% 
    bind_cols(test_data)
  
  write.csv(pred_data, "data/prediction_data.csv")
}

#' Predicts the outcome of a target variable
#'
#' Given a fitted KNN workflow object and new test data, this function predicts
#' the outcome of a target variable for the test data using the KNN model.
#' The predicted outcome is then written to the data folder.
#'
#' @param knn_wf A fitted knn workflow object
#' @param test_data A dataframe containing test data to predict the outcome of
#' cannabis usage
#' @return Writes the predicted outcome of cannabis usage for the new data in
#' the data folder
#'
#' @examples predict_drugs_workflow(drugs_workflow, drugs_test)
predict_drugs_workflow <- function(knn_wf, test_data = testing_data) {
  if (is.null(knn_wf)) {
    stop("The knn_wf input cannot be null.")
  }
  if (!is.data.frame(test_data)) {
    stop("The test data input must be a dataframe.")
  }
  pred_data <- stats::predict(knn_wf, test_data) %>%
    dplyr::bind_cols(test_data)

  return(pred_data)
}

#' This function cleans and wrangles the training data.
#' @param training_data a dataframe for training data
#' @param strata_variable a string representing the variable that will be set as the strata in initial_split
#' @param predictor a string representing the variable to be used as the predictor for the algorithm
#' 
#' @return cleaned and wrangled training data grouped by predictor and strata_variable & add a label column
#' @examples
#' wrangle_training_data(training_data,strata_variable, predictor)
# wrangle_training_data<- function(training_data, strata_variable, predictor, group_labels){
  
#   grouped <- group_by(training_data, strata_variable, predictor) %>% 
#     summarize(n=n())
#   grouped$label <- group_labels #This column will act as labels in the bar graph
  
#   #write.csv(grouped, "data/wrangled_training_data.csv")
# }

wrangle_training_data <- function(training_data, predictor, strata_variable, group_labels){
  
  grouped <- training_data %>%
    group_by({{predictor}}, {{strata_variable}}) %>% 
    summarize(n=n())
    
    grouped$label <- group_labels
  
  return(grouped)
}



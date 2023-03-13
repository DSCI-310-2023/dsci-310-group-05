#' This function groups by training data by predictor and strata_variables & adds group_labels column
#'
#' @param training_data a dataframe for training data
#' @param strata_variable a string representing the variable that will be set as the strata in initial_split
#' @param predictor a string representing the variable to be used as the predictor for the algorithm
#' @param group_labels list of strings representing the group names
#' 
#' @return cleaned and wrangled training data grouped by predictor and strata_variable & add a label column
#' @examples wrangle_training_data(drugs, Cannabis, Nicotine, c("group1", "group2"))

wrangle_training_data <- function(training_data, predictor, strata_variable, group_labels){
  
  grouped <- training_data %>%
    group_by({{predictor}}, {{strata_variable}}) %>% 
    summarize(n=n())
    grouped$label <- group_labels
  
  return(grouped)
}





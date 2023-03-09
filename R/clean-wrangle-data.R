

mutate_raw_data<- function (raw_data) {
  
  drugs <- select(raw_data, Age, Gender, Nscore, Escore, Oscore, Ascore, Nicotine, Cannabis) %>% 
    mutate(Cannabis = str_replace_all(Cannabis, c("CL0" = "no", "CL1" = "no", "CL2" = "no", "CL3" = "yes", "CL4" = "yes", "CL5" = "yes", "CL6" = "yes"))) %>%          
    mutate(Cannabis = as_factor(Cannabis)) %>% 
    mutate(Nicotine = str_replace_all(Nicotine, c("CL0" = "no", "CL1" = "no", "CL2" = "no", "CL3" = "yes", "CL4" = "yes", "CL5" = "yes", "CL6" = "yes")))
  
  return(head(drugs))
  
}


wrangle_training_data<- function(training_data,strata_variable, predictor){

  cannabis_and_nicotine <- group_by(training_data, predictor, strata_variable) %>% 
    summarize(n=n())
  cannabis_and_nicotine$label <- c("Neither", "Cannabis only", "Nicotine only", "Both") #This column will act as labels in the bar graph
  
  return(cannabis_and_nicotine)

}

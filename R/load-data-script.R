#' initial_data function
#' Purpose: read raw data and add column names
#' @param url the URL in which the data set is housed
#' @returns head of the loaded data set
#' @example initial_data("https://archive.ics.uci.edu/ml/machine-learning-databases/00373/drug_consumption.data")

initial_data <- function(url) {
  raw_data <- read.csv(url)
  
  colnames(raw_data) <- c("ID", "Age", "Gender", "Education", "Country", "Ethnicity", "Nscore", "Escore", "Oscore", "Ascore", "Cscore", "Impulsive", "SS", "Alcohol", "Amphet",
                          "Amyl", "Benzos", "Caff", "Cannabis", "Choc", "Coke", "Crack", "Ecstasy", "Heroin", "Ketamine", "Legalh", "LSD", "Meth", "Mushrooms", "Nicotine", "Semer",
                          "VSA")
  
  return(head(raw_data))
}



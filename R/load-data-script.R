#' initial_data function
#' Purpose: read raw data and add column names
#'
#' @param url the URL in which the data set is housed
#' @param col_names names of the columns
#'
#' @returns writes the loaded data into the data folder
#' @example initial_data("drug_consumption.csv", c("ID", "Age", "Gender", "Education", "Country", "Ethnicity", "Nscore", "Escore", "Oscore", "Ascore", "Cscore", "Impulsive", "SS", "Alcohol", "Amphet", "Amyl", "Benzos", "Caff", "Cannabis", "Choc", "Coke", "Crack", "Ecstasy", "Heroin", "Ketamine", "Legalh", "LSD", "Meth", "Mushrooms", "Nicotine", "Semer", "VSA"))

initial_data <- function(data, col_names) {
  raw_data <- read.csv(data)
  
  colnames(raw_data) <- col_names
  
  return(raw_data)
}
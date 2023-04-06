#' Initial data loading and column naming
#'
#' This function reads in raw data from a specified URL and assigns column names
#' to the data. The resulting data frame is then written to the data folder.
#'
#' @param url the URL in which the data set is housed
#' @param col_names names of the columns
#'
#' @returns writes the loaded data into the data folder
#' @example initial_data("drug_consumption.csv", c("ID", "Age", "Gender",
#' "Education", "Country", "Ethnicity", "Nscore", "Escore", "Oscore", "Ascore",
#' "Cscore", "Impulsive", "SS", "Alcohol", "Amphet", "Amyl", "Benzos", "Caff",
#' "Cannabis", "Choc", "Coke", "Crack", "Ecstasy", "Heroin", "Ketamine",
#' "Legalh", "LSD", "Meth", "Mushrooms", "Nicotine", "Semer", "VSA"))

initial_data <- function(data, col_names) {

  # Check that input file exists and is a CSV file
  if (!file.exists(data)) {
    stop("Error: Input data file does not exist.")
  } else if (file_ext(data) != "csv") {
    stop("Error: Input data file is not a CSV file.")
  }

  # Read in data
  raw_data <- utils::read.csv(data)

  # Check that number of column names matches number of columns in input data
  if (length(col_names) != ncol(raw_data)) {
    stop(paste0(
      "Error: Number of column names (", length(col_names),
      ") does not match number of columns in input data (", ncol(raw_data), ")."
    ))
  }

  # Set column names and return data frame
  colnames(raw_data) <- col_names
  return(raw_data)
}

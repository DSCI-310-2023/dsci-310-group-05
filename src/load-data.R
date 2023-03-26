# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script downloads the data from the internet. Column names are added to the dataset as there was none and then, it is saved locally.

Usage: src/load-data.R --url=<url> --dest_raw_data=<file_path>

Options:
    --url=<url>                       Url to download data
    --dest_raw_data=<file_path>       Path to where the raw_data will be saved (including filename)
    "


library(tidyverse)
library(docopt)

opt <- docopt(doc)

data <- readr::read_csv(opt$url) 

colnames(data) <- c("ID", "Age", "Gender", "Education", "Country", "Ethnicity", 
                    "Nscore", "Escore", "Oscore", "Ascore", "Cscore", "Impulsive", 
                    "SS", "Alcohol", "Amphet", "Amyl", "Benzos", "Caff", "Cannabis", 
                    "Choc", "Coke", "Crack", "Ecstasy", "Heroin", "Ketamine", "Legalh", 
                    "LSD", "Meth", "Mushrooms", "Nicotine", "Semer", "VSA")


utils::write.csv(data, opt$dest_raw_data, row.names = FALSE)
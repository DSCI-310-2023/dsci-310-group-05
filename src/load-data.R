# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script downloads the data from the internet and saves it locally.

Usage: src/load-data.R --url=<url> --out_dir=<out_dir>

Options:
    --url=<url>               Url to download data
    --out_dir=<out_dir>       Path of where to save the data
    "


library(tidyverse)
library(docopt)

opt <- docopt(doc)

data <- read_csv(opt$url) 
colnames(data) <- c("ID", "Age", "Gender", "Education", "Country", "Ethnicity", 
                    "Nscore", "Escore", "Oscore", "Ascore", "Cscore", "Impulsive", 
                    "SS", "Alcohol", "Amphet", "Amyl", "Benzos", "Caff", "Cannabis", 
                    "Choc", "Coke", "Crack", "Ecstasy", "Heroin", "Ketamine", "Legalh", 
                    "LSD", "Meth", "Mushrooms", "Nicotine", "Semer", "VSA")


write.csv(data, opt$out_dir, row.names = FALSE)
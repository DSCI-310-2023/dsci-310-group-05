# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script calculates the accuracy of the classifiers from the dataset with predictions

Usage: src/findings.R --pred_data_path=<file_path> --dest_accuracy_data=<dest_path>

Options:
    --pred_data_path=<file_path>        Path to the results data
    --dest_accuracy_data=<dest_path>    Path to where the results data with predictions should be saved
    "

library(tidyverse)
library(tidymodels)
library(repr)
library(dplyr)
library(tidyr)
library(docopt)

opt <- docopt(doc)

drugs_pred <- read.csv(opt$pred_data_path)

drug_acc <- accuracy(drugs_pred, as.factor(Cannabis), as.factor(.pred_class)) %>%
   filter(.metric == "accuracy") %>%
   select(.estimate) 

write.csv(drug_acc, opt$dest_accuracy_data, row.names = FALSE)

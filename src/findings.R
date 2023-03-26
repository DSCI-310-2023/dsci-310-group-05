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

pred_data <- read.csv(opt$pred_data_path)

pred_drug_data <- mutate(pred_data, Cannabis = str_replace_all(Cannabis, c("yes" = "1","no" = "0"))) %>%
  mutate(Cannabis = as.numeric(Cannabis))
pred_drug_data <- mutate(pred_drug_data, .pred_class = str_replace_all(.pred_class, c("yes" = "1","no" = "0"))) %>%
  mutate(.pred_class = as.numeric(.pred_class))

drug_acc <- pred_drug_data %>%
  metrics(truth = Cannabis, estimate = .pred_class) %>%
  filter(.metric == "accuracy")

write.csv(drug_acc, opt$dest_accuracy_data)

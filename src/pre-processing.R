# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script accesses the dataset downloaded in the first script (load-data.R). The dataset is filtered to include samples from those considered as drug users. The filtered dataset is split into training and testing data based on user-inputted strata and predictor parameters. The 'Nicotine' column in the testing dataset is mutated into a numeric variable where 1 = 'yes' and 0 = 'no'. The wrangling function is then called on the training data to produce a table that shows the number individuals within different groups as mentioned as group_label.


Usage: src/pre-processing.R --file_path=<file_path> --strata_variable=<strata_variable> --predictor_variable=<predictor_variable> --dest_drugs_path=<dest_path> --dest_test_path=<dest_test_path> --dest_train_path=<dest_train_path> --dest_processed_data=<dest_processed_data>

Options:
    --file_path=<file_path>                       Path of where the raw data is
    --strata_variable=<strata_variable>           Strata variable for the train-test split
    --predictor_variable=<predictor_variable>     Predictor variable for the train-test split
    --dest_drugs_path=<dest_path>                 Path of where to save the drugs data
    --dest_test_path=<dest_path>                  Path of where to save the testing data
    --dest_train_path=<dest_path>                 Path of where to save the training data
    --dest_processed_data=<dest_processed_data>   Path of where to save the fully processed training data
    "

library(docopt)
library(tidymodels)
library(stringr)
library(haven)
source("R/train-test-script.R")
source("R/clean-wrangle-data.R")

opt <- docopt(doc)

raw_data <- readr::read_csv(opt$file_path)
strata <- opt$strata_variable
predictor <- opt$predictor_variable

drugs <- select(raw_data, Age, Gender, Nscore, Escore, Oscore, Ascore, Nicotine, Cannabis) %>% 
  mutate(Cannabis = str_replace_all(Cannabis, c("CL0" = "no", "CL1" = "no", "CL2" = "no", "CL3" = "yes", "CL4" = "yes", "CL5" = "yes", "CL6" = "yes"))) %>%          
  mutate(Cannabis = as_factor(Cannabis)) %>% 
  mutate(Nicotine = str_replace_all(Nicotine, c("CL0" = "no", "CL1" = "no", "CL2" = "no", "CL3" = "yes", "CL4" = "yes", "CL5" = "yes", "CL6" = "yes")))

set.seed(1) 
train_test_data <- split_dataset(drugs, strata, predictor)
training_data <- data.frame(train_test_data[1])
testing_data <- data.frame(train_test_data[2])

testing_data <- mutate(testing_data, Nicotine = str_replace_all(Nicotine, c("no" = "0", "yes" = "1"))) %>% 
  mutate(Nicotine = as.numeric(Nicotine))

group_labels <- c("Neither", "Cannabis only", "Nicotine only", "Both")
cannabis_and_nicotine <- wrangle_training_data(training_data, Nicotine, Cannabis, group_labels)

utils::write.csv(drugs, opt$dest_drugs_path, row.names = FALSE)
utils::write.csv(testing_data, opt$dest_test_path, row.names = FALSE)
utils::write.csv(training_data, opt$dest_train_path, row.names = FALSE)
utils::write.csv(cannabis_and_nicotine, opt$dest_processed_data, row.names = FALSE)
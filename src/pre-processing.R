# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script splits the data into training and testing data based on strata and predictor inputs 
and writes them to the data folder. The script also 

Usage: src/pre-processing.R --file_path=<file_path> --strata_variable=<strata_variable> --predictor_variable=<predictor_variable> --dest_test_path=<dest_test_path> --dest_train_path=<dest_train_path> --dest_processed_data=<dest_processed_data>

Options:
    --file_path=<file_path>                       Path of where the raw data is
    --strata_variable=<strata_variable>           Strata variable for the train-test split
    --predictor_variable=<predictor_variable>     Predictor variable for the train-test split
    --dest_test_path=<dest_path>                  Path of where to save the testing data
    --dest_train_path=<dest_path>                 Path of where to save the training data
    --dest_processed_data=<dest_processed_data>   Path of where to save the fully processed data
    "

library(docopt)
library(tidymodels)
library(stringr)
library(haven)
source("R/train-test-script.R")
source("R/clean-wrangle-data.R")

opt <- docopt(doc)

raw_data <- read.csv(opt$file_path)
strata <- opt$strata_variable
predictor <- opt$predictor_variable

drugs <- select(raw_data, Age, Gender, Nscore, Escore, Oscore, Ascore, Nicotine, Cannabis)
drugs <- drugs %>% mutate(Cannabis = str_replace_all(Cannabis, c("CL0" = "no", "CL1" = "no", "CL2" = "no", "CL3" = "yes", "CL4" = "yes", "CL5" = "yes", "CL6" = "yes")))
drugs <- drugs %>% mutate(Cannabis = as_factor(Cannabis))
drugs <- drugs %>% mutate(Nicotine = str_replace_all(Nicotine, c("CL0" = "no", "CL1" = "no", "CL2" = "no", "CL3" = "yes", "CL4" = "yes", "CL5" = "yes", "CL6" = "yes")))

train_test_data <- split_dataset(drugs, strata, predictor)

training_data <- data.frame(train_test_data[1])
testing_data <- data.frame(train_test_data[2])

testing_data <- mutate(testing_data, predictor = str_replace_all(predictor, c("no" = "0", "yes" = "1"))) %>% mutate(predictor = as.numeric(predictor))

write.csv(testing_data, opt$dest_test_path, row.names = FALSE)
write.csv(training_data, opt$dest_train_path, row.names = FALSE)



group_labels <- c("Neither", "Cannabis only", "Nicotine only", "Both") 

cannabis_and_nicotine <- wrangle_training_data(training_data, Nicotine, Cannabis, group_labels)

write.csv(cannabis_and_nicotine, opt$dest_processed_data, row.names = FALSE)
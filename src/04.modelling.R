# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script tunes the model before performing the modelling

Usage: src/modelling.R --training_data_path=<file_path>
--testing_data_path=<file_path> --dest_std_training_data=<dest_path>
--dest_workflow_data=<dest_path> --fig_out_dir=<out_dir>
--dest_results_data=<dest_path>

Options:
    --training_data_path=<file_path>        Path to the training data
    --testing_data_path=<file_path>         Path to the testing data
    --dest_std_training_data=<dest_path>    Path to where standardized training data should be saved
    --dest_workflow_data=<dest_path>        Path to where workflow data should be saved
    --fig_out_dir=<out_dir>                 Path to directory where the plot should be saved
    --dest_results_data=<dest_path>         Path to where the results data with predictions should be saved
    "

# calling the necessary libraries for running this script
library(tidyverse)
library(tidymodels)
library(ggplot2)
library(docopt)
source("R/plots-script.R")
source("R/classification_model_tuning_script.R")
source("R/predict-script.R")

opt <- docopt(doc)

# saving the training and testing data as local variables for easy usage
training_data <- read.csv(opt$training_data_path)
testing_data <- read.csv(opt$testing_data_path)

# because Nicotine is stored with string values, we must turn them into
# integers to be used in the script
drug_data <- mutate(training_data,
  Nicotine = str_replace_all(
    Nicotine,
    c("yes" = "1", "no" = "0")
  )
) %>%
  mutate(Nicotine = as.numeric(Nicotine))

# running the training data through the KNN functions to produce the workflow
set.seed(2)

drugs_spec <- create_knn_spec("rectangular")
drugs_recipe <- create_recipe(drug_data, "Cannabis")
drugs_vfold <- create_vfold(drug_data, 5, "Cannabis")
gridvals <- create_grid(1, 30)

drugs_workflow <- workflow() %>%
  add_recipe(drugs_recipe) %>%
  add_model(drugs_spec) %>%
  tune_grid(resamples = drugs_vfold, grid = gridvals) %>%
  collect_metrics()


# plotting the accuracy graph based on the workflow
acc_plot <- accuracy_plot(drugs_workflow,
  x_label = "Number of Neighbors",
  y_label = "Accuracy Estimate",
  plot_title = "Neighbors vs. Accuracy"
)

ggplot2::ggsave("neighbors_and_accuracy_graph.png",
  device = "png",
  path = opt$fig_out_dir,
  width = 12,
  height = 12
)

# finalizing the KNN classification algorithm functions with the best fitting
# neighbor value obtained from the plot above
drugs_real_spec <- nearest_neighbor(
  weight_func = "rectangular",
  neighbors = 23
) %>%
  set_engine("kknn") %>%
  set_mode("classification")

drugs_real_workflow <- workflow() %>%
  add_recipe(drugs_recipe) %>%
  add_model(drugs_real_spec) %>%
  fit(data = drug_data)

# calculating how well the training data predicts the testing data
drugs_pred <- predict_drugs_workflow(drugs_real_workflow, testing_data)

# saving the modified training data, workflow and prediction results as
# data frames
write.csv(drug_data, opt$dest_std_training_data, row.names = FALSE)
write.csv(drugs_workflow, opt$dest_workflow_data, row.names = FALSE)
write.csv(drugs_pred, opt$dest_results_data, row.names = FALSE)

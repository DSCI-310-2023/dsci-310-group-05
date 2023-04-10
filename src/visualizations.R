# author: Angela Machado and Rithika Nair
# date: 2023-03-24

doc <- "This script accesses some of the datasets created in the second
        script (pre-processing.R) and create exploratory data visualizations
        which would explore the relationship between variables before performing
        the modeling. The plots generated are saved within the mentioned
        directory as png files.

Usage: src/visualizations.R --processed_data_path=<file_path> --training_data_path=<file_path> --plot_out_dir=<out-dir>

Options:
    --processed_data_path=<file_path>   Path to the processed training data
    --training_data_path=<file_path>    Path to the training data
    --plot_out_dir=<out-dir>            Path to directory where the plot should
                                        be saved
    "


library(tidyverse)
library(ggplot2)
library(docopt)
source("R/plots-script.R")

opt <- docopt(doc)

processed_data <- readr::read_csv(opt$processed_data_path)
training_data <- readr::read_csv(opt$training_data_path)

cannabis_and_nicotine_graph <-
  horizontal_hist(processed_data,
    label,
    n,
    "",
    "Amount of participants",
    "Nicotine usage vs. Cannabis usage",
    plot_width = 8,
    plot_height = 6
  )

ggplot2::ggsave("cannabis_and_nicotine_graph.png",
  device = "png",
  path = opt$plot_out_dir, width = 8, height = 8
)

# Here, we will make a new column called rate to express the percentage of each
# group that uses cannabis, as the data has been standardized and looking at raw
# marijuana user data will simply give us a normal distribution.
open_nic_weed <- group_by(training_data, Oscore, Nicotine, Cannabis) %>%
  summarize(n = n()) %>%
  pivot_wider(names_from = Cannabis, values_from = n) %>%
  replace(is.na(.), 0) %>%
  mutate(total = yes + no) %>%
  mutate(rate = yes / total * 100)

openness_and_cannabis_graph <-
  scatterplot(open_nic_weed, Oscore, rate, Nicotine, "Openness",
    "Percentage of People Who Use Cannabis", "Use Nicotine",
    "Openness vs. Cannabis use",
    plot_width = 9, plot_height = 7
  )

ggplot2::ggsave("openness_and_cannabis_graph.png",
  device = "png",
  path = opt$plot_out_dir,
  width = 9, height = 9
)

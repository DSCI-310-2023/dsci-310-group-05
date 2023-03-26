# author: Angela Machado, Dalia Ahmad, Ece Celik, Rithika Nair
# date: 2023-03-25

all: data/drug_consumption.csv data/training_data.csv data/testing_data.csv data/standardized_training_data.csv data/drug_user_consumption.csv data/drugs_workflow_data.csv data/standardized_training_data.csv results/cannabis_and_nicotine_graph.png results/openness_and_cannabis_graph.png data/accuracy.csv doc/Cannabis_Use_Prediction_Analysis.html 

# download data
data/drug_consumption.csv: src/load-data.R
	Rscript src/load-data.R --url="https://archive.ics.uci.edu/ml/machine-learning-databases/00373/drug_consumption.data" --dest_raw_data=data/drug_consumption.csv

#train and test split
data/drug_user_consumption.csv data/training_data.csv data/testing_data.csv data/processed_training_data: src/pre-processing.R 
	Rscript src/pre-processing.R --file_path=data/drug_consumption.csv --strata_variable="Cannabis" --predictor_variable="Nicotine" --dest_drugs_path=data/drug_user_consumption.csv --dest_test_path=data/testing_data.csv --dest_train_path=data/training_data.csv --dest_processed_data=data/processed_training_data.csv

# visualization 
results/cannabis_and_nicotine_graph.png results/openness_and_cannabis_graph.png: src/visualizations.R
	Rscript src/visualizations.R --processed_data_path=data/processed_training_data.csv --training_data_path=data/training_data.csv --plot_out_dir=results/

# Modelling
data/standardized_training_data.csv data/drugs_workflow_data.csv results/neighbors_and_accuracy_graph.png data/results_data.csv: src/modelling.R
	Rscript src/modelling.R --training_data_path=data/training_data.csv --testing_data_path=data/testing_data.csv --dest_std_training_data=data/standardized_training_data.csv --dest_workflow_data=data/drugs_workflow_data.csv --fig_out_dir=results/neighbors_and_accuracy_graph.png --dest_results_data=data/results_data.csv 

#accuracy
data/accuracy.csv: src/findings.R
	Rscript src/findings.R --pred_data_path=data/results_data.csv --dest_accuracy_data=data/accuracy.csv


# render R Markdown report in HTML and PDF
doc/Cannabis_Use_Prediction_Analysis.html: doc/Cannabis_Use_Prediction_Analysis.Rmd doc/references.bib
	Rscript -e "rmarkdown::render('doc/Cannabis_Use_Prediction_Analysis.Rmd', c('bookdown::html_document2'))"


#clean
clean:
	rm -rf results
	rm -rf doc/Cannabis_Use_Prediction_Analysis.html 

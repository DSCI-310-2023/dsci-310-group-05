# author: Angela Machado, Dalia Ahmad, Ece Celik, Rithika Nair
# date: 2023-03-25

all: data/raw/drug_consumption.csv data/processed/training_data.csv data/processed/testing_data.csv data/processed/standardized_training_data.csv data/processed/drug_user_consumption.csv data/processed/drugs_workflow_data.csv data/processed/standardized_training_data.csv results/cannabis_and_nicotine_graph.png results/openness_and_cannabis_graph.png data/processed/accuracy.csv doc/Cannabis_Use_Prediction_Analysis.html 

# download data
data/raw/drug_consumption.csv: src/load-data.R
	Rscript src/load-data.R --url="https://archive.ics.uci.edu/ml/machine-learning-databases/00373/drug_consumption.data" --dest_raw_data=data/raw/drug_consumption.csv

#train and test split
data/processed/drug_user_consumption.csv data/processed/training_data.csv data/processed/testing_data.csv data/processed/processed_training_data: src/pre-processing.R 
	Rscript src/pre-processing.R --file_path=data/raw/drug_consumption.csv --strata_variable="Cannabis" --predictor_variable="Nicotine" --dest_drugs_path=data/processed/drug_user_consumption.csv --dest_test_path=data/processed/testing_data.csv --dest_train_path=data/processed/training_data.csv --dest_processed_data=data/processed/processed_training_data.csv

# visualization 
results/cannabis_and_nicotine_graph.png results/openness_and_cannabis_graph.png: src/visualizations.R
	Rscript src/visualizations.R --processed_data_path=data/processed/processed_training_data.csv --training_data_path=data/processed/training_data.csv --plot_out_dir=results/

# Modelling
data/processed/standardized_training_data.csv data/processed/drugs_workflow_data.csv results/neighbors_and_accuracy_graph.png data/processed/results_data.csv: src/modelling.R
	Rscript src/modelling.R --training_data_path=data/processed/training_data.csv --testing_data_path=data/processed/testing_data.csv --dest_std_training_data=data/processed/standardized_training_data.csv --dest_workflow_data=data/processed/drugs_workflow_data.csv --fig_out_dir=results/ --dest_results_data=data/processed/results_data.csv 

#accuracy
data/processed/accuracy.csv: src/findings.R
	Rscript src/findings.R --pred_data_path=data/processed/results_data.csv --dest_accuracy_data=data/processed/accuracy.csv


# render R Markdown report in HTML
doc/Cannabis_Use_Prediction_Analysis.html: doc/Cannabis_Use_Prediction_Analysis.Rmd doc/references.bib
	Rscript -e "rmarkdown::render('doc/Cannabis_Use_Prediction_Analysis.Rmd', c('bookdown::html_document2'))"


#clean
clean:
	rm -rf results
	rm -rf doc/Cannabis_Use_Prediction_Analysis.html 


# author: Angela Machado, Dalia Ahmad, Ece Celik, Rithika Nair
# date: 2023-03-25

all: data/drug_consumption.csv data/training_data.csv data/testing_data.csv jbook/_build/html/index.html

# download data
data/drug_consumption.csv: src/load-data.R
	Rscript src/load-data.R --url="https://archive.ics.uci.edu/ml/machine-learning-databases/00373/drug_consumption.data" --out_dir=data/drug_consumption.csv

data/training_data.csv data/testing_data.csv: src/pre-processing.R 
	Rscript src/pre-processing.R --file_path=data/drug_consumption.csv --strata_variable="Cannabis" --predictor_variable="Nicotine" --dest_test_path=data/testing_data.csv --dest_train_path=training_data.csv --dest_processed_data=data/processed_training_data.csv

# render Jupyter Book report in HTML and PDF
jbook/_build/html/index.html: jbook/_config.yml jbook/_toc.yml jbook/Cannabis-Use-Prediction_Analysis.ipynb jbook/references.bib
	jupyter-book build --all jbook
# jbook/_build/latex/python.pdf: jbook/_config.yml jbook/_toc.yml jbook/Cannabis-Use-Prediction_Analysis.ipynb jbook/references.bib
# 	jupyter-book build jbook/ --builder pdflatex

clean:
	rm -rf data
	rm -rf jbook/Cannabis-Use-Prediction_Analysis.html
#jbook/Cannabis-Use-Prediction_Analysis.pdf
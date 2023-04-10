# **Cannabis Use Prediction Project**
 __Authors:__ Angela Machado, Chris Lee, Daniel Davydova, Jerome Ting

__Contributors:__ Angela Machado, Dalia Ahmad, Ece Celik, Rithika Nair

___Note:__ This analysis was original created by Angela Machado, Chris Lee, Daniel Davydova, Jerome Ting for DSCI 100. Please refer [here](/consent/consent.png) for the consent to use this analysis for our project._
&nbsp;

## **Project Summary** ##
This project aims to predict cannabis use based on demographic patterns, personality traits, and nicotine use. A survey collected between 2011 to 2012 of 1885 respondents from the UCI Machine Learning repository was used as the main sample. By using age, gender, education, Big Five personality traits, and nicotine use as predictors, we predicted how likely an individual is to use cannabis. Based on the analysis, we were able to predict an individual's probability of using cannabis with a 79% accuracy rate, using a 5-fold cross-validation and a K-nearest neighbors classification algorithm with 23 neighbors. The findings suggest that the algorithm can be used in the future with a satisfactorily high degree of certainty in regards to its outputs.


## **Report** ##

The analysis report can be found [here](/doc/Cannabis_Use_Prediction_Analysis.html).


## **Usage** ##

We use a Docker container image to make the computational environment for this project reproducible. Follow the steps below to interactively run JupterLab and explore the project:

- Clone this repository and in the terminal, navigate to the root of this project. 
- First, run the following command in the terminal:

   ```
   docker pull daahmad/dsci-310-group-05
   ```
  
- Next, run the following command in the terminal: 

   ```
   docker run --rm --user root -v $(pwd):/home/jovyan -p 8888:8888 daahmad/dsci-310-group-05
   ```

- Once the container is launched, copy the URL from the terminal that looks like: 
``` http://127.0.0.1:8888/lab?token=ca965902616c582833fad36c546dc2c5ea2693ae9c5474e3``` 
into the web browser to access JupyterLab.

- You can now acess the entire project

- Open the terminal in JupterLab and run the following command to ensure that you are starting from a fresh environment: 

  ```
  make clean
  ```
  
- Run the following command to run the analysis fi;e: 

  ```
  make all -B
  ```
  
- To remove all files created by the previous command and run, run the following command:

  ```
  make clean
  ```

## __Dependencies:__

These are the dependencies needed to run the analysis:
- tidyverse=1.3.2
- tidymodels=1.0.0 
- repr=1.1.5
- dplyr=1.0.10
- tidyr=1.2.1
- testthat=3.1.6
- kknn=1.3.1
- ggplot2=3.4.0
- docopt=0.7.1
- bookdown=0.33
- knitr=1.4.1
- forcats=1.00
- purrr=1.0.1
- rsample=1.1.1


## **Licences:** ##
This project is offered under the [Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/). The software provided in this project is offered under the [MIT open source license](https://opensource.org/license/mit/) . See the [license file](/LICENSE.md) for more information.



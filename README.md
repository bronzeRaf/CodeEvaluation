
# CodeEvaluation
This is a set of source code evaluation scripts, based on the static analysis of the code. Many different models in R have been developed trying to predict the quality of the source code from its static analysis metrics. The full documentation of the project could be found in "Code Evaluation.pdf". This paper contains details about the models developed and tested, the experimental setup and the results.

## DATASET
The Dataset used to train the models is available in the "dataset" folder. It contains data from 100 public repositories of 2016. For every repository the dataset stores: 
- General info (owner, name, stars, forks etc...)
- Class info (lines of code, warnings, parent, violations of rules, etc...)
- Method info (lines of code, warnings, parent, violations of rules, etc...)
- Package info (lines of code, warnings, parent, violations of rules, etc...)

## METRIC
Any part of a repository could be evaluated. A class, a package or even a method. The metric used to express the code quality of such a part is:

![SCORE Metric](https://latex.codecogs.com/gif.latex?SCORE%20%3D%20ln%28%5Cdfrac%7Bstars%20%5Ccdot%20LOC%7D%7Bsum%28LOC%29%7D%20&plus;%20%5Cdfrac%7Bstars%7D%7Bparts%7D%20&plus;%20%5Cdfrac%7Bforks%20%5Ccdot%20LOC%7D%7Bsum%28LOC%29%7D%20&plus;%20%5Cdfrac%7Bforks%7D%7Bparts%7D%29)

where **stars** is the number of stars of the repository, **forks** the number of forks of the repository, **LOC** the lines of code of the current evaluated part, **sum(LOC)** the total lines of code of the full repository and **parts** the number of parts (of same kind) of the repository. For example, to evaluate the class A who belongs to a repository R1, LOC is the lines of code of class A, sum(LOC) the total lines of code of the repository R1, parts the number of classes that belong to the repository R1, stars the stars of the  repository R1 and forks the forks of the repository R1.

## Source code
For the code evaluation, a lot of work has to be done. Data preprocessing, model construction and experimental setup. This work is done by the scripts in the "scripts" folder. In there, there are 3 folders (preprocessing, building models and experimental setup), containing script 

#### Preprocessing
- **read_data.R**: Reads the dataset on many ways. 
- **binary_class_maker.R**: Transforms the numerical target value to a categorical one. We could use the categorical target as a threshold to rapidly eliminate extreme values.
- **create_train_and_test_set.R**: Separates data for test set and for training set. Those data are selected randomly
- **calcMetric.R**: Calculates the metric value (SCORE) for every instance of the data set.
- **preprocess.R**: Advanced data preprocessing. removes constants and doubles, removes LOC (because it is inside our metric),  applies principal component analysis, discretizes data and replaces outliers from training data with the mean.

#### Building models
- **calcGamma.R**: Finds the best gamma value for an SVM classifier based on the MSE metric. 
- **calcNeuralParams.R**: Finds the best parameters for a neural network based on the MSE metric. 
- **classification_models.R**: Builds different kind of models, to evaluate source code. A decision tree, an SVM, 2 neural networks and a KNN have been developed.

#### Experimental setup
- **read_data.R**: Here is the summary of the comparison of the models. This file visualizes a lot of statistics to  compare the models. Confusion matrices, precisions, accuracies, recalls, F12s and MSEs are compared for those who love numbers.  
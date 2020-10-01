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

## MODELS
For the code evaluation, various models have been developed in R. The models are in the "models" folder. 

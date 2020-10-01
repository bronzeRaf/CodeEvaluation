#create the classification models
#***************_________STEP1________*******************
#PREPARE
#First run "Binary Class maker.R" to create the catigorigal class
#variable for Step1 low quality elimination models
#---------------------------------------------------------------------
#DECISION TREE
library(rpart)
library(rpart.plot)
#first run binary class maker to get the binary class in the metric
STEP1tree <- rpart(metric ~ ., method = "class", data = trainPC)
#check the cp graph
plotcp(STEP1tree)
#prune tree to avoid ovefitting
step1TREE<- prune(STEP1tree, cp = STEP1tree$cptable[which.min(STEP1tree$cptable[,"xerror"]),"CP"])
#plot tree
rpart.plot(step1TREE, extra = 104, nn = TRUE)
#predict
pred1 = predict(STEP1tree, testPC, type="class")
#evaluate --> "Evaluation.R"

#---------------------------------------------------------------------
#SVM
library(e1071)
#first run binary class maker to get the binary class in the metric
#crate model with gamma decided from "calcGamma.R"
STEP1svm = svm(metric ~ ., kernel="radial", data = trainPC, gamma = 0.4)
#predict
pred2 = predict(STEP1svm, testPC)
#evaluate --> "Evaluation.R"

#***************_________STEP2________*******************
#PREPARE
#get the mask of the pass-eliminate data]
#based on prediction
predMeTrain = predict(STEP1svm, trainPC[, c(1:18)])
pass = predMeTrain == "Ok"
#or based on the real metric (uncomment)
#pass = trainPC[,19] == "Ok"
#eliminate Low quality objects
trainPC = trainPC[pass,]
Metric = Metric[pass]

#scale the Metric (for both train and test set)
#uncomment following for scaled metric
#Metric = scale(Metric, center = TRUE, scale = TRUE)
#testMetric = scale(testMetric, center = TRUE, scale = TRUE)

#get back the numeric metric
trainPC$metric = Metric

#the same for testset (with predictions)
pass = pred2 == "Ok"
testPC = testPC[pass,]
testMetric = testMetric[pass]

#---------------------------------------------------------------------
#ANN
library("neuralnet")

#create the formula
n <- names(trainPC)
f <- as.formula(paste("metric ~", paste(n[!n %in% "metric"], collapse = " + ")))
#build the model
#difficult to converge
STEP2ann = neuralnet(f,trainPC, hidden = 0, threshold = 0.001, linear.output=T, stepmax=1e6)
#plot(STEP2ann)
pred3 <- compute(STEP2ann, testPC)

#ANN2
library("nnet")
#ucomment following lines before plot.nnet
#library(devtools)
#source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

STEP2ann2 <- nnet(x = trainPC[,1:18], decay = 0.27, y = trainPC[,19], size = 2, linout = T, maxit = 10000)
pred4 <- predict(STEP2ann2, testPC)
#evaluate --> "Evaluation.R"

#data.frame(pred4, testMetric)

#plot.nnet(STEP2ann2$wts,struct=STEP2ann2$n)

#---------------------------------------------------------------------
#DECISION TREE
library(rpart)
library(rpart.plot)
#first run binary class maker to get the binary class in the metric
STEP2tree <- rpart(metric ~ ., method = "anova", data = trainPC)
#check the cp graph
plotcp(STEP2tree)
#prune tree to avoid ovefitting
step2TREE<- prune(STEP2tree, cp = STEP2tree$cptable[which.min(STEP2tree$cptable[,"xerror"]),"CP"])
#plot tree
rpart.plot(step2TREE, nn = TRUE)
#predict
pred5 = predict(STEP2tree, testPC)
#evaluate --> "Evaluation.R"

#---------------------------------------------------------------------
#KNN
library(class)

pred6 = knn(trainPC[,1:18], testPC, trainPC[,19], k = 1)
#convert factor to numeric
pred6 = as.numeric(levels(pred6))[pred6]

#---------------------------------------------------------------------
#SVM
library(e1071)
#gamma calculated as in step1 with "calcGamma.R" (second part)
STEP2svm = svm(metric ~ ., kernel="radial", data = trainPC, gamma = 1.15)
#predict
pred7 = predict(STEP2svm, testPC)
#evaluate --> "Evaluation.R"
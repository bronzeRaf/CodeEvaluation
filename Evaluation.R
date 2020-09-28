#Metric Statistics for train and dataset
mean(Metric)
min(Metric)
max(Metric)

mean(testMetric)
min(testMetric)
max(testMetric)

#***************_________STEP1________*******************
#______________________________________________________________________
#TREE
cm1 = as.matrix(table(Actual = testdec, Predicted = pred1))
accuracy1 = sum(diag(cm1)) / sum(cm1)
#precision for Low is the most important cause we need to avoid the
#false low quality code evaluation
precision1 = diag(cm1) / colSums(cm1)
recall1 = diag(cm1) / rowSums(cm1)
f11 = 2 * precision1 * recall1 / (precision1 + recall1)
data.frame(precision1, recall1, f11)
cm1
#uncomment to see full prediction against true values
#data.frame(pred1, testdec, testMetric)

#______________________________________________________________________
#SVM
cm2 = as.matrix(table(Actual = testdec, Predicted = pred2))
accuracy2 = sum(diag(cm2)) / sum(cm2)
#precision for Low is the most important cause we need to avoid the
#false low quality code evaluation
precision2 = diag(cm2) / colSums(cm2)
recall2 = diag(cm2) / rowSums(cm2)
f12 = 2 * precision2 * recall2 / (precision2 + recall2)
data.frame(precision2, recall2, f12)
cm2
#uncomment to see full prediction against true values
#data.frame(pred2, testdec, testMetric)

#______________________________________________________________________
#a look at the predictions again target results
data.frame(pred1,pred2, testdec, testMetric)
#______________________________________________________________________

#***************_________STEP2________*******************
#______________________________________________________________________
#ANN
#get MSE
MSEann = sum((pred3$net.result - testMetric)^2)/nrow(testPC)
#uncomment to see full prediction against true values
#data.frame(pred3$net.result, testMetric)

#ANN2
#get MSE
MSEann2 = sum((pred4 - testMetric)^2)/nrow(testPC)
#data.frame(pred4, testMetric)

#______________________________________________________________________
#TREE
#get MSE
MSEtree = sum((pred5 - testMetric)^2)/nrow(testPC)

#uncomment to see full prediction against true values
#data.frame(pred5, testMetric)

#______________________________________________________________________
#KNN
#get MSE
MSEknn = sum((pred6 - testMetric)^2)/nrow(testPC)

#uncomment to see full prediction against true values
#data.frame(pred6, testMetric)

#______________________________________________________________________
#SVM
#get MSE
MSEsvm = sum((pred7 - testMetric)^2)/nrow(testPC)

#uncomment to see full prediction against true values
#data.frame(pred7, testMetric)

#______________________________________________________________________
#a look at the predictions again target results
data.frame(pred3$net.result, pred4, pred5, pred6, pred7, testMetric)
#______________________________________________________________________

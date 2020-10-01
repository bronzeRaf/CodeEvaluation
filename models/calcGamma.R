#**************************************************************
#for step1 svm low score elimanation we need a model with high 
#precision (few false eliminations). Recall will be fixed in step2.
#Here we compare gamma values to decide.

gammavalues = c(0.15, 0.175, 0.2, 0.25, 0.3, 0.325, 0.35, 0.375, 0.4, 0.45, 0.5, 0.55)
#init
accuracy2 = c()
precision2 = c()
recall2 = c()
fn2 = c()
fp2 = c()
f12 = c()
i=0
for (g in gammavalues){
  i = i+1
  #model
  mod1svm = svm(metric ~ ., kernel="radial", data = trainPC, gamma = g)
  p2 = predict(mod1svm, testPC)
  #Cost Matrix
  cm2 = as.matrix(table(Actual = testdec, Predicted = p2))
  #recall and precision
  rec = diag(cm2) / rowSums(cm2)
  prec = diag(cm2) / colSums(cm2)
  #store values (+accuracy and f1 score)
  accuracy2[i] = sum(diag(cm2)) / sum(cm2)
  precision2[i] = prec[1]
  recall2[i] = rec[1]
  f12[i] = 2 * precision2[i] * recall2[i] / (precision2[i] + recall2[i])
  #false eliminations
  fn2[i] = cm2[2,1]
  #false passes
  fp2[i] = cm2[1,2]
}
#plot time
par(mfrow=c(1,3))
plot(gammavalues, recall2)
plot(gammavalues, accuracy2)
plot(gammavalues, precision2)

par(mfrow=c(1,2))
plot(gammavalues, fp2)
plot(gammavalues, fn2)

par(mfrow=c(1,1))

#best gamma is 0.25 because precision and total false eliminations are
#the best possible and all other metrics fail less.

#*************************************************************
#Now clalculate gamma for step2
#We need lowest Mse without overfitting, so we predict testset
#First run PREPARE to step2 (before step2) to fix numeric metric
gammavalues = c(0.5, 0.7, 0.9, 1, 1.1, 1.15, 1.2, 1.25, 1.3, 1.5, 1.7, 2)
#init
MseParam = c()
i=0
for (g in gammavalues){
  i = i+1
  #model
  mod2svm = svm(metric ~ ., kernel="radial", data = trainPC, gamma = g)
  p2 = predict(mod2svm, testPC)
  MseParam[i] = sum((p2 - testMetric)^2)/nrow(testPC)
}
plot(gammavalues,MseParam)

#best gamma is 1.15 based on MSE metric
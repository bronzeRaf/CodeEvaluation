#Calculate the size and the decay params for nnet call

MSE = c()
#size loop to get MSE metric in every case
#slow to execute!
for(i in 1:15){

  ann2 <- nnet(x = trainPC[,1:18], y = trainPC[,19], size = i, decay=0.2, linout = T, entropy = F, softmax = F, censored = F, skip = F, maxit = 10000)
  pr <- predict(ann2, testPC)
  MSE[i] = sum((pr - testMetric)^2)/nrow(testPC)
  #data.frame(pr, testMetric)
  
}
MSE
plot(MSE)

#caret tunning for decay and size
library(caret)
#first soft test
#slow to execute
model <- train(metric ~ ., trainPC, method='nnet', linout=TRUE, trace = FALSE,
               #Grid of tuning parameters to try:
               tuneGrid=expand.grid(.size=c(1,2,3,5,7,8,10,12,15), .decay=c(0.001,0.1,0.15,0.175,0.2,0.25,0.3))) 
ps <- predict(model, testPC)

mse1 = sum((ps - testMetric)^2)/nrow(testPC)
plot(model)

#more strictly test after first results
#check for the best parameters 
model2 <- train(metric ~ ., trainPC, method='nnet', linout=TRUE, trace = FALSE,
               #Grid of tuning parameters to try:
               tuneGrid=expand.grid(.size=c(1,2,3), .decay=c(0.1,0.16,0.175,0.18,0.195,0.22,0.25,0.26,0.27,0.28,0.29,0.3))) 
ps2 <- predict(model2, testPC)
plot(model2)
mse2 = sum((ps2 - testMetric)^2)/nrow(testPC)

#mse changes in every execution but the best value for size 
#is 2 and for decay tends to be something inside (0.25-0.3)

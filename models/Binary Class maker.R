#Turns the numeric metric to a categorical, binary class value.
#This is helpful for STEP1 (elimination of the low quality files).
#This is done with a score threshold decided from quantile values 

#first backup the tarin and the test data
#uncomment following lines
#trainPC.old = trainPC
#testPC.old = testPC
#testMetric.old = testMetric
#get quantiles
qnt <- quantile(Metric, probs=c(.25, .75), na.rm = T)
caps = quantile(Metric, probs=c(.05, .95), na.rm = T)
#check boxplot
boxplot(Metric, main="metric", boxwex=0.1)

dec=c()
count = 0
#Packages
#threshold = 1.74
#Classes
#threshold = 0.2
#Methods
threshold = -1.7
#compare everything with the threshold
for (i in 1:length(Metric)){
  if(Metric[i]< threshold){
    count = count+1
    dec[i] = "Low"
  }
  else{
    dec[i] = "Ok"
  }
}
count
#class value now is categorical
trainPC[,19] = factor(dec)

count = 0
testdec=c()
#compare everything with the threshold
for (i in 1:length(testMetric)){
  if(testMetric[i]< threshold){
    count = count+1
    testdec[i] = "Low"
  }
  else{
    testdec[i] = "Ok"
  }
}
count
testdec = factor(testdec)

#uncomment following lines to get back the old values
#trainPC = trainPC.old
#testPC = testPC.old
#testMetric = testMetric.old

#Continue with STEP1 models
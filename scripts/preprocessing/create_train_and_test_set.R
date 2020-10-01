#Create trainset and testset randomly sampled from our dataset
#first run "calcMetric.R" (slow) or load workspace to get loc tables

#Don't forget to change the path if needed
setwd('C:/Users/Raft/Projects & Software/Pattern recognition/Code Evaluation/workspace')
source("read_data.R")

load("C:/Users/Raft/Projects & Software/Pattern recognition/Code Evaluation/workspace/workspace.RData")

#get projects
set.seed(0); random_index = sample(length(repositories$Project_Name), 20)
#randata = read_metrics_data(repositories$Project_Name[random_index[1:20]], type = "Package")
#randata = read_metrics_data(repositories$Project_Name[random_index[1:15]], type = "Class")
randata = read_metrics_data(repositories$Project_Name[random_index[1:20]], type = "Method")

#mix the data index to have test and training set from various projects
set.seed(0); random_index2 = sample(nrow(randata), nrow(randata))
#split data
train = randata[random_index2[1:1000],]
test = randata[random_index2[1001:1279],]

Metric = c()
StarMetric = c()
ForkMetric = c()
#packages, classes or methods column index for loc
#co = 26
#co = 43
co = 31
#packages, classes or methods column index for number of parts
#co2 = 6
#co2 = 5
co2 = 4
# For each project name get the average number of weighted methods per class
for (i in 1:nrow(train)){
  for(j in 1:length(projects)){
    if (train[i,1]==projects[j]){
      #get project's data
      curStar = repositories[j,2]
      curFork = repositories[j,3]
      curPak = repositories[j,co2]
      
      #Packages
      #curLoc = locP[j]
      #Classes
      curLoc = locC[j]
      #Methods
      #curLoc = locM[j]
      break
    }
  }
  
  #store metrics
  Metric[i] = log(curStar*train[i,co]/curLoc+curStar/curPak+curFork*train[i,co]/curLoc+curFork/curPak)
  StarMetric[i] = log(curStar*train[i,co]/curLoc+curStar/curPak)
  ForkMetric[i] = log(curFork*train[i,co]/curLoc+curFork/curPak)
}
#Same job for testset's metrics
testMetric = c()
testStarMetric = c()
testForkMetric = c()
# For each project name get the average number of weighted methods per class
for (i in 1:nrow(test)){
  for(j in 1:length(projects)){
    if (test[i,1]==projects[j]){
      #get project's data
      curStar = repositories[j,2]
      curFork = repositories[j,3]
      curPak = repositories[j,co2]
      #Packages
      #curLoc = locP[j]
      #Classes
      curLoc = locC[j]
      #Methods
      #curLoc = locM[j]
      break
    }
  }
  
  #store metrics
  testMetric[i] = log(curStar*test[i,co]/curLoc+curStar/curPak+curFork*test[i,co]/curLoc+curFork/curPak)
  testStarMetric[i] = log(curStar*test[i,co]/curLoc+curStar/curPak)
  testForkMetric[i] = log(curFork*test[i,co]/curLoc+curFork/curPak)
}
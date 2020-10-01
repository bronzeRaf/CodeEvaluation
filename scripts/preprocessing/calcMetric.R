#Don't forget to change the path if needed
setwd('C:/Users/Raft/Projects & Software/Pattern recognition/Code Evaluation/workspace')

source("read_data.R")


ClassData = read_metrics_data(repositories$Project_Name, type = "Class")
MethodData = read_metrics_data(repositories$Project_Name, type = "Method")
PackageData = read_metrics_data(repositories$Project_Name, type = "package")


projects = levels(ClassData$Project_Name)


locC=c()
for (i in 1:length(projects)){
  projdata = ClassData[ClassData$Project_Name == projects[i],]
  locC[i] = sum(projdata$LOC)
}

#uncomment to find the Metric fo each class
#REALLY SLOW!!
#classMetric = c()
# For each project name get the average number of weighted methods per class
#for (i in 1:nrow(ClassData)){
#  for(j in 1:length(projects)){
#    if (ClassData[i,1]==projects[j]){
#      curStar = repositories[j,2]
#      curFork = repositories[j,3]
#      curCl = repositories[j,5]
#      curLoc = locC[j]
#      break
#    }
#  }
  

#  classMetric[i] = log(curStar*ClassData[i,43]/curLoc+curStar/curCl+curFork*ClassData[i,43]/curLoc+curFork/curCl)
#}

projects = levels(MethodData$Project_Name)

locM=c()
for (i in 1:length(projects)){
  projdata = MethodData[MethodData$Project_Name == projects[i],]
  locM[i] = sum(projdata$LOC)
}

#uncomment to find the Metric fo each method
#REALLY SLOW!!
#MethodMetric = c()
# For each project name get the average number of weighted methods per class
#for (i in 1:nrow(MethodData)){
#  for(j in 1:length(projects)){
#    if (MethodData[i,1]==projects[j]){
#      curStar = repositories[j,2]
#      curFork = repositories[j,3]
#      curMe = repositories[j,4]
#      curLoc = locM[j]
#      break
#    }
#  }
  
  
#  MethodMetric[i] = log(curStar*MethodData[i,31]/curLoc+curStar/curMe+curFork*MethodData[i,31]/curLoc+curFork/curMe)
#}

projects = levels(PackageData$Project_Name)
#loc for packages
locP=c()
for (i in 1:length(projects)){
  projdata = PackageData[PackageData$Project_Name == projects[i],]
  locP[i] = sum(projdata$LOC)
}

#SPackageMetric = c()
#FPackageMetric = c()
# For each project name get the average number of weighted methods per class
#for (i in 1:nrow(PackageData)){
#  for(j in 1:length(projects)){
#    if (PackageData[i,1]==projects[j]){
#      curStar = repositories[j,2]
#      curFork = repositories[j,3]
#      curPak = repositories[j,6]
#      curLoc = locP[j]
#      break
#    }
#  }
  
  
#  PackageMetric[i] = log(curStar*PackageData[i,26]/curLoc+curStar/curPak+curFork*PackageData[i,26]/curLoc+curFork/curPak)
#}


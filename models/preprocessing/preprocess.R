#Preprocess for the dataset

#Instances are unique and without missing values
train = unique(train)
train = na.omit(train)

#remove constant columns (max = min in the column)
train = train[,!apply(train, MARGIN = 2, function(x) max(x, na.rm = TRUE) == min(x, na.rm = TRUE))]

#remove LOC (because it is inside our metric)
linesLoc = data.frame(train$LOC)
names(linesLoc) = "LOC"
train$LOC = NULL
test$LOC = NULL

library(editrules)
E <- editset(c("LOC >= 0"))
check = violatedEdits(E, linesLoc)
summary(check)

#PCA application
#Packages
#pca_model <- prcomp(train[,6:53], center = T, scale = T)
#Classes
#pca_model <- prcomp(train[,7:77], center = T, scale = T)
#Methods
pca_model <- prcomp(train[,7:40], center = T, scale = T)

eigenvectors = pca_model$rotation
eigenvalues = pca_model$sdev^2

#decide how many comps
barplot(eigenvalues / sum(eigenvalues))
sum(eigenvalues[1:18]) / sum(eigenvalues)
std_dev <- pca_model$sdev
pr_var <- std_dev^2
prop_varex <- pr_var/sum(pr_var)
plot(prop_varex, xlab = "Principal Component",
     ylab = "Proportion of Variance Explained",
     type = "b")
trainPC = as.data.frame(predict(pca_model, train)[, 1:18])
testPC = as.data.frame(predict(pca_model, test)[, 1:18])


trainPC[,19] = Metric
names(trainPC)[19] = "metric"
#discretize our data
#we will keep both types, continuous and discrete data
DtrainPC = trainPC
DtrainPC[,19] = cut(trainPC$metric, seq(0,10,0.5))
DtestMetric =  cut(testMetric, seq(0,10,0.5))

#detect outliers
outl = boxplot.stats(trainPC$metric)$out
boxplot(trainPC$metric, main="metric", boxwex=0.1)
mtext(paste("Outliers: ", paste(outl, collapse=", ")), cex=0.6)

#replace outliers from training data with mean
#^ uncomment following lines
#outl_index <- which(trainPC$metric %in% outl)
#trainPC[outl_index,26]  = mean(trainPC$metric)

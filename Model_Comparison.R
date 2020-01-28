# Model Comparison
# Xilei Zhao
# 1/14/2020

rm(list = ls())
cat("\014")

# Load libraries
library(randomForest)

# Read Datasets
mydata = read.csv("evacuation_data_training.csv") # training set
holdout.data = read.csv("evacuation_data_testing.csv")  # testing set

# Data Processing
mydata$AlarmType = as.factor(mydata$AlarmType)
mydata$Response = as.factor(mydata$Response)
holdout.data$AlarmType = as.factor(holdout.data$AlarmType)
holdout.data$Response = as.factor(holdout.data$Response)

# Conduct 10-Fold Cross Validation
numHoldouts = 10
vecMSE = matrix(data=NA,ncol=6,nrow=numHoldouts)

set.seed(1)
# Randomly shuffle the data
mydata<-mydata[sample(nrow(mydata)),]
# Create 10 equally size folds
folds <- cut(seq(1,nrow(mydata)),breaks=10,labels=FALSE)
  
for(i in 1:numHoldouts){

    testIndexes <- which(folds==i,arr.ind=TRUE)
    testData <- mydata[testIndexes, ]
    trainData <- mydata[-testIndexes, ]
    
    #1 Train logistic regression model
    lr0 = glm(Response~., trainData, family = binomial(link = 'logit'))
    #2 Train random forest (RF) model
    rf0 = randomForest(Response~., trainData, ntree = 400, mtry = 7)
    
    # Predict for logistic regression model
    yhat1=predict(lr0,newdata=testData,type='response')
    mydata.test1=testData[,"Response"]
    vecMSE[i,1] = sum(round(yhat1)==mydata.test1)/length(mydata.test1) # Accuracy
    tab = table(round(yhat1), testData$Response) # Confusion matrix
    vecMSE[i,2] = tab[2,2]/sum(tab[2,])  # Precision
    vecMSE[i,3] = tab[2,2]/sum(tab[,2])  # Recall
    
    # Predict for RF model
    yhat1=predict(rf0,newdata=testData,type='class')
    mydata.test1=testData[,"Response"]
    vecMSE[i,4] = sum(yhat1==mydata.test1)/length(mydata.test1) # Accuracy
    tab = table(yhat1, testData$Response) # Confusion matrix
    vecMSE[i,5] = tab[2,2]/sum(tab[2,])  # Precision
    vecMSE[i,6] = tab[2,2]/sum(tab[,2])  # Recall
  
}


# Model Comparison Results from 10-fold Cross Validation
# Logistic regression
# Mean
mean(vecMSE[,1]) # accuracy
mean(vecMSE[,2]) # precision
mean(vecMSE[,3]) # recall
mean(2 * (vecMSE[,2]*vecMSE[,3])/(vecMSE[,2]+vecMSE[,3])) # F1 Score
# Standard deviation
sd(vecMSE[,1]) # accuracy
sd(vecMSE[,2]) # precision
sd(vecMSE[,3]) # recall
sd(2 * (vecMSE[,2]*vecMSE[,3])/(vecMSE[,2]+vecMSE[,3])) # F1 Score

# RF
# Mean
mean(vecMSE[,4]) # accuracy
mean(vecMSE[,5]) # precision
mean(vecMSE[,6]) # recall
mean(2 * (vecMSE[,5]*vecMSE[,6])/(vecMSE[,5]+vecMSE[,6])) # F1 Score
# Standard deviation
sd(vecMSE[,4]) # accuracy
sd(vecMSE[,5]) # precision
sd(vecMSE[,6]) # recall
sd(2 * (vecMSE[,5]*vecMSE[,6])/(vecMSE[,5]+vecMSE[,6])) # F1 Score


# Model Comparison Results for Testing Set
# Train final models
set.seed(123)
lr1 = glm(Response~., mydata, family = binomial(link = 'logit'))
rf1 = randomForest(Response~., mydata, ntree = 400, mtry = 7)

# Logistic regression
yhat1=predict(lr1,newdata=holdout.data,type='response')
mydata.test1=holdout.data[,"Response"]
sum(round(yhat1)==mydata.test1)/length(mydata.test1) # Accuracy
tab = table(round(yhat1), holdout.data$Response)  # Confusion matrix
p.lr = tab[2,2]/sum(tab[2,])  # Precision
r.lr = tab[2,2]/sum(tab[,2])  # Recall
f1.lr = 2 * (p.lr*r.lr)/(p.lr+r.lr)  # F1 Score

# RF
yhat1=predict(rf1,newdata=holdout.data,type='class')
mydata.test1=holdout.data[,"Response"]
sum(yhat1==mydata.test1)/length(mydata.test1) # Accuracy
tab = table(yhat1, holdout.data$Response)  # Confusion matrix
p.rf = tab[2,2]/sum(tab[2,])  # Precision
r.rf = tab[2,2]/sum(tab[,2])  # Recall
f1.rf = 2 * (p.rf*r.rf)/(p.rf+r.rf)  # F1 Score




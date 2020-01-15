# Model Interpretation
# Xilei Zhao
# 1/14/2020

rm(list = ls())
cat("\014")

# Load libraries
library(randomForest)
library(caret)
library(pdp)

# Read training data
mydata = read.csv("evacuation_data_training.csv") # training set

# Train final random forest model
set.seed(1)
rf_final = randomForest(Response~., mydata, ntree = 400, mtry = 7, importance = TRUE)

# Compute variable importance for random forest model
imp = importance(rf_final, type = 1)
imp = imp/sum(imp)
imp  # Output variable importance values

# Compute partial dependence of independent variables
Time <- partial(rf_final, pred.var = "Time", which.class = c('1'),  prob = TRUE)
GroupSize <- partial(rf_final, pred.var = "GroupSize", which.class = c('1'),  prob = TRUE)
VisDMClose_NS <- partial(rf_final, pred.var = "VisDMClose_NS", which.class = c('1'),  prob = TRUE)
Row <- partial(rf_final, pred.var = "Row", which.class = c('1'),  prob = TRUE)
Seat <- partial(rf_final, pred.var = "Seat", which.class = c('1'),  prob = TRUE)
AlarmType <- partial(rf_final, pred.var = "AlarmType", which.class = c('1'),  prob = TRUE)
VisDM_NonNS <- partial(rf_final, pred.var = "VisDM_RS", which.class = c('1'),  prob = TRUE)
VisDMClose_RS <- partial(rf_final, pred.var = "VisDMClose_RS", which.class = c('1'),  prob = TRUE)
DMPerGroup_RS <- partial(rf_final, pred.var = "DMPerGroup_RS", which.class = c('1'),  prob = TRUE)

# Output one-dimensional partial dependence plots
autoplot(Time, ylab = "Probability of choosing RS")
autoplot(GroupSize, ylab = "Probability of choosing RS")
autoplot(VisDMClose_NS, ylab = "Probability of choosing RS")
autoplot(Row, ylab = "Probability of choosing RS")
autoplot(Seat, ylab = "Probability of choosing RS")
autoplot(AlarmType, ylab = "Probability of choosing RS")
autoplot(VisDM_NonNS, ylab = "Probability of choosing RS")
autoplot(VisDMClose_NonNS, ylab = "Probability of choosing RS")
autoplot(DMPerGroup_NonNS, ylab = "Probability of choosing RS")

# Compute and output two-dimensional partial dependence plot
VisDM_RS_row <- partial(rf_final, pred.var = c("VisDM_RS", "Row"), which.class = c('1'), prob = TRUE, plot = TRUE, chull = TRUE)
VisDM_RS_row





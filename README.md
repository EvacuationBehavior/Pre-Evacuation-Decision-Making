# Modelling and Interpreting Pre-Evacuation Decision-Making Using Machine Learning
Implemented by Xilei Zhao, Civil and Coastal Engineering, University of Florida.

# Required Software
R version 3.6.1

# Required Libraries
* randomForest
* caret
* pdp

# File specifications
* Model_Comparison.R: R code for comparing the predictive capability of logistic regression model and random forest model
* Model_Interpretation.R: R code for interpreting random forest model using variable importance and partial dependence plots

# Paper
To be updated soon

# Data
The training and testing datasets (i.e., evacuation_data_training.csv and evacuation_data_testing.csv) have the same data structure as detailed below:
1. Each row is an observation and each column is a variable.
2. There are 10 variables (i.e., 10 columns) in total, including Response, Time, GroupSize, VisDMClose_NS, Row, Seat, AlarmType, VisDM_RS, VisDMClose_RS, DMPerGroup_RS. Please refer to the paper (Subsection 3.1) for the more details about the data and variables.
\\
A simulated dataset (demo.csv) is provided 
\\
The original dataset cannot be publicly released under IRB regulations. For any questions, please contact xilei.zhao@essie.ufl.edu.


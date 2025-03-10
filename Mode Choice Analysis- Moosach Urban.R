#Multinominal Logit Model: A Discrete Choice Analysis

#install.packages("mlogit")
library("corrplot")
library("mlogit")

# Read data
#setwd("~/Mode Choice")
fit_data <- read.csv("1.h.csv", sep = ",")
summary(fit_data)
attach(fit_data)
unique(mode)
prop.table(table(mode))

# Check for correlations
cormtx <- cor(data.frame(age, gender, income, auto_avail))
corrplot(cormtx, method = "number")
fit_data
# Estimate discrete choice model
logit_data <- mlogit.data(fit_data, choice = "mode", shape = "wide", varying = c(8:11))
logit_data
View(as.data.frame(logit_data))
mnl_fit1 <- mlogit(mode ~ 0 | auto_avail | ttime, data = logit_data, weights = weight)
summary(mnl_fit1)
mnl_fit2 <- mlogit(mode ~ ttime | age | 0, data = logit_data, weights = weight, reflevel = "evtol")
summary(mnl_fit2)
mnl_fit3 <- mlogit(mode ~ 0 | age + income | ttime, data = logit_data, weights = weight)
summary(mnl_fit3)
# Change person-specific variables
mnl_fit4 <- mlogit(mode ~ 0 | age + income + auto_avail | ttime, data = logit_data, weights = weight)
summary(mnl_fit4)

# Add binary variables for modes
logit_data$transit <- ifelse(logit_data$alt=="transit",1,0)
logit_data$taxi <- ifelse(logit_data$alt=="taxi",1,0)
logit_data$evtol <- ifelse(logit_data$alt=="evtol",1,0)
logit_data$car <- ifelse(logit_data$alt=="car",1,0)
logit_data

# Model 1 final
mnl_fit12 <- mlogit(mode ~ I(age*taxi) + I(age*evtol) + I(income*evtol) + I(ttime*evtol) + I(ttime*taxi) + I(ttime*transit) | auto_avail | 0 , data = logit_data, weights = weight)
summary(mnl_fit12)

# Model 2 final
mnl_fit13 <- mlogit(mode ~ I(income*transit) + I(age*taxi) + I(age*evtol) + I(auto_avail*transit) + I(ttime*evtol) + I(ttime*taxi) | 1 | 0 , data = logit_data, weights = weight)
summary(mnl_fit13)

library(ggplot2)
ggplot(fit_data, aes(mode,income)) + geom_boxplot()

# Get coefficients
mnl_coeff <- data.frame(coefficients(mnl_fit13))
View(mnl_coeff)

# Simple accuracy check: Predicted versus observed mode shares
model <- apply(predict(mnl_fit13, newdata = logit_data), 2, weighted.mean, w=fit_data$weight)
#$ is to access weight variables (the weight column), accessing weight column to get weighted mean of fit data to find the estimation done.
#2- manipulation is done w.r.to columns. (1 for rows), c(1,2) is for both rows and columns.
# FUN- which function to apply- weighted mean and you define it. 
actual <- prop.table(xtabs(weight~mode, data = fit_data))
# xtabs is used to calculate frequencies of one or more variable.
combine_fits <- cbind(model, actual)
combine_fits

############################
#  Predict mode choice of a test dataset by using the model estimated with training data
############################

# Read in the test dataset
test_data <- read.csv("1.h.test.csv")
# Transform data the same way as training dataset was transformed
logit_test_data <- mlogit.data(test_data, choice = "mode", shape = "wide", varying = 8:11)
logit_test_data$evtol <- ifelse(logit_test_data$alt=="evtol", 1, 0)
logit_test_data$transit <- ifelse(logit_test_data$alt=="transit", 1, 0)
logit_test_data$car <- ifelse(logit_test_data$alt=="car", 1, 0)
logit_test_data$taxi <- ifelse(logit_test_data$alt=="taxi", 1, 0)

# Predict model shares of test data
predict(mnl_fit13, newdata = logit_test_data, weights = weight)

# Compare aggregated predictions
test_predicted <- apply(predict(mnl_fit13, newdata = logit_test_data), 2, weighted.mean, w = test_data$weight)
test_actual <- prop.table(xtabs(weight~mode, data = test_data))

combine_fits <- cbind(combine_fits, test_predicted)
combine_fits <- cbind(combine_fits, test_actual)
combine_fits

# Plot comparison
library(reshape2)
melted_data <- melt(combine_fits)
names(melted_data) <- c("mode", "dataset", "value")

library(ggplot2)
ggplot(melted_data, aes(mode, value)) + geom_bar(aes(fill= dataset),position = "dodge", 
                                                 stat = "identity") + xlab("Mode") + ylab("Percent share")


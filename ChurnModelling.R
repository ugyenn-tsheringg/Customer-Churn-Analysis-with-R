#Data Validation
#1.Importing csv file
setwd("C:/Users/DELL/Desktop/Computer_Science/Year II Sem III/Statistical Programming/Assignment")
library(readr)
churn_modelling <- read_csv('Churn_Modelling.csv')
head(churn_modelling)
churn_modelling$Balance <- as.numeric(churn_modelling$Balance)
str(churn_modelling)

library(e1071)
library(caTools)
library(caret)
str(churn_modelling)
#Spliting data into train and test data. 
new_churn <- subset(churn_modelling, select = -c(Geography, Gender, Balance, EstimatedSalary))
new_churn$Exited <- as.integer(new_churn$Exited)
hi <- as.data.frame(new_churn)
dim(new_churn)
head(new_churn)
split <- sample.split(hi, SplitRatio = 0.7)
train_cl <- subset(hi, split=="TRUE")
test_cl <- subset(hi, split=="FALSE")

str(train_cl)
str(test_cl)

#feature scaling
train_scale <- scale(train_cl[, 1:4])
test_scale <- scale(test_cl[, 1:4])

train_scale
test_scale

set.seed(120)
classifier_cl <- naiveBayes(Exited ~ ., data=train_cl)
classifier_cl

y_pred <- predict(classifier_cl, newdata = test_cl)
y_pred

cm <- table(test_cl$Exited, y_pred)
cm

confusionMatrix(cm)

#2. Summary Statistics
summary(churn_modelling)

#3. Data Profiling
library('DataExplorer')
create_report(churn_modelling)

#Removing duplicates
sum(duplicated(churn_modelling))
library(dplyr)
stats <- distinct(churn_modelling)
sum(duplicated(stats))
churn_modelling_new <- unique(churn_modelling)
rownames(churn_modelling_new) <- 1:nrow(churn_modelling_new)
sum(duplicated(churn_modelling_new))

#handling missing data
missing_value <- colSums(is.na(churn_modelling_new))
missing_value
mean_age <- mean(churn_modelling_new$Age, na.rm=TRUE)
mean_Tenure <- mean(churn_modelling_new$Tenure, na.rm=TRUE)
mean_Balance <- mean(churn_modelling_new$Balance, na.rm=TRUE)

churn_modelling_new$Age[is.na(churn_modelling_new$Age)] <- mean_age
churn_modelling_new$Tenure[is.na(churn_modelling_new$Tenure)] <- mean_Tenure
churn_modelling_new$Balance[is.na(churn_modelling_new$Balance)] <- mean_Balance

sum(is.na(churn_modelling_new))

#Encoding categorical variables 
#changing to lowercase
churn_modelling_new$Geography <- tolower(churn_modelling_new$Geography)
churn_modelling_new$Gender <- tolower(churn_modelling_new$Gender)

#changing to category using factor
churn_modelling_new$Geography <- factor(churn_modelling_new$Geography)
churn_modelling_new$Gender <- factor(churn_modelling_new$Gender)

head(levels(churn_modelling_new$Geography)[as.integer(churn_modelling_new$Geography)])
head(levels(churn_modelling_new$Geography)[1] <- "france")
head(levels(churn_modelling_new$Geography)[2] <- "germany")
head(as.numeric(churn_modelling_new$Geography))

head(levels(churn_modelling_new$Gender)[as.integer(churn_modelling_new$Gender)])
head(levels(churn_modelling_new$Gender) <- c(0,1))
churn_modelling_new$Gender <- as.numeric(as.character(churn_modelling_new$Gender))
head(churn_modelling_new$Gender)

#detecting outliers
churn_modelling_new <- subset(churn_modelling_new, select = -c(Geography, Gender))
boxplot(churn_modelling_new)
boxplot(churn_modelling_new, plot = FALSE)$out

#removing outliers
Q1_age <- quantile(churn_modelling_new$Age, .25)
Q3_age <- quantile(churn_modelling_new$Age, .75)
IQR <- IQR(churn_modelling_new$Age)
churn_modelling_final <- subset(churn_modelling_new, churn_modelling_new$Age> (Q1_age - 1.5*IQR) & churn_modelling_new$Age< (Q3_age + 1.5*IQR))
boxplot(churn_modelling_final)
boxplot(churn_modelling_final, plot = FALSE)$out

#Separating dataset into 2 groups based on exited and not-exited
exited_data <- subset(churn_modelling_final, Exited==1,
select = -c(Exited))
head(exited_data)

notExited_data <- subset(churn_modelling_final, Exited ==0,
                         select = -c(Exited))
head(notExited_data)

#Measure of Central Tendency for exited
exited_means <- colMeans(exited_data, na.rm = TRUE) # Calculating mean
exited_median <- apply(exited_data, 2, median, na.rm = TRUE)# Calculating median
get_mode <- function(exited_data) { # Calculating mode
  uniq_values <- unique(exited_data)
  uniq_values[which.max(tabulate(match(exited_data, uniq_values)))]
}
exited_mode <- sapply(exited_data, get_mode)

#constructing dataframe
exited_cot <- data.frame(exited_means, exited_median, exited_mode)
exited_cot

#Measure of Dispersion for exited
exited_variance <- sapply(exited_data, var, na.rm = TRUE) # Calculate variance
exited_sd <- sapply(exited_data, sd, na.rm = TRUE) # Calculate standard deviation
exited_mod <- data.frame(exited_variance, exited_sd)
exited_mod

#Combining all statistics of 
exited_final <- data.frame(exited_cot, exited_mod)
exited_final

#Measure of Central Tendency for not-exited 
not_exited_means <- colMeans(notExited_data, na.rm = TRUE)# Calculating mean
not_exited_median <- apply(notExited_data, 2, median, na.rm = TRUE) # Calculating median
get_mode2 <- function(notExited_data) { # Calculating mode
  uniq_values <- unique(notExited_data)
  uniq_values[which.max(tabulate(match(notExited_data, uniq_values)))]
}
not_exited_mode <- sapply(notExited_data, get_mode2)

#constructing dataframe
not_exited_cot <- data.frame(not_exited_means, not_exited_median, not_exited_mode)
not_exited_cot

#Measure of Dispersion for not exited
not_exited_variance <- sapply(notExited_data, var, na.rm = TRUE) # Calculate variance
not_exited_sd <- sapply(notExited_data, sd, na.rm = TRUE) # Calculate standard deviation
not_exited_mod <- data.frame(not_exited_variance, not_exited_sd)
not_exited_mod

not_exited_final <- data.frame(not_exited_cot, not_exited_mod)
not_exited_final

#Visualization
# Install and load necessary library
library(ggplot2)
library(reshape2)

# Melt the data to long format for easier plotting
numerical_vars <- c('CreditScore', 'Balance', 'EstimatedSalary')
churn_melt <- melt(churn_modelling_new[, c(numerical_vars, 'Exited')], id.vars = 'Exited')

# Create a box plot for all numerical variables vs Exited
ggplot(churn_melt, aes(x = variable, y = value, fill = as.factor(Exited))) +
  geom_boxplot() +
  labs(title = "Box Plots of Numerical Variables vs Exited", x = "Numerical Variables", y = "Values") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("#FF9999", "#66B2FF"))

library(gridExtra)

# Histogram for Age with Exited
p1 <- ggplot(churn_modelling_new, aes(x = Age, fill = as.factor(Exited))) +
  geom_histogram(binwidth = 5, position = "dodge", alpha = 0.7) +
  labs(title = "Histogram of Age vs Exited", x = "Age", y = "Count", fill = "Exited") +
  theme_minimal()

# Histogram for Tenure with Exited
p2 <- ggplot(churn_modelling_new, aes(x = Tenure, fill = as.factor(Exited))) +
  geom_histogram(binwidth = 1, position = "dodge", alpha = 0.7) +
  labs(title = "Histogram of Tenure vs Exited", x = "Tenure", y = "Count", fill = "Exited") +
  theme_minimal()

# Combine both histograms into one graph
grid.arrange(p1, p2, ncol = 2)

# Bar plot for Gender vs Exited
p1 <- ggplot(churn_modelling, aes(x = Gender, fill = as.factor(Exited))) +
  geom_bar(position = "dodge", alpha = 0.7) +
  labs(title = "Bar Plot of Gender vs Exited", x = "Gender", y = "Count", fill = "Exited") +
  theme_minimal() +
  scale_fill_manual(values = c("#FF9999", "#66B2FF"))

# Bar plot for Geography vs Exited
p2 <- ggplot(churn_modelling, aes(x = Geography, fill = as.factor(Exited))) +
  geom_bar(position = "dodge", alpha = 0.7) +
  labs(title = "Bar Plot of Geography vs Exited", x = "Geography", y = "Count", fill = "Exited") +
  theme_minimal() +
  scale_fill_manual(values = c("#FF9999", "#66B2FF"))

# Combine the two bar plots into one graph
grid.arrange(p1, p2, ncol = 2)

# Data Preparation
gender_table <- table(churn_modelling$Gender)
geography_table <- table(churn_modelling$Geography)

# Pie chart for Gender
p1 <- ggplot(as.data.frame(gender_table), aes(x = "", y = Freq, fill = Var1)) +
  geom_bar(stat = "identity", width = 1, alpha = 0.7) +
  coord_polar(theta = "y") +
  labs(title = "Pie Chart of Gender Distribution", fill = "Gender") +
  theme_void() +
  scale_fill_manual(values = c("#FF9999", "#66B2FF"))

# Pie chart for Geography
p2 <- ggplot(as.data.frame(geography_table), aes(x = "", y = Freq, fill = Var1)) +
  geom_bar(stat = "identity", width = 1, alpha = 0.7) +
  coord_polar(theta = "y") +
  labs(title = "Pie Chart of Geography Distribution", fill = "Geography") +
  theme_void() +
  scale_fill_manual(values = c("blue", "green", "red"))

# Combine the two pie charts into one graph
grid.arrange(p1, p2, ncol = 2)
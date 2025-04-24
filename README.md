# Customer Churn Analysis: A Comprehensive Statistical Approach

## Overview

This repository contains a complete analysis of the "Churn Modelling" dataset, focusing on understanding customer churn patterns for a bank. The project employs various statistical methods and data visualization techniques to uncover key insights about customer behavior and factors influencing churn.

## Table of Contents

1. [Introduction](#introduction)
2. [Dataset Overview](#dataset-overview)
3. [Data Processing](#data-processing)
4. [Analysis](#analysis)
5. [Visualizations](#visualizations)
6. [Conclusion](#conclusion)
7. [Usage](#usage)
8. [Requirements](#requirements)

## Introduction

Customer churn is a critical metric for businesses, especially in the banking sector. This project aims to analyze the factors that influence whether a customer will close their account with a bank. We utilize statistical methods, data validation, handling missing data, outlier detection, encoding, and principal component analysis (PCA) to gain meaningful insights.

## Dataset Overview

The dataset consists of 500 entries with the following features:
- **CreditScore**: Numerical score representing the customer's credit rating.
- **Geography**: Country where the customer is located (e.g., France, Spain).
- **Gender**: Customer’s gender (Male or Female).
- **Age**: Customer’s age.
- **Tenure**: Number of years the customer has been with the bank.
- **Balance**: Balance in the customer's bank account.
- **EstimatedSalary**: Customer’s estimated annual salary.
- **Exited**: Binary target variable indicating whether the customer has left the bank (1=exited, 0=remained).

[Dataset Source](https://www.kaggle.com/datasets/shrutimechlearn/churn-modelling/data)

## Data Processing

### Steps Undertaken:
1. **Loading the Data**
   - Using `readr` library to load the dataset.
   
2. **Data Validation**
   - Summary statistics using `summary()` function.
   - Data profiling using `DataExplorer` package.

3. **Handling Missing Data**
   - Identification and imputation of missing values.

4. **Encoding Categorical Variables**
   - Conversion of categorical variables into numerical representations using `factor()`.

5. **Outlier Detection and Removal**
   - Identification and removal of outliers using IQR method.

## Analysis

### Key Findings:
- **Credit Score**: Customers who did not exit tend to have better credit scores than those who exited.
- **Age**: Non-exited customers are generally younger, with most common age around 35.
- **Tenure**: Long-term customers show higher retention rates.
- **Balance**: Higher balance customers are more likely to leave.
- **Estimated Salary**: Wide variability observed among both groups.

### Statistical Measures:
- Central tendency and dispersion measures were calculated for both exited and non-exited groups.

## Visualizations

Various visualizations were created to understand the data better:

1. **Box Plots**:
   - Comparison of CreditScore, Balance, and EstimatedSalary between exited and non-exited customers.
   
2. **Histograms**:
   - Age and Tenure distributions against the Exited variable.
   
3. **Bar Plots**:
   - Gender and Geography distributions against the Exited variable.

## Conclusion

The analysis revealed several actionable insights:
- Middle-aged and German customers have a higher likelihood of exiting.
- Customers with higher balances and shorter tenures are more likely to leave.
- Targeted interventions for specific customer segments could improve retention efforts.

## Usage

To run the code locally, follow these steps:

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/customer-churn-analysis.git

2. Install the required packages:
   ```bash
   install.packages(c("readr", "DataExplorer", "ggplot2", "reshape2"))

3. Run the R script:
   ```bash
   source("path_to_your_script.R")

## Requirements
R version 4.x.x
Required Libraries: readr, DataExplorer, ggplot2, reshape2

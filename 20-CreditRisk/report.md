# Module 12 Report 
### Alexandra Blitch

## Overview of the Analysis
* Explain the purpose of the analysis.
    The purpose of the analysis was to create a model that could identify whether someone was a high or low risk for defaulting on their loan.
* Explain what financial information the data was on, and what you needed to predict.
    The data was based on lending information from a lending services group. We had data that showed someone's loan size, debt to income ratio, income, interest rate, number of accounts, total debt, and derogatory marks, and whether they were deemed high or low risk. We created a model to try to predict whether someone would be high or low risk based on all of that information.
* Provide basic information about the variables you were trying to predict (e.g., `value_counts`).
    We had a much higher amount of high risk loans than low risk in our dataset. Loan status showed a correlation of about 0.75 with all of the other variables, except debt-to-income ratio (0.59) and derogatory marks (0.55).
* Describe the stages of the machine learning process you went through as part of this analysis.
    First I split the data into a training set and a testing set. The training set is used to create the model, and then the model is run on the testing set to validate the model. I ran through multiple models and compared their scores to determine which model is the best for this dataset.
* Briefly touch on any methods you used (e.g., `LogisticRegression`, or any resampling method).
    1. Logistic Regression - Used for classification; predicts binary outcomes
    2. Support Vector Machine - Mathematical and complex
    3. K-Nearest Neighbor - Very explainable but not mathematical
    4. Decision Tree - Explainable, able to trace decision logic through each step, but not restricted by linear assumptions
    5. Random Forest - Treats all trees as equal
    6. AdaBoost - Adjusts weights of samples at each iteration
    7. Gradient Boost - Adds weak learners to minimize the loss function

## Results

* Logistic Regression:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 1.00 for low risk; 0.91 for high risk

* Support Vector Machine:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 0.99 for low risk; 0.99 for high risk
  
* K-Nearest Neighbor:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 0.99 for low risk; 0.99 for high risk

* Decision Tree:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 1.00 for low risk; 0.85 for high risk
  
* Random Forest:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 0.99 for low risk; 0.90 for high risk

* AdaBoost:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 0.99 for low risk; 1.00 for high risk

* Gradient Boost:
  * Accuracy: 0.99
  * Precision: 1.00 for low risk; 0.85 for high risk
  * Recall: 0.99 for low risk; 0.98 for high risk


## Summary

Ada Boost is the best model to use for this dataset. It does not overfit. It has the lowest number of false negatives, which is important in this scenario because we do not want to mistakenly mark a high risk loan request as low risk. Ada Boost model has a few more false positives than Gradient Boost, but we would still choose Ada in this scenario because of the false negatives.



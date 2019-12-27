#!usr/bin/env python
# -*- coding: utf-8 -*-
# Script:       main.py
# Description:  MAIN function of the VG4-predictor
# Update date:  2019/12/27(unfinished)
# Author:       Zhuofan Zhang
'''
    Notes that this script is a temporary one.
    After test the pipeline, I will rebuild it in more
    moduling style. 
'''

from dataset import G4_dataset
from validation_test import ROC_plot, Kfold_cross_validation, ROC_test_plot
from sklearn.model_selection import KFold, cross_val_score
import pandas as pd
import numpy as np
import argparse
# Classifier modules
from xgboost import XGBClassifier
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression

# Parameters
RANDOM_STATE = 42
KFOLD = 5

# Arguments-Parsing
parser = argparse.ArgumentParser()
parser.add_argument('--vg4', help="VG4-ATAC overlapped CSV file.")
parser.add_argument('--ug4', help="UG4-ATAC overlapped CSV file.")
parser.add_argument('--kfroc', default="./KFold_ROC", help="output kfold-validation-ROC curve picture file name.")
parser.add_argument('--testroc', default="./test_ROC", help="output test-ROC curve picture file name.")
args = parser.parse_args()

# Load Data
g4_dataset = G4_dataset(args.vg4, args.ug4, random_state=RANDOM_STATE)
train_data = g4_dataset.get_training_set(trainset_size=8000,random_state=RANDOM_STATE)
train_labels = train_data.pop('Label')
test_data = g4_dataset.get_test_set(testset_size=8000,test_random_state=RANDOM_STATE)
test_labels = test_data.pop('Label')

# Hyper-parameters
xgb_params = {
                'seed':RANDOM_STATE,
                'learning_rate':0.2,
                'gamma':0.3,
                'subsample':0.7,
                'colsample_bytree':0.8,
                'n_estimators':1000
              }

svc_params = {
                'random_state':RANDOM_STATE,
                'C':1.0,
                'kernel':'rbf',
             }

rf_params = {
                'random_state':RANDOM_STATE,
                'n_estimators': 1000,
                'criterion':'gini'
            }

lr_params = {
                'random_state':RANDOM_STATE,
                'penalty':'l2',
                'C':1    
            }

# Classfiers
xgb = XGBClassifier(param_grid = xgb_params)

svc = SVC()
svc.set_params(**svc_params)

rf = RandomForestClassifier()
rf.set_params(**rf_params)

lr = LogisticRegression()
lr.set_params(**lr_params)

Classifiers = {
                'xgboost_classifier':xgb,
                'support vector machine':svc,
                'randomforest':rf,
                'logistic regression':lr
              }


for (clf_name, clf) in Classifiers.items():
    kfroc_name = args.kfroc + "_{}_randomstate{}.png".format(clf_name, RANDOM_STATE)
    testroc_name = args.testroc + "_{}_randomstate{}.png".format(clf_name, RANDOM_STATE)
    # 5-Fold Validation ROC
    ROC_plot(clf, train_data.to_numpy(), train_labels.to_numpy(), 
             n_splits=5, res_pic=kfroc_name, clf_name = clf_name)

# Test score and ROC
ROC_test_plot(Classifiers, X=train_data.to_numpy(), y=train_labels.to_numpy(),
              X_test=test_data.to_numpy(), y_test=test_labels.to_numpy(), res_pic=testroc_name)


#!/usr/bin/bash 
# Script: workflow.sh
# Description: Select-Seq-Model workflow
# Update date: 2019/08/04(unfinished)
# Author: Zhuofan Zhang

python3=""
SCRIPTS=""
MODEL=""
RESULT=""
NLIST=""

#### MODEL-TRAINING ####

# STEP1: Get Queries length list
perl -w $SCRIPTS/qlen-stat.pl $RESULT > qlen.stats

# STEP2: Preprocess the result
perl -w $SCRIPTS/train-preprocess.pl $RESULT $NLIST qlen.stats > handled.result

# STEP3: Evaluate the probability of align-results being true
$python3 $SCRIPTS/select.py -i handled.result --mode train -o $MODEL


#!/usr/bin/bash
# Script: Performance.sh
# Description:
# Update data: 2019/07/11(unfinished: Need to preprocess the USEARCH result)
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/
python=$WORKPATH/tools/python3.4/bin/python3

#### PREPROCESS FOR USEARCH RESULT ####
#######################################


$python $WORKPATH/TEST-DEMO/scripts/Performance.py --fapath $WORKPATH/TEST-DEMO/FASTA/Databases \
        --repath $WORKPATH/TEST-DEMO/Align-Results




#!/usr/bin/bash
# Script: testing.sh
# Description: Do alignment using blast+/blat/usearch [USE SGE]
# Usage: bash 3.testing.sh [query-length] [subsample seed] [Unique ID]
# Update date: 2019/07/24
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

DB=$(ls ${WORKPATH}/B10K-Test/FASTA/DBLINK | grep "fa$" | sed "s:^:${WORKPATH}/B10K-Test/FASTA/DBLINK/:")
LOG=$WORKPATH/B10K-Test/Test-Log
RESULT=$WORKPATH/B10K-Test/Align-Results
QLEN=$1 # Get query-length
SEED=$2 # Get subsample seed
ID=$3   #For one test, set an unique id fot it 
tools=("blast" "blat" "usearch")



if [ ! -d "$RESULT" ];then
    mkdir $RESULT
fi

for i in `seq 1 3`
do
    qsub -cwd -l vf=4G,num_proc=10 -binding linear:1 -q hadoop_blast.q \
         -v qlen=$QLEN,seed=$SEED,id=$ID $WORKPATH/B10K-Test/scripts/3_${i}.testing-${tools[$($i-1)]}.sh
done


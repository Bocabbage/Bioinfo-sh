#!/usr/bin/bash
# Script: testing.sh
# Description: Do alignment using blast+
# Usage: bash 1_1.testing-blast.sh [query-length] [subsample seed] [Unique ID]
# Update date: 2019/08/02
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

BLAST=$WORKPATH/1.BLAST/ncbi-blast-2.9.0+/bin
DBPATH=${WORKPATH}/OneKP/MergeDB/Merge-NUCL
DB=${DBPATH}/onekp-ncbi-nucl.fa
LOG=$WORKPATH/OneKP/MergeTest/Log
RESULT=$WORKPATH/OneKP/MergeTest/Align-Results

ID=$1   #For one test, set an unique id fot it 
QUERY=$WORKPATH/OneKP/MergeTest/Queries/${ID}.fa

if [ ! -d "$LOG" ];then
    mkdir -p $LOG
fi


if [ ! -d "$RESULT" ];then
    mkdir -p $RESULT
fi

# PARAMETERS #
# BLAST
b_evalue=1e-6
word_size=12
threads=10



#### BLAST+ TESTING ####
echo "#########################" >> $LOG/${ID}.blast.log && \
echo BLAST+ test starts at `date` >> $LOG/${ID}.blast.log && \
(time $BLAST/blastn -query $QUERY -out $RESULT/${ID}.blast -db $DB -outfmt 6 -evalue $b_evalue -num_threads $threads ;) >> $LOG/${ID}.blast.log && \
echo BLAST+ test ends at `date` >> $LOG/${ID}.blast.log && \
echo "|  ID: $ID  |  Q-len: $QLEN  |  SEED: $SEED  |  E-VALUE: $b_evalue  |  THREADS: $threads  |" >> $LOG/blast.log && \
echo "#########################" >> $LOG/${ID}.blast.log && \
echo "BLAST+ test finished!" > $LOG/${ID}.blast.sign


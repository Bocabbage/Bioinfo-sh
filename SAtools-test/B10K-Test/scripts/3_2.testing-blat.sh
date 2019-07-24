#!/usr/bin/bash
# Script: testing.sh
# Description: Do alignment using blat
# Usage: bash 3_2.testing-blat.sh [query-length] [subsample seed] [Unique ID]
# Update date: 2019/07/24
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

BLAT=$WORKPATH/2.BLAT/bin/x86_64
DB=$(ls ${WORKPATH}/B10K-Test/FASTA/DBLINK | grep "fa$" | sed "s:^:${WORKPATH}/B10K-Test/FASTA/DBLINK/:")
LOG=$WORKPATH/B10K-Test/Test-Log
RESULT=$WORKPATH/B10K-Test/Align-Results/BLAT
QLEN=$1 # Get query-length
SEED=$2 # Get subsample seed
ID=$3   #For one test, set an unique id fot it 
QUERY=$WORKPATH/B10K-Test/FASTA/query-seed${SEED}_fixlen-${QLEN}.fa




if [ ! -d "$RESULT" ];then
    mkdir -p $RESULT
fi

# PARAMETERS #
# BLAT



#### BLAT TESTING ####
echo "#########################" >> $LOG/blat.log && \
echo BLAT test starits at `date` >> $LOG/blat.log && \
i=0 && \
for db in $DB
do
    $BLAT/blat $db $QUERY -out=blast8 $RESULT/${ID}_${i}.blat.temp && \
    $i = $($i + 1)
done && \
echo BLAT test ends at `date` >> $LOG/blat.log && \
cat $RESULT/*.blat.temp > $RESULT/${ID}.blat && \
rm -f $RESULT/*.blat.temp && \
echo "|  ID: $ID  |  Q-len: $QLEN  |  SEED: $SEED  |  default  |" >> $LOG/blat.log &&\
echo "#########################" >> $LOG/blat.log && \
echo "BLAT test finished!" > $LOG/blat.sign


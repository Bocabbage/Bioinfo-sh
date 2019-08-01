#!/usr/bin/bash
# Script: testing.sh
# Description: Do alignment using usearch
# Usage: bash 3_3.testing-usearch.sh [query-length] [subsample seed] [Unique ID]
# Update date: 2019/07/24
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

USEARCH=$WORKPATH/3.USEARCH
DB=$(ls ${WORKPATH}/B10K-Test/FASTA/DBLINK | grep "fa$" | sed "s:^:${WORKPATH}/B10K-Test/FASTA/DBLINK/:")
LOG=$WORKPATH/B10K-Test/Test-Log
RESULT=$WORKPATH/B10K-Test/Align-Results
QLEN=$1 # Get query-length
SEED=$2 # Get subsample seed
ID=$3   #For one test, set an unique id fot it 
QUERY=$WORKPATH/B10K-Test/FASTA/query-seed${SEED}_fixlen-${QLEN}.fa




# USEARCH
identify=0.9
u_evalue=1e-4
MA=100
MR=50000

#### USEARCH TESTING ####
echo "#########################" >> $LOG/usearch_local.log && \
echo USEARCH test starts at `date` >> $LOG/usearch_local.log && \
for db in $DB
do
    $USEARCH/usearch -usearch_local $QUERY -db $db \
                     -id $identify -evalue $u_evalue -blast6out $RESULT/${ID}_${i}.usearch_local.temp -strand plus \
                     -maxaccepts $MA -maxrejects $MR && \
    $i = $($i + 1)
done && \
echo USEARCH test ends at `date` >> $LOG/usearch_local.log && \
cat $RESULT/*.usearch_local.temp > $RESULT/${ID}.usearch_local &&\
rm -f $RESULT/*.usearch_local.temp
echo "|  ID: $ID  |  Q-len: $QLEN  |  SEED: $SEED  |  MA/MR: $MA / $MR  |  E-VALUE: $u_value  |" >> $LOG/usearch_local.log &&\
echo "#########################" >> $LOG/usearch_local.log && \
echo "USEARCH test finished!" > $LOG/usearch_local.sign


#echo USEARCH test starts at `date` > $LOG/usearch_global.log &&
#$USEARCH/usearch -usearch_global $DATA/query.fa -db $DATA/database.fa \
#                 -id 0.9 -evalue 1e-6 -blast6out usearch_global.b6 \
#                 -strand plus -maxaccepts 100 -maxrejects 50000 && \
#echo USEARCH test ends at `date` >> $LOG/usearch_global.log && \
#echo "USEARCH test finished!" > $LOG/usearch_global.sign



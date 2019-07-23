#!/usr/bin/bash
# Script: testing.sh
# Description: Do alignment using blast+/blat/usearch
# Usage: bash 3.testing.sh [query-length] [subsample seed] [Unique ID]
# Update date: 2019/07/23
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

BLAST=$WORKPATH/1.BLAST/ncbi-blast-2.9.0+/bin
BLAT=$WORKPATH/2.BLAT/bin/x86_64
USEARCH=$WORKPATH/3.USEARCH
DB=$(ls ${WORKPATH}/B10K-Test/FASTA/DBLINK | grep "fa$" | sed "s:^:${WORKPATH}/B10K-Test/FASTA/DBLINK/:")
LOG=$WORKPATH/B10K-Test/Test-Log
RESULT=$WORKPATH/B10K-Test/Align-Results
QLEN=$1 # Get query-length
SEED=$2 # Get subsample seed
ID=$3   #For one test, set an unique id fot it 
QUERY=$WORKPATH/B10K-Test/FASTA/query-seed${SEED}_fixlen-${QLEN}.fa




if [ ! -d "$RESULT" ];then
    mkdir $RESULT
fi

# PARAMETERS #
# BLAST
b_evalue=1e-6
threads=1
# BLAT
# USEARCH
identify=0.9
u_evalue=1e-4
MA=100
MR=50000



#### BLAST+ TESTING ####
echo "#########################" >> $LOG/blast.log && \
echo BLAST+ test starts at `date` >> $LOG/blast.log && \
i=0 && \
for db in $DB
do
    $BLAST/blastn -query $QUERY -out $RESULT/${ID}_${i}.blast.temp -db $db \
                -outfmt 6 -evalue $b_evalue -num_threads $threads && \
    $i = $($i + 1) 
done && \
echo BLAST+ test ends at `date` >> $LOG/blast.log && \
cat $RESULT/*.blast.temp > $RESULT/${ID}.blast && \
rm -f $RESULT/*.blast.temp && \
echo "|  ID: $ID  |  Q-len: $QLEN  |  SEED: $SEED  |  E-VALUE: $b_evalue  |  THREADS: $threads  |" >> $LOG/blast.log && \
echo "#########################" >> $LOG/blast.log && \
echo "BLAST+ test finished!" > $LOG/blast.sign

#### BLAT TESTING ####
echo "#########################" >> $LOG/blat.log && \
echo BLAT test starits at `date` >> $LOG/blat.log && \
i=0 && \
for db in $DB
do
    $BLAT/blat $DB $QUERY -out=blast8 $RESULT/${ID}_${db}.blat.temp
done && \
echo BLAT test ends at `date` >> $LOG/blat.log && \
cat $RESULT/*.blat.temp > $RESULT/${ID}.blat && \
rm -f $RESULT/*.blat.temp && \
echo "|  ID: $ID  |  Q-len: $QLEN  |  SEED: $SEED  |  default  |" >> $LOG/blat.log &&\
echo "#########################" >> $LOG/blat.log && \
echo "BLAT test finished!" > $LOG/blat.sign

#### USEARCH TESTING ####
echo "#########################" >> $LOG/usearch_local.log && \
echo USEARCH test starts at `date` >> $LOG/usearch_local.log && \
for db in $DB
do
    $USEARCH/usearch -usearch_local $QUERY -db $db \
                     -id $identify -evalue $u_evalue -blast6out $RESULT/${ID}_${db}.usearch_local.temp -strand plus \
                     -maxaccepts $MA -maxrejects $MR
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



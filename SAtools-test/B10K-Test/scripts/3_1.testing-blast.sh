#!/usr/bin/bash
# Script: testing.sh
# Description: Do alignment using blast+
# Usage: bash 3_1.testing-blast.sh [query-length] [subsample seed] [Unique ID]
# Update date: 2019/07/24
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

BLAST=$WORKPATH/1.BLAST/ncbi-blast-2.9.0+/bin
DB=$(ls ${WORKPATH}/B10K-Test/FASTA/DBLINK | grep "fa$" | sed "s:^:${WORKPATH}/B10K-Test/FASTA/DBLINK/:")
LOG=$WORKPATH/B10K-Test/Test-Log
RESULT=$WORKPATH/B10K-Test/Align-Results/BLAST
QLEN=${qlen} # Get query-length
SEED=${seed} # Get subsample seed
ID=${id}     #For one test, set an unique id fot it 
QUERY=$WORKPATH/B10K-Test/FASTA/query-seed${SEED}_fixlen-${QLEN}.fa




if [ ! -d "$RESULT" ];then
    mkdir -p $RESULT
fi

# PARAMETERS #
# BLAST
b_evalue=1e-6
threads=10



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


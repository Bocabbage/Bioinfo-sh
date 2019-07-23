#!/usr/bin/bash
# Script: makeblastdb.sh
# Description: MakeBlastdb Index.
# Update date: 2019/07/23
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools
BLAST=$WORKPATH/1.BLAST/ncbi-blast-2.9.0+/bin
DB=$WORKPATH/B10K-Test/FASTA/DATABASE
LOG=$WORKPATH/B10K-Test/Test-Log
LINK=$WORKPATH/B10K-Test/FASTA/DBLINK
FASTA_LIST=$(ls $DB)
if [ ! -d "$LOG" ];then
    mkdir $LOG
fi

if [ ! -d "$LINK" ];then
    mkdir $LINK
fi

#### BLAST+ MAKE-DATABASE ####
echo "#########################" >> $LOG/makeblastdb.log
echo BLAST+ makedb starts at `date` >> $LOG/makeblastdb.log && \
for FA in $FASTA_LIST
do
    $BLAST/makeblastdb -in $DB/$FA/${FA}_database.fa -dbtype nucl
done && \
echo BLAST+ makedb ends at `date` >> $LOG/makeblastdb.log && \
echo "#########################" >> $LOG/makeblastdb.log && \
echo "BLAST makedb done!" > $LOG/makeblastdb.sign

for FA in $FASTA_LIST
do
    ln -s $DB/$FA/*.fa $LINK
    mv $DB/$FA/*.nhr $LINK
    mv $DB/$FA/*.nin $LINK
    mv $DB/$FA/*.nsq $LINK
done


#!/usr/bin/bash
# Script: sampling.sh
# Description: Random extracting sequences as 'query' from the database and the remainder as the 'database'
# Update date: 2019/07/22
# Author: Zhuofan Zhang
TOOLPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/tools
python=$TOOLPATH/python3.4/bin/python3
seqtk=$TOOLPATH/seqtk/seqtk
DB=/zfssz3/NGB_DB/shenweiyan/backupDB/B10K/NuclSeq
WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/B10K-Test

QNUMS=10000
DBNUMS=$(ls $DB | wc -l)
DQNUMS=$[$QNUMS / $DBNUMS]
echo $DQNUMS
QLEN=200

cd $WORKPATH

if [ ! -d "$WORKPATH/FASTA" ];then
    mkdir $WORKPATH/FASTA
else
    rm -rf $WORKPATH/FASTA/
    mkdir $WORKPATH/FASTA
    echo "FASTA DIR EXISTS!"
fi
 
FASTA_LIST=$(ls $DB)
for FA in $FASTA_LIST
do
    $seqtk sample -s700 $DB/$FA/${FA}.fa $DQNUMS > FASTA/${FA}_query.fa.temp && \
    less FASTA/${FA}_query.fa.temp | grep '>' | sed 's/>//g' | sort -o FASTA/query_name.lst && \
    less $DB/$FA/${FA}.fa | grep '>' | sed 's/>//g' | sort -o FASTA/all_name.lst && \
    grep -vf FASTA/query_name.lst FASTA/all_name.lst > FASTA/db_name.lst && \
    mkdir -p FASTA/DATABASE/${FA} && \
    $seqtk subseq $DB/$FA/${FA}.fa FASTA/db_name.lst > FASTA/DATABASE/${FA}/${FA}_database.fa && \
    awk -v species=$FA '{if($1~"^>"){print $0,species} else print $0}' FASTA/${FA}_query.fa.temp > FASTA/${FA}_query_s.fa.temp && \
    rm -f FASTA/${FA}_query.fa.temp && \
    rm -f *.lst
        
done

cat FASTA/*.temp > FASTA/query.fa
rm -f *.temp

$python $WORKPATH/scripts/FixLenQueries.py -i FASTA/query.fa -o FASTA/query_fixlen-${QLEN}.fa --length $QLEN --seed 100

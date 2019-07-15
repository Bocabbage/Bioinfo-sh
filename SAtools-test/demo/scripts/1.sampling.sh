#!/usr/bin/bash
# Script: sampling.sh
# Description: Random extracting sequences as 'query' from the database and the remainder as the 'database'
# Update date: 2019/07/10
# Author: Zhuofan Zhang
# Problem: Rfam database has redundant sequence(Solved)
TOOLPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/tools
python=$TOOLPATH/python3.4/bin/python3
seqtk=$TOOLPATH/seqtk/seqtk

cd /hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/TEST-DEMO
RAWDATA=./FASTA/Merge.fa
DATA=./FASTA/Merge_dedup.fa
DEDUP=./scripts/Deduplicate.py

if [ ! -d "./FASTA" ];then
    mkdir ./FASTA
    #wget -P ./FASTA $DATALINK
    #gunzip $DATALINK
    $python $DEDUP --input $RAWDATA --output $DATA 
fi 

if [ ! -d "Sample-Result" ];then
    mkdir Sample-Result
fi

$seqtk sample -s700 $DATA 500 > Sample-Result/query.fa
less Sample-Result/query.fa | grep '>' | sed 's/>//g' | sort -o Sample-Result/query_name.lst
less $DATA | grep '>' | sed 's/>//g' | sort -o  Sample-Result/all_name.lst
grep -vf Sample-Result/query_name.lst Sample-Result/all_name.lst > Sample-Result/db_name.lst
$seqtk subseq $DATA Sample-Result/db_name.lst > Sample-Result/database.fa

# IF NEED CHECK #
# Check sequence numbers: less NAME.fa | grep '>' | wc -l


cd Sample-Result
rm *.lst

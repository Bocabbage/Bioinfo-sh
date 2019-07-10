#!/usr/bin/bash
# Script: sampling.sh
# Description: Random extracting 1,000 sequences as 'query' from the database and the remainder as the 'database'
# Update date: 2019/07/10
# Author: Zhuofan Zhang
# Problem: Rfam database has redundant sequence?(more than 1 seq have the name)
TOOLPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/tools
seqtk=$TOOLPATH/seqtk/seqtk

cd /hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/TEST-DEMO
if [ ! -d "Sample-Result" ];then
    mkdir Sample-Result
fi

$seqtk sample -s100 FASTA/RF00230.fa 100 > Sample-Result/query.fa
less Sample-Result/query.fa | grep '>' | sed 's/>//g' | sort -o Sample-Result/query_name.lst
less FASTA/RF00230.fa | grep '>' | sed 's/>//g' | sort -o  Sample-Result/all_name.lst
comm -3 Sample-Result/query_name.lst Sample-Result/all_name.lst | sed 's/\t//g' | uniq > Sample-Result/db_name.lst
$seqtk subseq FASTA/RF00230.fa Sample-Result/db_name.lst > Sample-Result/database.fa

# IF NEED CHECK #
# Check sequence numbers: less NAME.fa | grep '>' | wc -l


cd Sample-Result
rm *.lst

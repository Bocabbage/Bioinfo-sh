#!/usr/bin bash
# Script: BuildIndices.sh
# Description: Build index for every FASTA-file in MergeDB
# Update date: 2018/08/22
# Author: Zhuofan Zhang

DBPath=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB/
FAdirs=$( ls $DBPath )
a=1
b=726
for FAdir in $FAdirs
do

  if [ $a -gt $b ];then
    python 2_0_1.BuildIndex.py -d $DBPath/$FAdir -id 'Byte-Offset-Index'
  fi

  a=$(( $a + 1 ))

done

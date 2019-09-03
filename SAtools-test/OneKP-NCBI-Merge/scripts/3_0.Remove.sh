#!/usr/bin bash
# Script: Remove.sh
# Description: Remove unused Onekp samples and remove raw FASTAs
# Update date: 2019/09/03
# Author: Zhuofan Zhang

NDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB
UsedList=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Doc/ONEKP_Final_Use_List.csv

# Remove unused samples
awk -F ',' '{print $1}' $UsedList > temp.list
UnUsedSamples=$( ls $NDB | grep 'onekp' | grep -vf temp.list ) && \
rm -f temp.list 

for sample in $UnUsedSamples
do
    rm -rf $NDB/$sample
    rm -rf $PDB/$sample
done && \

echo "Remove unused samples: FINISH!"

# Remove raw FASTAs
# Pre-remove the raw NCBI FASTAs

Folders=$( ls $NDB )
for folder in $Folders
do
    rm -f $NDB/$folder/*-assembly.fa
    rm -f $PDB/$folder/*-assembly.prot.fa
done && \

echo "FINISH!"



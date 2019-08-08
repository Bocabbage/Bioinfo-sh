#!/usr/bin/bash 
NMERGE=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-NUCL
PMERGE=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-PROT
NTARGET=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PTARGET=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB

NFILE=$( ls $NTARGET )
PFILE=$( ls $PTARGET )

if [ ! -d "$NMERGE" ];then
    mkdir -p $NMERGE
fi

if [ ! -d "$PMERGE" ];then
    mkdir -p $PMERGE
fi


for file in $PFILE
do
    # PTARGET and NTARGET have the same dir-struct.
    #cat $NTARGET/$file/*-rename.fa >> $NMERGE/onekp-ncbi-nucl.fa
    cat $PTARGET/$file/*-rename.prot.fa >> $PMERGE/onekp-ncbi-prot.fa
done

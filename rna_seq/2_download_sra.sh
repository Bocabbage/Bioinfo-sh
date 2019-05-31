#!/usr/bin/env bash
# title:            2_download_sra.sh
# recommand usage:  nohup bash 2_download_sra.sh > download_sra.sh 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
#                   2019/5/31
cd $HOME/zzf

SRA_LIST=(SRR2753135 SRR2753137 SRR2753139 SRR2753140 SRR2753141 SRR2753143)
OUTPATH="./sra/rna_seq"
TOOLPATH="./tools/sratoolkit.2.8.2-1-ubuntu64/bin"

if [ ! -d ./ref ];then
    mkdir ./ref
else
    rm $OUTPATH/*
fi

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

#cd $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/prefetch -v $sra;
done


mv $HOME/ncbi/public/sra/*.sra $OUTPATH

echo "SRA Download Finish!"
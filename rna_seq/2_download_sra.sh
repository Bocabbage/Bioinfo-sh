#!/usr/bin/env bash
# title:            2_download_sra.sh
# recommand usage:  nohup bash 2_download_sra.sh > download_sra.sh 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
cd $HOME/zzf

SRA_LIST=(SRR2920574 SRR2920572 SRR2753137 SRR2753131 SRR2753135 SRR2753130)
OUTPATH="./sra/rna_seq"
TOOLPATH="/home/lihm/software/sratoolkit.2.8.2-1-ubuntu64/bin"

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

fi
mv $HOME/ncbi/public/sra/*.sra $OUTPATH

echo "SRA Download Finish!"
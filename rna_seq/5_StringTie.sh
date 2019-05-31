#!/usr/bin/env bash
# title:            5_StringTie.sh
# recommand usage:  nohup bash 5_StringTie.sh > StringTie.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
cd $HOME/zzf

SRA_LIST=(SRR2753135 SRR2753137 SRR2753139 SRR2753140 SRR2753141 SRR2753143)
INPUTPATH="./bam/rna_seq"
OUTPATH="./stringtie"
TOOLPATH="./tools"

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/stringtie $INPUTPATH/$sra/${sra}Aligned.sortedByCoord.out.bam \
                        -p 20 -G /mnt/work/lihm/GRCH_37/gencode.v30lift37.annotation.gtf \
                        -B -o $OUTPATH/${sra}_transcripts.gtf
done

echo "Finish!"
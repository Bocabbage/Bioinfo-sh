#!/usr/bin/env bash
# title:            6_seq_counts.sh
# recommand usage:  nohup bash 6_seq_counts.sh > seq_counts.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
cd $HOME/zzf

SRA_LIST=(SRR2753135 SRR2753137 SRR2753139 SRR2753140 SRR2753141 SRR2753143)
INPUTPATH="./bam/rna_seq"
OUTPATH="./counts"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"

export PATH=$TOOLPATH:$PATH

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

for sra in "${SRA_LIST[@]}"
do
    samtools view $INPUTPATH/$sra/${sra}Aligned.sortedByCoord.out.bam | \
    htseq-count -f sam  -s no -i gene_name \
                - /mnt/work/lihm/GRCH_37/gencode.v30lift37.annotation.gtf \
                > $OUTPATH/${sra}.geneCounts
done

echo "Finish!"


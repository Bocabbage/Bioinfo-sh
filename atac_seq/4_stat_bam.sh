#!/usr/bin/env bash
# title:            4_stat_bam.sh
# recommand usage:  nohup bash 4_stat_bam.sh > stat_bam.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17
cd $HOME/zzf

SRA_LST=(SRR2920574 SRR2920572)
INPUTPATH="./bam/atac_seq"
OUTPATH="./bam/atac_seq"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"
export PATH=$TOOLPATH:$PATH

for sra in "${SRA_LST[@]}"
do 
    BAM=$INPUTPATH/$sra/${sra}.sorted.dedup.bam
    samtools flagstat $BAM > $OUTPATH/$sra/${sra}.bam.stat
    qualimap bamqc -bam $BAM
    samtools view -h -b -q 30 $BAM > $OUTPATH/$sra/${sra}.sorted.dedup.q30.bam
done


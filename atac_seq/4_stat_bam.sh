#!/usr/bin/env bash
# title:            4_stat_bam.sh
# recommand usage:  nohup bash 4_stat_bam.sh > stat_bam.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17
#                   2019/5/28(Add annotation)
cd $HOME/zzf

SRA_LIST=(SRR2920572 SRR2920574 SRR2920575 SRR2920576 SRR2920577 SRR2920579)
INPUTPATH="./bam/atac_seq"
OUTPATH="./bam/atac_seq"
TOOLPATH="./tools"
export PATH=$TOOLPATH:$PATH

for sra in "${SRA_LIST[@]}"
do 
    BAM=$INPUTPATH/$sra/${sra}.sorted.dedup.bam
    # Use two methods for read-mapping quality analysis
    samtools flagstat $BAM > $OUTPATH/$sra/${sra}.bam.stat
    qualimap bamqc -bam $BAM
    # Filter for giving up low-map-quality reads
    samtools view -h -b -q 30 $BAM > $OUTPATH/$sra/${sra}.sorted.dedup.q30.bam
done


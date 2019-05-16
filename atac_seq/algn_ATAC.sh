#!/usr/env/bin bash

cd $HOME/zzf

SRA_LIST=(SRR2920574 SRR2920572)
INPUTPATH="./fastq/atac_seq"
OUTPATH="./bam/atac_seq"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"

mkdir $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    BAMDIR=$OUTPATH/$sra
    mkdir $BAMDIR

    $TOOLPATH/bowtie2 -X 1000 -x /home/database/hg19/bowtie2_index/hg19.fa \
                      -1 $INPUTPATH/${sra}_1.fastq -2 $INPUTPATH/${sra}_2.fastq -S $BAMDIR/${sra}.sam
    $TOOLPATH/samtools sort -n -O sam $BAMDIR/${sra}.sam | $TOOLPATH/samtools fixmate -m -O bam - $BAMDIR/${sra}.fixmate.bam
    $TOOLPATH/samtools sort -O bam -o $BAMDIR/${sra}.sorted.bam $BAMDIR/${sra}.fixmate.bam
    $TOOLPATH/samtools markdup -r -s $BAMDIR/${sra}.sorted.bam $BAMDIR/${sra}.sorted.dedup.bam
done

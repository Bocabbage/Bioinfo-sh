#!/usr/env/bin bash
# title:            3_algn_ATAC.sh
# recommand usage:  nohup bash 3_algn_ATAC.sh > algn_ATAC.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17
cd $HOME/zzf

SRA_LIST=(SRR2920574 SRR2920572)
INPUTPATH="./fastq/atac_seq"
OUTPATH="./bam/atac_seq"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"
export PATH=$TOOLPATH:$PATH
mkdir $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    BAMDIR=$OUTPATH/$sra
    mkdir $BAMDIR

    bowtie2 -X 1000 -p 20 -x /home/database/hg19/bowtie2_index/hg19.fa \
                      -1 $INPUTPATH/${sra}_1.fastp.fastq -2 $INPUTPATH/${sra}_2.fastp.fastq -S $BAMDIR/${sra}.sam
    samtools sort -n -O sam $BAMDIR/${sra}.sam | samtools fixmate -m -O bam - $BAMDIR/${sra}.fixmate.bam
    samtools sort -O bam -o $BAMDIR/${sra}.sorted.bam $BAMDIR/${sra}.fixmate.bam
    samtools markdup -r -s $BAMDIR/${sra}.sorted.bam $BAMDIR/${sra}.sorted.dedup.bam 
done

echo "Alignment Finish!"


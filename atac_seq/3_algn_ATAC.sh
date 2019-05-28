#!/usr/env/bin bash
# title:            3_algn_ATAC.sh
# recommand usage:  nohup bash 3_algn_ATAC.sh > algn_ATAC.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17
#                   2019/5/28(Add Build-index step; Add annotation)
cd $HOME/zzf

SRA_LIST=(SRR2920572 SRR2920574 SRR2920575 SRR2920576 SRR2920577 SRR2920579)
REFPATH="./ref"
INPUTPATH="./fastq/atac_seq"
OUTPATH="./bam/atac_seq"
TOOLPATH="./tools"
export PATH=$TOOLPATH:$PATH

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

# Build bowtie-index
bowtie2-build $REFPATH/hg19.fa


# Reads-Alignment
for sra in "${SRA_LIST[@]}"
do
    BAMDIR=$OUTPATH/$sra
    mkdir $BAMDIR
    bowtie2 -X 1000 -p 20 -x $REFPATH/hg19.fa \
                    -1 $INPUTPATH/${sra}_noadapters_1.fastp -2 $INPUTPATH/${sra}_noadapters_2.fastp \
                    -S $BAMDIR/${sra}.sam
    # bowtie2 para:
    # -X: set max-value for ISIZE
    # -p: threads number
    # -x: ref-genome file(index-built)
    # -1/-2: PE fastp files
    # -S: output file : .sam

    # Sort the reads by name and do fixmate(for markdup analysis)
    samtools sort -n -O sam $BAMDIR/${sra}.sam | samtools fixmate -m -O bam - $BAMDIR/${sra}.fixmate.bam
    # Sort the reads by coordinates(for faster search)
    samtools sort -O bam -o $BAMDIR/${sra}.sorted.bam $BAMDIR/${sra}.fixmate.bam
    # Markdup to reduce the influence of PCR-signal enhance
    samtools markdup -r -s $BAMDIR/${sra}.sorted.bam $BAMDIR/${sra}.sorted.dedup.bam 
done

echo "Alignment Finish!"


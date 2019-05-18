#!/usr/bin/env bash
# title:            4_algn_RNA.sh
# recommand usage:  nohup bash 4_algn_RNA.sh > algn_RNA.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
cd $HOME/zzf

SRA_LIST=(SRR2753137 SRR2753131 SRR2753135 SRR2753130)
INPUTPATH="./fastq"
OUTPATH="./bam/rna_seq"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"
export PATH=$TOOLPATH:$PATH
if [ ! -d "./bam" ];then
    mkdir ./bam
else
    rm ./bam/*
fi


if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

# Build Index #
# STAR --runThreadN 6 --runMode genomeGenerate \
#      --genomeDir /mnt/work/lihm/GRCH_37/ \
#      --genomeFastaFiles /mnt/work/lihm/GRCH_37/GRCh37.primary_assembly.genome.fa \
#      --sjdbGTFfile /mnt/work/lihm/GRCH_37/gencode.v30lift37.annotation.gtf \
#      --sjdbOverhang 100


for sra in "${SRA_LIST[@]}"
do
    BAMDIR=$OUTPATH/$sra
   
    if [ ! -d "$BAMDIR" ];then
        mkdir $BAMDIR
    else
        rm $BAMDIR/*
    fi

    STAR --runThreadN 20 --genomeDir /mnt/work/lihm/GRCH_37 \
         --readFilesIn ${INPUTPATH}/${sra}_1.fastq ${INPUTPATH}/${sra}_2.fastq \
         --outSAMtype BAM SortedByCoordinate \
         --outFileNamePrefix ${BAMDIR}/$sra
done

echo "Finish!"
#!/usr/bin/env bash

cd $HOME/zzf

SRA_LIST=(SRR2753137 SRR2753131 SRR2753135 SRR2753130)
INPUTPATH="./fastq"
OUTPATH="./bam"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"

mkdir $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    BAMDIR=$OUTPATH/$sra
    mkdir $BAMDIR

    $TOOLPATH/STAR --runThreadN 20 --genomeDir /mnt/work/lihm/GRCH_37 \
                   --readFilesIn ${INPUTPATH}/${sra}_1.fastq ${INPUTPATH}/${sra}_2.fastq \
                   --outSAMtype BAM SortedByCoordinate \
                   --outFileNamePrefix ${BAMDIR}/$sra
done

echo "Finish!"
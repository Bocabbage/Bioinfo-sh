#! /usr/bin/env bash
cd $HOME/zzf

SRA_LIST=(SRR2753137 SRR2753131 SRR2753135 SRR2753130)
INPUTPATH="./bam"
OUTPATH="./counts"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"

mkdir $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/samtools view $INPUTPATH/$sra/${sra}Aligned.sortedByCoord.out.bam | \
    $TOOLPATH/htseq-count -f sam  -s no -i gene_name \
                          - /mnt/work/lihm/GRCH_37/gencode.v30lift37.annotation.gtf \
                          > $OUTPATH/${sra}.geneCounts
done

echo "Finish!"


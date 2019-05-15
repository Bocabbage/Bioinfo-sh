#! /usr/bin/env bash
cd $HOME/zzf

SRA_LIST=(SRR2753137 SRR2753131 SRR2753135 SRR2753130)
INPUTPATH="./bam"
OUTPATH="./stringtie"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"

mkdir $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/stringtie $INPUTPATH/$sra/${sra}Aligned.sortedByCoord.out.bam \
                        -p 20 -G /mnt/work/lihm/GRCH_37/gencode.v30lift37.annotation.gtf \
                        -B -o $OUTPATH/${sra}_transcripts.gtf
done

echo "Finish!"
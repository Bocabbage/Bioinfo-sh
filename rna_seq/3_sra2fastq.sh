#!usr/bin/env bash
# title:            3_sra2fastq.sh
# recommand usage:  nohup bash 3_sra2fastq.sh > sra2fastq.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
TOOLPATH='/home/lihm/software/sratoolkit.2.8.2-1-ubuntu64/bin/'
INPUTPATH='./sra/rna_seq'
OUTPATH='./fastq/rna_seq'
SRA_LIST=(SRR2753137 SRR2753131 SRR2753135 SRR2753130)

cd $HOME/zzf
mkdir ./fastq
mkdir $OUTPATH

ls $INPUTPATH/*.sra | while read i; do $TOOLPATH/fastq-dump --split-3 -O $OUTPATH $i; done

# Most reads are at the quality level above 25, so we skip the QC step. #
# for sra in "${SRA_LIST[@]}"
# do
#     ./tools/fastp -i $OUTPATH/${sra}_1.fastq -I $OUTPATH/${sra}_2.fastq \
#           -o $OUTPATH/${sra}_1.fastp.fastq -O $OUTPATH/${sra}_2.fastp.fastq \
#           -h $OUTPATH/${sra}.html &
# done


echo "TRANSFORM Finish!"
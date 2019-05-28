#!/usr/env/bin bash
# title:            2_sra2fastq.sh
# recommand usage:  nohup bash 2_sra2fastq.sh > sra2fastq.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17  
#                   2019/5/28(Add adpters-trimming) 
cd $HOME/zzf

SRA_LIST=(SRR2920572 SRR2920574 SRR2920575 SRR2920576 SRR2920577 SRR2920579)
INPUTPATH="./sra/atac_seq"
OUTPATH="./fastq/atac_seq"
TOOLPATH="./tools"

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

export PATH=$TOOLPATH:$PATH

ls $INPUTPATH/*.sra | while read i; do $TOOLPATH/fastq-dump --split-3 -O $OUTPATH $i; done
# --split-3 parameter for pair-end seq data: to split .sra into _1.fq+_2.fq
echo "sra2fastq finish!"

# fastp for QC + trim
# for sra in "${SRA_LIST[@]}"
# do
#     $TOOLPATH/fastp -i $OUTPATH/${sra}_1.fastq -I $OUTPATH/${sra}_2.fastq \
#                     -o $OUTPATH/${sra}_1.fastp.fastq -O $OUTPATH/${sra}_2.fastp.fastq \
#                     -h $OUTPATH/${sra}.html &
# done

# FastQC for QC
REPORT="./fastqc-report"
if [ ! -d "$REPORT" ];then
    mkdir $REPORT
else
    rm $REPORT/*
fi

for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/FastQC/fastqc -o $REPORT -t 10 $OUTPATH/${sra}_1.fastq
    $TOOLPATH/FastQC/fastqc -o $REPORT -t 10 $OUTPATH/${sra}_2.fastq
done
echo "FastQC finish!"

# NGmerge for Reads trimming
for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/NGmerge -a -1 $OUTPATH/${sra}_1.fastq -2 $OUTPATH/${sra}_2.fastq -o $OUTPATH/${sra}_noadapters
done
echo "NGmerge for adapters-trimming done!"




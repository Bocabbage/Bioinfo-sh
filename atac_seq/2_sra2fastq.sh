#!/usr/env/bin bash
# title:            2_sra2fastq.sh
# recommand usage:  nohup bash 2_sra2fastq.sh > sra2fastq.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17   
cd $HOME/zzf

SRA_LIST=(SRR2920574 SRR2920572)
INPUTPATH="./sra/atac_seq"
OUTPATH="./fastq/atac_seq"
TOOLPATH="./tools"
mkdir $OUTPATH

export PATH=$TOOLPATH:$PATH

ls $INPUTPATH/*.sra | while read i; do $TOOLPATH/fastq-dump --split-3 -O $OUTPATH $i; done

for sra in "${SRA_LIST[@]}"
do
    ./tools/fastp -i $INPUTPATH/${sra}_1.fastq -I $INPUTPATH/${sra}_2.fastq \
                  -o $OUTPATH/${sra}_1.fastp.fastq -O $OUTPATH/${sra}_2.fastp.fastq \
                  -h $OUTPATH/${sra}.html &
done

echo "Finish!"

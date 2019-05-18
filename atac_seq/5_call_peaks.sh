#!/usr/env/bin bash
# title:            5_call_peaks.sh
# recommand usage:  nohup bash 5_call_peaks.sh > call_peaks.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/18
cd $HOME/zzf

SRA_LIST=(SRR2920574 SRR2920572)
INPUTPATH="./bam/atac_seq"
OUTPATH="./callpeaks"
TOOLPATH="/home/lihm/anaconda2/bcbio/usr/local/bin"


if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

export PATH=$TOOLPATH:$PATH


macs2 callpeak -t $INPUTPATH/${SRA_LIST[0]}/${SRA_LIST[0]}.sorted.dedup.q30.bam \
               -c $INPUTPATH/${SRA_LIST[1]}/${SRA_LIST[1]}.sorted.dedup.q30.bam \
               -g hs -B -f BAMPE -n example -q 0.00001 --outdir=$OUTPATH

echo "PeakCalling finish!"
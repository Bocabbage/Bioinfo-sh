#!/usr/env/bin bash
# title:            5_call_peaks.sh
# recommand usage:  nohup bash 5_call_peaks.sh > call_peaks.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/18
#                   2019/5/29(Divide samples into pHSC/Blast)
cd $HOME/zzf

SU_ID=(SU444 SU484 SU496)
pHSC=(SRR2920574 SRR2920575 SRR2920577)
Blast=(SRR2920572 SRR2920576 SRR2920579)

INPUTPATH="./bam/atac_seq"
OUTPATH="./callpeaks"


if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

for i in $(seq 0 2)
do
    mkdir $OUTPATH/"{SU_ID[$i]}"
    macs2 callpeak -t $INPUTPATH/"${pHSC[$i]}"/"${pHSC[$i]}".sorted.dedup.q30.bam \
                   -c $INPUTPATH/"${Blast[$i]}"/"${Blast[$i]}".sorted.dedup.q30.bam \
                   -g hs -B -f BAMPE -n example -q 0.01 --outdir=$OUTPATH/"{SU_ID[$i]}"



echo "PeakCalling finish!"
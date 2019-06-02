#!/usr/env/bin bash
# title:            5_call_peaks.sh
# recommand usage:  nohup bash 5_call_peaks.sh > call_peaks.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/18
#                   2019/5/29(Divide samples into pHSC/Blast)
#                   2019/6/2(Change the treatment-control Pair and do PeakCalling and Merge the two pair results.
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

if [ ! -d "$OUTPATH/sample_pHSC/" ];then
    mkdir $OUTPATH/sample_pHSC
fi

if [ ! -d "$OUTPATH/sample_Blast/" ];then
    mkdir $OUTPATH/sample_Blast
fi

if [ ! -d "$OUTPATH/Merge" ];then
    mkdir $OUTPATH/Merge
fi

for i in $(seq 0 2)
do
    pHSCsample=$OUTPATH/sample_pHSC/"{SU_ID[$i]}"
    # mkdir $pHSCsample
    macs2 callpeak -t $INPUTPATH/"${pHSC[$i]}"/"${pHSC[$i]}".sorted.dedup.q30.bam \
                   -c $INPUTPATH/"${Blast[$i]}"/"${Blast[$i]}".sorted.dedup.q30.bam \
                   -g hs -B -f BAMPE -n "{SU_ID[$i]}"_pHSC -q 0.01 --outdir=$pHSCsample

    Blastsample=$OUTPATH/sample_Blast/"{SU_ID[$i]}"
    # mkdir $Blastsample
    macs2 callpeak -t $INPUTPATH/"${Blast[$i]}"/"${Blast[$i]}".sorted.dedup.q30.bam \
                   -c $INPUTPATH/"${pHSC[$i]}"/"${pHSC[$i]}".sorted.dedup.q30.bam \
                   -g hs -B -f BAMPE -n "{SU_ID[$i]}"_Blast -q 0.01 --outdir=$Blastsample


    cat $pHSCsample/"{SU_ID[$i]}"_pHSC_peaks.narrowPeak $Blastsample/"{SU_ID[$i]}"_Blast_peaks.narrowPeak \
        > $OUTPATH/Merge/"{SU_ID[$i]}"_merge.narrowPeak

    sort -k1,1 -k2,2n $OUTPATH/Merge/"{SU_ID[$i]}"_merge.narrowPeak \
         > $OUTPATH/Merge/"{SU_ID[$i]}"_merge_sorted.narrowPeak
    rm $OUTPATH/Merge/"{SU_ID[$i]}"_merge.narrowPeak

    bedtools merge -i $OUTPATH/Merge/"{SU_ID[$i]}"_merge_sorted.narrowPeak > $OUTPATH/Merge/"{SU_ID[$i]}"_merge.bed
    rm $OUTPATH/Merge/"{SU_ID[$i]}"_merge_sorted.narrowPeak
done



echo "PeakCalling finish!"
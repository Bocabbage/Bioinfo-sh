#!/usr/env/bin bash
# title:            6_homer_anno_motif.sh
# recommand usage:  nohup bash 6_homer_anno_motif.sh > homer_anno_motif.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/18
cd $HOME/zzf

INPUTPATH="./callpeaks"
OUTPATH="./anno_motif"

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

export PATH=/home/lihm/software/HOMER/bin/:$PATH

annotatePeaks.pl $INPUTPATH/example_peaks.narrowPeak > \
                 $OUTPATH/example_peaks.annotated

findMotifsGenome.pl $INPUTPATH/example_peaks.narrowPeak hg19 $OUTPATH/

echo "Annotated!"
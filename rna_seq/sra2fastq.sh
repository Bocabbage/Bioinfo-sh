#!usr/bin/env bash

TOOLPATH='/home/lihm/software/sratoolkit.2.8.2-1-ubuntu64/bin/'
INPUTPATH='./sra/rna_seq'
OUTPATH='./fastq'

cd $HOME/zzf
mkdir $OUTPATH

ls $INPUTPATH/*.sra | while read i; do $TOOLPATH/fastq-dump --split-3 -O $OUTPATH $i; done

echo "Finish!"
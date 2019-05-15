#!/usr/bin/env bash

SRA_LST=(SRR2920574 SRR2920572 SRR2753137 SRR2753131 SRR2753135 SRR2753130)
OUTPATH="/home/student2/zzf/sra"
TOOLPATH="/home/lihm/software/sratoolkit.2.8.2-1-ubuntu64/bin"

mkdir $OUTPATH
cd $OUTPATH

for sra in "${SRA_LST[@]}"
do
    $TOOLPATH/prefetch -v $sra;
done

fi
mv $HOME/ncbi/public/sra/*.sra $OUTPATH
echo "Finish!"
#!/usr/bin/env bash
# title:            1_download_sra.sh
# recommand usage:  nohup bash 1_download_sra.sh > download_sra.sh 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/17
#                   2019/5/28(Add methods for Ref-genome downloading)
cd $HOME/zzf

#### ATAC-seq Data Download ####
SRA_LIST=(SRR2920572 SRR2920574 SRR2920575 SRR2920576 SRR2920577 SRR2920579)
OUTPATH="./sra/atac_seq"
TOOLPATH="./tools/sratoolkit.2.8.2-1-ubuntu64/bin"

if [ ! -d "$OUTPATH" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi


#cd $OUTPATH

for sra in "${SRA_LIST[@]}"
do
    $TOOLPATH/prefetch -v $sra ;
done

fi
mv $HOME/ncbi/public/sra/*.sra $OUTPATH

echo "SRA Download Finish!"

#### Reference Genome Data Download ####
REF="./ref"
if [ ! -d "$REF" ];then
    mkdir $OUTPATH
else
    rm $OUTPATH/*
fi

wget -P $REF http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/chromFa.tar.gz
tar -zxvf $REF/chromFa.tar.gz 
cat $REF/*.fa > $REF/hg19.fa
rm $REF/chr*.fa

echo "Reference Genome Download Finish!"

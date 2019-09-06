#!/usr/bin bash
# Script: Intergrate.sh
# Description: Copy the OneKP/NCBI database, rename the dirname in a new rule and deduplicate.
# Update date: 2019/08/07
# Author: Zhuofan Zhang

NTARGET=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PTARGET=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB
NDB=/zfssz3/NGB_DB/shenweiyan/backupDB/OneKP/RawNuclSeq
PDB=/zfssz3/NGB_DB/shenweiyan/backupDB/OneKP/ProtSeq
NFILES=$( ls $NDB)
PFILES=$( ls $PDB)

#### Step 1: Copy from backDB and DEDUP if needed ####
# OneKP
if [ ! -d "$NTARGET" ];then
    mkdir -p $NTARGET
fi

if [ ! -d "$PTARGET" ];then
    mkdir -p $PTARGET
fi

for file in $NFILES
do
  mkdir $NTARGET/onekp-${file:0:4}
  cp $TDB/$file/assembly/${file:0:4}-SOAPdenovo-Trans-assembly.fa $NTARGET/onekp-${file:0:4}
done


for file in $PFILES
do
  # As the result of 0.Check-dup.sh shows, only the ONEKP-PROT-DATABASE have duplicated sequences.
  mkdir $PTARGET/onekp-${file} && \
  awk '/^>/{f=!d[$1];d[$1]=1}f' $PDB/$file/${file}-SOAPdenovo-Trans-assembly.prot.fa > $PTARGET/onekp-${file}
done

# NCBI
mkdir $NTARGET/ncbi-ALL
mkdir $PTARGET/ncbi-ALL
mv /hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/1KP_Plastid/data/NCBI/ncbi.nc.cds.fasta $NTARGET/ncbi-ALL
mv /hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/1KP_Plastid/data/NCBI/ncbi.nc.prot.fasta $PTARGET/ncbi-ALL

# As the result of 0.Check-dup.sh shows, only the ONEKP-PROT-DATABASE have duplicated sequences.
for file in $PFILES
do
    awk '/^>/{f=!d[$1];d[$1]=1}f' $PTARGET/onekp-${file}/${file}-SOAPdenovo-Trans-assembly.prot.fa > $PTARGET/onekp-${file}-SOAPdenovo-Trans-assembly.prot.dedup
    mv -f $PTARGET/onekp-${file}-SOAPdenovo-Trans-assembly.prot.dedup $PTARGET/onekp-${file}/${file}-SOAPdenovo-Trans-assembly.prot.fa
done



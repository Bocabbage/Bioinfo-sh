#!/bin/bash
# Script: Download_Software.sh
# Description: For Sequence-Alignment tools(Blast,Blat,Usearch) downloading
# Update date : 2019/07/09
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools

## BLAST Download and Install ##
wget -P $WORKPATH/1.BLAST/ ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.9.0+-x64-linux.tar.gz
tar -zxvf $WORKPATH/1.BLAST/ncbi-blast-2.9.0+-x64-linux.tar.gz

## Blat Download and Install ##
wget -P $WORKPATH/2.BLAT/ https://users.soe.ucsc.edu/~kent/src/blatSrc.zip
cd $WORKPATH/2.BLAT
unzip ./blatSrc.zip
cd blatSrc
uname -m # Ensure the machine type, can be ignored
MACHTYPE=x86_64
export MACHTYPE
mkdir -p ~/bin/x86_64 # make sure that the $HOME has enough memory
make

mv ~/bin/ $WORKPATH/2.BLAT/


## USEARCH Download and Install ##
# The 32-bit version is free, and the download URL can be gotten by e-mail the author sends to you
wget -P $WORKPATH/3.USEARCH/ http://drive5.com/cgi-bin/upload3.py?license=2019070823315106967
mv upload3.py\?license\=20190700823315106967 usearch11.0.667_i86linux32
chmod +x usearch11.0.667_i86linux32

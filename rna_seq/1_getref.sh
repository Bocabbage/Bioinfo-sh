#!usr/bin/env bash
# title:            1_getref.sh
# recommand usage:  nohup 1_getref.sh > getref.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
cd $HOME/zzf
mkdir ./reference
cd ./reference

# Get FASTA
wget -P ./grch37 ftp://ftp.ensembl.org/pub/grch37/current/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.dna.toplevel.fa.gz

# Get GTF
wget -P ./grch37 ftp://ftp.ensembl.org/pub/grch37/current/gtf/homo_sapiens/Homo_sapiens.GRCh37.87.gtf.gz

echo "RefGenome Downloaded!"

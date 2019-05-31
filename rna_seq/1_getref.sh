#!/usr/bin/env bash
# title:            1_getref.sh
# recommand usage:  nohup 1_getref.sh > getref.log 2>&1 &
# author:           Zhuofan Zhang
# date:             2019/5/15
#                   2019/5/31
cd $HOME/zzf
mkdir ./rna-ref
cd ./rna-ref

# Get FASTA
wget ftp://ftp.ensembl.org/pub/grch37/current/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz

# Get GTF
wget ftp://ftp.ensembl.org/pub/grch37/current/gtf/homo_sapiens/Homo_sapiens.GRCh37.87.gtf.gz

# Decompression
gzip -d Homo_sapiens.GRCh37.dna.primary_assembly.fa.gz
gzip -d Homo_sapiens.GRCh37.87.gtf.gz


echo "RefGenome Downloaded!"

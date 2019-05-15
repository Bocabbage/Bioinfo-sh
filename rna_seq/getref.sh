#!usr/bin/env bash

cd $HOME/zzf/reference

# Get FASTA
wget -P ./grch37 ftp://ftp.ensembl.org/pub/grch37/current/fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.dna.toplevel.fa.gz

# Get GTF
wget -P ./grch37 ftp://ftp.ensembl.org/pub/grch37/current/gtf/homo_sapiens/Homo_sapiens.GRCh37.87.gtf.gz

echo "Finish!"

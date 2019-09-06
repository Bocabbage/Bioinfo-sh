#!/usr/bin/bash
NDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-NUCL
PDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-PROT

BLAST=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/1.BLAST/ncbi-blast-2.9.0+/bin


$BLAST/makeblastdb -in $NDB/onekp-ncbi-nucl.fa -dbtype nucl -taxid_map $NDB/taxidmap.txt -blastdb_version 5 -hash_index -parse_seqids -max_file_sz 4GB
#$BLAST/makeblastdb -in $PDB/onekp-ncbi-prot.fa -dbtype prot -taxid_map $PDB/taxidmap.txt -blastdb_version 5 -hash_index -parse_seqids -max_file_sz 4GB

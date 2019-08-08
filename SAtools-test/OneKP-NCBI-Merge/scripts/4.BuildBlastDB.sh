#!/usr/bin/bash
NFA=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-NUCL/onekp-ncbi-nucl.fa
PFA=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-PROT/onekp-ncbi-prot.fa

BLAST=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/1.BLAST/ncbi-blast-2.9.0+/bin


$BLAST/makeblastdb -in $NFA -dbtype nucl
$BLAST/makeblastdb -in $PFA -dbtype prot

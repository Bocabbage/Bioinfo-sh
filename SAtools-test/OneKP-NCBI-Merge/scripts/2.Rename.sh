#!/usr/bin bash
# Script: Rename.sh
# Description: Final Version for renaming the headers in ONEKP FASTAs
# Update date: 2019/09/03
# Author: Zhuofan Zhang

CDSDBPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PROTDBPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB

# ONEKP
PERL_SCRIPT=./2_1.Rename-ONEKP.pl
CSV_FILE=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Doc/ONEKP_Final_Use_List.csv
LIST=$(sed 's/ /_/g' $CSV_FILE | awk '{print $0}')
for entry in $LIST
do
    eval $(echo $entry | awk -F ',' '{printf("onekpID=%s;SPECIES=%s;taxID=%s",$1,$2,$3);}')
    IN_FASTA=$CDSDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly.fa
    OUT_FASTA=$CDSDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly-rename.fa
    if [ -e $OUT_FASTA ];then
        rm -f $OUT_FASTA
    fi
    perl -w $PERL_SCRIPT $IN_FASTA $OUT_FASTA $taxID "cds"

    IN_FASTA=$PROTDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly.prot.fa
    OUT_FASTA=$PROTDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly-rename.prot.fa
    if [ -e $OUT_FASTA ];then
        rm -f $OUT_FASTA
    fi
    perl -w $PERL_SCRIPT $IN_FASTA $OUT_FASTA $taxID "prot"

done

# NUCL (Noted that this process is for the processed result of last Version)
PY_SCRIPT=./2_2.Rename-NCBI.py
CSV_FILE=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Doc/NCBI_Final_Use_List.csv

IN_FASTA=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ncbi-ALL/ncbi.cds.fasta
OUT_FASTA=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ncbi-ALL/ncbi.cds-rename.fa
python $PY_SCRIPT -dict $CSV_FILE -i $IN_FASTA -o $OUT_FASTA
rm -f $IN_FASTA

IN_FASTA=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ncbi-ALL/ncbi.prot.fasta
OUT_FASTA=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ncbi-ALL/ncbi.prot-rename.prot.fa
python $PY_SCRIPT -dict $CSV_FILE -i $IN_FASTA -o $OUT_FASTA
rm -f $IN_FASTA


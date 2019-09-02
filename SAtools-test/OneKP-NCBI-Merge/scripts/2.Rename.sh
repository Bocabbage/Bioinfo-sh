#!/usr/bin bash
# Script: Rename.sh
# Description: Final Version for renaming the headers in ONEKP FASTAs
# Update date: 2019/09/02(Only OneKP finished)
# Author: Zhuofan Zhang

CSV_FILE=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Doc/Final_Use_List.csv
CDSDBPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PROTDBPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB
PERL_SCRIPT=./2_1.Rename-ONEKP.pl
LIST=$(sed 's/ /_/g' $CSV_FILE | awk '{print $0}')
for entry in $LIST
do
    eval $(echo $entry | awk -F ',' '{printf("onekpID=%s;SPECIES=%s;taxID=%s",$1,$2,$3);}')
    IN_FASTA=$CDSDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly.fa
    OUT_FASTA=$CDSDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly-rename.fa
    if [ -e $OUT_FASTA ];then
        rm -f $OUT_FASTA
    fi
    perl -w $PERL_SCRIPT $IN_FASTA $OUT_FASTA $SPECIES $taxID "cds"

    IN_FASTA=$PROTDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly.prot.fa
    OUT_FASTA=$PROTDBPATH/onekp-${onekpID}/${onekpID}-SOAPdenovo-Trans-assembly-rename.prot.fa
    if [ -e $OUT_FASTA ];then
        rm -f $OUT_FASTA
    fi
    perl -w $PERL_SCRIPT $IN_FASTA $OUT_FASTA $SPECIES $taxID "prot"

done

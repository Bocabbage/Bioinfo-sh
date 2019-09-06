#!/usr/bin bash
NDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB
Target=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/Merge-PROT
#Nfiles=$( ls $NDB )
Pfiles=$( ls $PDB )

for file in $Pfiles
do
    cat $PDB/$file/taxidmap.txt >> $Target/taxidmap.txt
done && \
echo "PROT-MAP merge FINISH!"

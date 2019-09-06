#!/usr/bin bash
NDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PDB=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB

psc=./4_0.BuildTaxidMap.pl
OKP_folders=$( ls $PDB | grep 'onekp' )
NCBI_folder=$( ls $PDB | grep 'ncbi' )

for okp in $OKP_folders
do
    #perl -w $psc onekp $NDB/$okp/$( ls $NDB/$okp/ | grep 'fa' ) | sed 's/\r//g' > $NDB/$okp/taxidmap.txt
    perl -w $psc onekp $PDB/$okp/$( ls $PDB/$okp/ | grep 'fa' ) | sed 's/\r//g' > $PDB/$okp/taxidmap.txt
done

#perl -w $psc ncbi $NDB/$NCBI_folder/$( ls $NDB/$NCBI_folder/ | grep 'fa' ) > $NDB/$NCBI_folder/taxidmap.txt
perl -w $psc ncbi $PDB/$NCBI_folder/$( ls $PDB/$NCBI_folder/ | grep 'fa' ) > $PDB/$NCBI_folder/taxidmap.txt

echo "FINISH!"

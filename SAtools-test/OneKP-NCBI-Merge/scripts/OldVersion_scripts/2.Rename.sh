# Script: Rename.sh
# Description: Rename the database sequences
# Update date: 2019/08/07
# Author: Zhuofan Zhang
SCRIPTS=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/scripts
NTARGET=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/NuclDB
PTARGET=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools/OneKP/MergeDB/ProtDB
NFILES=$( ls $NTARGET)
PFILES=$( ls $PTARGET)

#### Step 2: Rename ####
for file in $NFILES
do
    if [ -e "$NTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly-rename.fa" ];then
        rm -f $NTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly-rename.fa
    fi
    perl -w $SCRIPTS/2_1.Rename-ONEKP.pl $NTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly.fa $NTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly-rename.fa
done

for file in $PFILES
do
    if [ -e "$PTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly-rename.prot.fa" ];then
        rm -f $PTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly-rename.prot.fa
    fi
    perl -w $SCRIPTS/2_1.Rename-ONEKP.pl $PTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly.prot.fa $PTARGET/${file}/${file:6:10}-SOAPdenovo-Trans-assembly-rename.prot.fa
done


#!/usr/bin/bash
# Script: Performance.sh
# Description:
# Update data: 2019/07/12
# Author: Zhuofan Zhang

WORKPATH=/hwfssz1/BIGDATA_COMPUTING/liwenhui/1.Etools/1.SAtools
python=$WORKPATH/tools/python3.4/bin/python3

#### PREPROCESS FOR USEARCH RESULT ####
ALIGNRESULTS=$WORKPATH/TEST-DEMO/Align-Results
awk '{print $1}' $ALIGNRESULTS/usearch_local.b6 > $ALIGNRESULTS/ID1.temp
awk '{FS="\t"}{print $2}' $ALIGNRESULTS/usearch_local.b6 | awk '{print $1}' >  $ALIGNRESULTS/ID2.temp
awk  '{FS="\t";OFS="\t"}FNR==NR{a[NR]=$1;next}{$1=a[FNR]}1' $ALIGNRESULTS/ID1.temp $ALIGNRESULTS/usearch_local.b6 > $ALIGNRESULTS/ID1_replace.temp
awk  '{FS="\t";OFS="\t"}FNR==NR{a[NR]=$1;next}{$2=a[FNR]}1' $ALIGNRESULTS/ID2.temp $ALIGNRESULTS/ID1_replace.temp > $ALIGNRESULTS/usearch_local_tabular.b6
mv $ALIGNRESULTS/usearch_local.b6 ./
rm $ALIGNRESULTS/*.temp

#awk '{print $1}' $ALIGNRESULTS/usearch_global.b6 > $ALIGNRESULTS/ID1.temp
#awk '{FS="\t"}{print $2}' $ALIGNRESULTS/usearch_global.b6 | awk '{print $1}' >  $ALIGNRESULTS/ID2.temp
#awk  '{FS="\t";OFS="\t"}FNR==NR{a[NR]=$1;next}{$1=a[FNR]}1' $ALIGNRESULTS/ID1.temp $ALIGNRESULTS/usearch_global.b6 > $ALIGNRESULTS/ID1_replace.temp
#awk  '{FS="\t";OFS="\t"}FNR==NR{a[NR]=$1;next}{$2=a[FNR]}1' $ALIGNRESULTS/ID2.temp $ALIGNRESULTS/ID1_replace.temp > $ALIGNRESULTS/usearch_global_tabular.b6
#mv $ALIGNRESULTS/usearch_global.b6 ./
#rm $ALIGNRESULTS/*.temp


#### PERFORMANCE ASSESSMENT ####
$python $WORKPATH/TEST-DEMO/scripts/Performance.py --fapath $WORKPATH/TEST-DEMO/FASTA/Databases \
        --repath $WORKPATH/TEST-DEMO/Align-Results

rm -f $ALIGNRESULTS/pro_*

rm -f $ALIGNRESULTS/usearch_local_tabular.b6
#rm -f $ALIGNRESULTS/usearch_global_tabular.b6
mv ./usearch_local.b6 $ALIGNRESULTS
#mv ./usearch_global.b6 $ALIGNRESULTS

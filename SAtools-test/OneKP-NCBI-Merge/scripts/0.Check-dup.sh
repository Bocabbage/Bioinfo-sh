#!/usr/bin bash
# Script: Check-dedup.sh
# Description: Check sequence-duplication.
# Update date: 2019/08/07
# Author: Zhuofan Zhang
PROTDB=/zfssz3/NGB_DB/shenweiyan/backupDB/OneKP/ProtSeq
NUCLDB=/zfssz3/NGB_DB/shenweiyan/backupDB/OneKP/RawNuclSeq
NDUPLIST=./Log/nucl.dup.lst
PDUPLIST=./Logprot.dup.lst

PFILES=$( ls $PROTDB )
#echo "######## PROT ########" > $DUPLIST
for file in $PFILES
do
  dupnums=$( less $PROTDB/$file/$file-SOAPdenovo-Trans-assembly.prot.fa | grep '>' | sort | uniq -d | wc -l ) && \
  if [ $dupnums -gt 0 ];then
    echo "$file $dupnums" >> $PDUPLIST
  fi
done
#echo "######################" >> $DUPLIST

#echo "######## NUCL ########" >> $DUPLIST
### noted that NO DUPLICATION in Onekp-nucl database.
### So I have removed the empty Logfile.
NFILES=$( ls $NUCLDB )
for file in $NFILES
do
  dupnums=$( less $NUCLDB/$file/assembly/${file:0:4}-SOAPdenovo-Trans-assembly.fa | grep '>' | sort | uniq -d | wc -l ) && \
  if [ $dupnums -gt 0 ];then
    echo "${file:0:4} $dupnums" >> $NDUPLIST
  fi
done
#echo "######################"

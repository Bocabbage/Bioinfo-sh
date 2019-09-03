#!/usr/bin bash
NUCLDB=/zfssz3/NGB_DB/shenweiyan/backupDB/OneKP/RawNuclSeq

ls $NUCLDB | awk -F '-' '{print $2}' | sed 's/_sp$//g' | sed 's/_sp.$//g' | sed 's/_/ /g' > NUCL_Tax.name




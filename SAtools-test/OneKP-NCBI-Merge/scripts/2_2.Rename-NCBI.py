# -*- coding: utf-8 -*-
# Script: Rename-NCBI.py
# Description: This is the second version script for processing the NCBI_FASTA.
#              Noted that the input-FASTA has the header format:
#              ">lcl|[NC_ID]_xxx_[NP_ID]-[Species_Name]"
#              and this script will add [taxid] to it and move out those sequences
#              that can't map to proper ID.
# Update date: 2019/09/06
# Author: Zhuofan Zhang

import argparse
import re

parser = argparse.ArgumentParser()
parser.add_argument('-dict',help="species2taxid CSV file.")
parser.add_argument('-i',help="input fasta file.")
parser.add_argument('-o',help="output fasta file.")
args = parser.parse_args()

# As the Dict is not big, read it into memory once.
Species2Taxid = {}
with open(args.dict,'r') as ifile:
    for line in ifile.readlines():
        species,taxid = line.split(',')
        species = species.replace(' ','_')
        Species2Taxid[species]=taxid

with open(args.i,'r') as ifile:
    with open(args.o,'w+') as ofile:
        seq_SPpattern = re.compile(r'-(?P<seq_sp>[a-zA-Z_\.]+) ')
        rline = ifile.readline()
        Filt_No = False
        while(rline):
          if(rline[0]=='>'):
            seq_sp = seq_SPpattern.search(rline).group('seq_sp')
            if(seq_sp in Species2Taxid.keys()):
                Filt_No = True
                wpart = '{}'.format(Species2Taxid[seq_sp].strip())
                wline = re.sub(r'-(?P<seq_sp>[a-zA-Z_\.]+) ','-{} '.format(wpart),rline)
                #print(wpart)
                ofile.write(wline)
            else:
                Filt_No = False
          elif(Filt_No):
            ofile.write(rline)
          rline = ifile.readline()


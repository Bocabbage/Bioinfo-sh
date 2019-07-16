# Script: Deduplicate.py
# Description: For database(FASTA) deduplication
# Update date: 2019/07/16
# Author: Zhuofan Zhang

from Bio import SeqIO
import argparse
import os

def sequence_cleaner(fasta_file,outputfile):
    ids = []
    with open(outputfile,"w+") as ofile:
        for seq_record in SeqIO.parse(fasta_file, "fasta"):
            sequence = str(seq_record.seq).upper()
            # Check if the current sequence is unique
            if seq_record.id not in ids:
                ids.append(seq_record.id)
                ofile.write(">" + seq_record.id + " " + seq_record.description + "\n" + sequence + "\n")
    print("Deduplication finished!")

parser = argparse.ArgumentParser()
parser.add_argument('--input',help='input file path/name.')
parser.add_argument('--output',help='output file path/name.')
args = parser.parse_args()

if __name__ == '__main__':
    sequence_cleaner(args.input,args.output)


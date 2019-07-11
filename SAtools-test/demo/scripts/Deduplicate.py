# Script: Deduplicate.py
# Description: For database(FASTA) deduplication
# Update date: 2019/07/11
# Author: Zhuofan Zhang

from Bio import SeqIO
import argparse
import os

def sequence_cleaner(fasta_file,outputfile):
    sequences={}
    for seq_record in SeqIO.parse(fasta_file, "fasta"):
        sequence = str(seq_record.seq).upper()
        # Check if the current sequence is unique
        if sequence not in sequences:
            sequences[sequence] = (seq_record.id,seq_record.description)

    filepath,filename = os.path.split(fasta_file)
    with open(outputfile, "w+") as output_file:
        for sequence in sequences:
            output_file.write(">" + sequences[sequence][0] + \
            " " + sequences[sequence][1] + "\n" + sequence + "\n")

    print("Deduplication finished!")

parser = argparse.ArgumentParser()
parser.add_argument('--input',help='input file path/name.')
parser.add_argument('--output',help='output file path/name.')
args = parser.parse_args()

if __name__ == '__main__':
    sequence_cleaner(args.input,args.output)


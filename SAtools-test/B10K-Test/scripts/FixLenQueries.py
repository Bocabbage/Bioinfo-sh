# Script: FixLenQueries
# Description: Cut the Queries(in FASTA file) to be fixed-length samples.
# Update date: 2019/07/16
# Author: Zhuofan Zhang 

from Bio import SeqIO
import argparse
import random

def FixLen(infile,outfile,length,random_state):
    '''
        FixLen Function
    '''
    random.seed(random_state)
    with open(outfile,"w+") as ofile:
        for seq_record in SeqIO.parse(infile,"fasta"):
            seq_len = len(seq_record.seq)
            if seq_len < length:
                print("the 'length' parameter is larger than at least one of the queries' length.")
                return
            loc = random.randint(0,seq_len-length)
            #print("[{},{}]".format(loc,loc+length))
            fixed_sequence = str(seq_record.seq).upper()[loc:loc+length]
            ofile.write(">" + seq_record.id + " " + seq_record.description + "\n" + fixed_sequence + "\n")
    print("Fix finished.")
    
    
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--length',type=int,help='Query length that you want.')
    parser.add_argument('-i',help='Input Queries.(FASTA FORMAT)')
    parser.add_argument('-o',help='Output Fixed-Length Queries.(FASTA FORMAT)')
    parser.add_argument('--seed',type=int,help='Random seed.',default=1)
    args = parser.parse_args()
    
    FixLen(args.i,args.o,args.length,args.seed)

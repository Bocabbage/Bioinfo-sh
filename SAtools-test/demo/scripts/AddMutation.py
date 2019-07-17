# Script: AddMutation.py
# Description: Randomly add mutation to the sequences of a FASTA file.
# Update date: 2019/07/16
# Author: Zhuofan Zhang

from Bio import SeqIO
import argparse
import random

def Indel(pre_seq,times=5):
    '''
       Add indel mutation to one query.
    '''
    AlphaTable = ['A','T','C','G']
    seq = str(pre_seq).upper()
    seq_len = len(seq)
    indices = [random.randint(0,seq_len-1) for i in range(times)]
    for index in indices:
        seq = seq[0:index] + AlphaTable[random.randint(0,3)] + seq[index:]
    return seq

def Subs(pre_seq,times=5):
    '''
        Substitute some bases in one query.
        Take difference between transition&transversion into account.
    '''
    Purine = ['A','G']
    Pyrimidine = ['T','C']
    seq = str(pre_seq).upper()
    seq_len = len(seq)
    indices = [random.randint(0,seq_len-1) for i in range(times)]
    for index in indices:
        if random.randint(0,2) > 1:
            if seq[index] in Purine:
                seq = seq[0:index] + Pyrimidine[random.randint(0,1)] + seq[index+1:]
            else:
                seq = seq[0:index] + Purine[random.randint(0,1)] + seq[index+1:]
        else:
            if seq[index] in Purine: 
                seq = seq[0:index] + Purine[1-Purine.index(seq[index])] + seq[index+1:]
            else:
                seq = seq[0:index] + Pyrimidine[1-Pyrimidine.index(seq[index])] + seq[index+1:]
    return seq



def AddMutation(infile,outfile,random_state,degree,mode,nums):
    '''
        Add mutation to queries in FASTA-FORMAT.
    '''
    Mut_func = [Indel,Subs]
    random.seed(random_state)
    #print(degree*nums)
    indices = [random.randint(0,nums-1) for i in range(0,int(degree*nums))]
    #print(indices)
    with open(outfile,'w+') as ofile:
        for i,seq_record in enumerate(SeqIO.parse(infile,"fasta")):
            if i in indices:
                if mode == 'ALL':
                    added_sequence = (Mut_func[random.randint(0,1)](seq_record.seq),seq_record.id,seq_record.description)
                elif mode == 'INDEL':
                    added_sequence = (Mut_func[0](seq_record.seq),seq_record.id,seq_record.description)
                elif mode == 'SUBS':
                    added_sequence = (Mut_func[1](seq_record.seq),seq_record.id,seq_record.description)
            else:
                added_sequence = (str(seq_record.seq).upper(),seq_record.id,seq_record.description)
            ofile.write(">" + added_sequence[1] + " " + added_sequence[2] + "\n" + added_sequence[0] + "\n")
    print("Add Finish!")



if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--seed',type=int,help='Random seed.',default=1)
    parser.add_argument('-i',help='Input Queries.(FASTA FORMAT)')
    parser.add_argument('-o',help='Output file path/name.')
    parser.add_argument('--mode',help="'ALL','INDEL','SUBS';Default='ALL'",default='ALL')
    parser.add_argument('--nums',type=int,help='queries numbers in the FASTA-FORMAT')
    parser.add_argument('--degree',type=float,help='Float in [0,1];Decide how many percent queries will be added mutation;Default value=0.5.',default=0.5)
    args = parser.parse_args()
    
    AddMutation(args.i,args.o,args.seed,args.degree,args.mode,args.nums)






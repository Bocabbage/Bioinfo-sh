# Can be replaced simply by :
# awk '/^>/{f=!d[$1];d[$1]=1}f' $input > $output
# and the awk command is much moooooooooore faster.

# "I'm a foolish man with only a hummer named python, my BRO."

# Script: Parallel_Deduplicate.py
# Description: For database(FASTA) deduplication(Parallel Version)
# Update date: 2019/07/22
# Author: Zhuofan Zhang

import argparse
import os
import multiprocessing as mp
import subprocess 
from pathlib import Path

def process_wrapper(chunk_seek,chunk_size,seq_list,Ifile,Ofile):
    with open(Ifile,'r') as ifile:
        with open(Ofile,'a') as ofile:
            ifile.seek(chunk_seek)
            for _ in range(chunk_size):
                record_id_anno = ifile.readline()
                record_seq = ifile.readline()
                if record_id_anno and record_id_anno[:record_id_anno.index(' ')] not in seq_list:
                    seq_list.append(record_id_anno[:record_id_anno.index(' ')])
                    ofile.write(record_id_anno)
                    ofile.write(record_seq)
    return 

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--input',help='input file path/name.')
    parser.add_argument('--output',help='output file path/name.')
    parser.add_argument('--cores',type=int,help='CPU core numbers,default=2.',default=2)
    args = parser.parse_args()

    InFileName = Path(args.input)
    OutFileName = Path(args.output)

    if not InFileName.exists():
        print("The input file doesn't exist!")
    else:
        seq_nums = int(subprocess.check_output(
            "less {} | grep '>' | wc -l".format(str(InFileName)),
            shell=True))
        # Divide the file into 'args.cores' parts 
        chunk_size = int(seq_nums / args.cores)
        chunk_seeks = subprocess.check_output(
            "less {} | grep -b '>' | awk '{{FS=\":\"}}{{if(NR%{}==0){{print $1}}}}'".format(
                str(InFileName),
                chunk_size),
            shell=True).decode("utf-8").split("\n")[:-1]
        # Turn 'str' into 'int' list
        chunk_seeks = [int(X) for X in chunk_seeks]

        pool = mp.Pool(args.cores)
        seq_list = mp.Manager().list()
        jobs = []

        for chunk_seek in chunk_seeks:
            jobs.append(pool.apply_async(process_wrapper,
                (chunk_seek,chunk_size,seq_list,InFileName,OutFileName)))

        for job in jobs:
            job.get()

        pool.close()



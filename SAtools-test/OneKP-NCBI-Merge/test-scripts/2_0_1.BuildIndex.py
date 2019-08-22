# Script: BuildIndex.py
# Description: Build bytes-off dict for a FASTA file
# Update date: 2019/08/22
# Author: Zhuofan Zhang
import os
import pickle
import re
import subprocess
import argparse

def BuildIndex(FAdir,outfilename):
    if "onekp" in FAdir:
        FAfile = FAdir + "/{}-SOAPdenovo-Trans-assembly-rename.fa".format(FAdir[-4:])
    else:
        FAfile = FAdir + "/ncbi.cds-rename.fa"
    Offset_Dict = {}
    Headers = subprocess.check_output(
            "grep '>' --byte-offset {}".format(FAfile),
            stderr=subprocess.STDOUT,
            shell=True)
    Headers = [x.decode("utf8") for x in Headers.split(b'\n')][:-1]
    # Remove the last element '' in the list
    #print(Headers)
    Pattern = re.compile(r"(?P<offset>[0-9]+):>(?P<seqname>[^\s]+)")
    for header in Headers:
        Pair = Pattern.search(header)
        Offset_Dict[Pair.group('seqname')]=Pair.group('offset')
    ofile_name = os.path.dirname(FAfile) + '/' + outfilename + '.pkl'
    #print(ofile_name)
    #print(Offset_Dict)
    with open(ofile_name,'wb') as ofile:
        pickle.dump(Offset_Dict,ofile)

if __name__ == '__main__':
    Parser = argparse.ArgumentParser()
    Parser.add_argument('-d',help="FASTA file complete path.")
    Parser.add_argument('-id',help="Index file name.(eg: input:xx and you will get xx.pkl in"
                                   " the same dir as the input FASTA)")
    args = Parser.parse_args()

    BuildIndex(args.d,args.id)





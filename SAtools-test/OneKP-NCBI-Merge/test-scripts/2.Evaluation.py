# Script: Evaluation.py
# Description: Ouput a evaluation-information table of an blast8-format result.
#              Noted that this only matches the dir-struct of the NuclDB.
# Update date: 2019/08/22
# Author: Zhuofan Zhang
import random
import argparse
import re
import pickle

# Default dict numbers in cache is 10
Dict_nums = 10
Dict_Cache = {}

#def FindSeq_ver0.1(seqname,dbdir):
#    spec_pattern = re.compile(r'-(?P<spec>[a-zA-Z_]+)')
#    species = spec_pattern.search(seqname).group('spec')
#    if(seqname[:3] == 'lcl'):
#        fa_file = dbdir + "/ncbi-ALL/ncbi.cds-rename.fa"
#    else:
#        oneKP_ID_pattern = re.compile(r'\|(?P<okp>[A-Z]{4})-')
#        oneKP_ID = oneKP_ID_pattern.search(seqname).group('okp')
#        fa_file = dbdir + "/onekp-{}/{}-SOAPdenovo-Trans-assembly-rename.fa".format(oneKP_ID,oneKP_ID)
#    with open(fa_file,'r') as ifile:
#        seq = ""
#        line = ifile.readline().strip()
#        IsTarget = False
#        while(line):
#           if line[0] == '>':
#                if IsTarget:
#                    return seq,len(seq),species
#                IsTarget = seqname in line
#           elif IsTarget:
#                seq = seq + line.strip()
#           line = ifile.readline()
#
#    return "Failed",0,"Failed"

def ReadSeq(seqname,dict_key,Dict,dbdir):
    '''
        Get the sequence from the FASTA file
        with the help of the Byte-offset-index.
    '''
    if(dict_key == 'ncbi'):
        FAfile = dbdir + '/ncbi-ALL/ncbi.cds-rename.fa'
    else:
        FAfile = dbdir + '/onekp-{}/{}-SOAPdenovo-Trans-assembly-rename.fa'\
        .format(dict_key,dict_key)
    
    rfile = open(FAfile,'r')
    rfile.seek(int(Dict[seqname]))
    seq = ""
    line = rfile.readline()
    while(True):
        line = rfile.readline()
        if(line[0] == '>'):
            break
        seq = seq + line.strip()
    rfile.seek(0,0)
    rfile.close()
    return seq
        

def GetDict(dict_key,dbdir):
    '''
       If the dict needed is not in the cache,
       this function will be called to take the right dict into the cache.
    '''
    global Dict_Cache
    if(dict_key == 'ncbi'):
        Dictfile = dbdir + '/ncbi-ALL/Byte-Offset-Index.pkl'
    else:
        Dictfile = dbdir + '/onekp-{}/Byte-Offset-Index.pkl'.format(dict_key)
    # Unpack the .pkl index and load into a dict
    pkl_file = open(Dictfile,'rb')
    Dict_Cache[dict_key] = pikle.load(pkl_file)
    pkl_file.close()
    return 0


def FindSeq(seqname,dbdir):
    '''
        Main function of this script.
        return the sequence, the length of the sequence and
        the species of this seq in the database.
        (Only the Test-mode)
    '''
    global Dict_Cache
    global Dict_nums
    spec_pattern = re.compile(r'-(?P<spec>[a-zA-Z_]+)')
    species = spec_pattern.search(seqname).group('spec')

    if(seqname[:3] == 'lcl'):
        dict_key = 'ncbi'
    else:
        oneKP_ID_pattern = re.compile(r'\|(?P<okp>[A-Z]{4})-')
        dict_key = oneKP_ID_pattern.search(seqname).group('okp')

    if dict_key not in Dict_Cache.keys():
        if len(Dict_Cache) >= Dict_nums:
            # Cache overflow, so we replace 1 dict in the cache
            del Dict_Cache[random.sample(Dict_Cache.keys(),1)[0]]
        # Get the target dict
        GetDict(dict_key,dbdir)
    seq = ReadSeq(seqname,dict_key,Dict_Cache[dict_key],dbdir)
    return seq,len(seq),species



if __name__ == '__main__':
    Parser = argparse.ArgumentParser()
    Parser.add_argument('-i',help="input blast8-format file.")
    Parser.add_argument('-o',help="output TSV format file.")
    Parser.add_argument('-dir',help="Database dirname.")
    args = Parser.parse_args()

    with open(args.i,'r') as ifile:
        with open(args.o,'w+') as ofile:
            # Header of the stat table
            ofile.write("query_name\tquery\tquery_len\ttarget_name\ttarget\ttarget_len\t"
                        "Qspec\tTspec\tlength\tconsensus\tidentity\tevalue\tscore\n")
            # Cache idea: If the query is the same as the former one, we don't need to
            #             search another time.
            old_queryname = ""
            for result in ifile.readlines():
                query_name,target_name,identity,length,mism,gap,\
                _,_,_,_,evalue,score = result.split("\t")
                consensus = int(length)-int(mism)-int(gap)
                if old_queryname != query_name:
                    (query,query_len,Qspec) = FindSeq(query_name,args.dir)
                    old_queryname = query_name
                (target,target_len,Tspec) = FindSeq(target_name,args.dir)
                ofile.write("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n".
                            format(query_name,query,query_len,target_name,target,target_len,
                                   Qspec,Tspec,length,consensus,identity,evalue,score))

#!/usr/bin/perl -w 
# Script: DivideFA.pl
# Usage: perl -w 0.DivideFA.pl <fasta> <most-seqnums> <direct-name> <subfasta-prefix>
# Update date: 2019/08/08
# Author: Zhuofan Zhang
#use strict;

@ARGV == 4 or die "Usage: perl -w 0.DivideFA.pl <fasta> <most-seqnums> <direct-name> <subfasta-prefix>";

my ($ifile,$subnums,$dir,$prefix) = @ARGV;
my $counts=0;
my $ID=1;

open IFILE,"<$ifile" or die "$!";

while(<IFILE>)
{
    if(/^>/)
    {
        if($counts % $subnums ==0)
        {
            $ofilename = "$dir/"."$prefix-$ID.fa";
            open OFILE, ">$ofilename" or die "$!";
            $ID += 1;
            #print "$counts\n";
        }
        $counts += 1;
    }
    print OFILE;

}

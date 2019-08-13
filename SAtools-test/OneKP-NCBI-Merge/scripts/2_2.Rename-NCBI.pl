#!/usr/bin/perl -w 
# Script: Rename-NCBI.pl
# Usage: perl -w 2_2.Rename-NCBI.pl <infile.fa> <outfile.fa>
# Update date: 2019/08/13
# Author: Zhuofan Zhang

# FORMAT:
# >lcl|NC_XXXXXX.X_[x]+_NP_YYYYYY.Y_Z-Species [..] [..] [[..]...]

use strict;
# use Data::Dumper;
@ARGV == 3 or die "Usage: perl -w 2_2.Rename-NCBI.pl <infile.fa> <outfile.fa> <NCBIid2Species.list>";
my ($ifile,$ofile,$nlist) = @ARGV;
my %id2sp;

open LIST,"<$nlist" or die "$!";
open IFILE,"<$ifile" or die "$!";
open OFILE,">$ofile" or die "$!";

# Load NCBI-ID to SPECIES-NAME list
while(<LIST>)
{
    chomp;
    my @line = split "\t";
    if($line[1]=~ m/^NC_/)
    {
       # Because my stat-file is from Windows, removing the '\r' is needed.
       $line[1] =~ s/\.[0-9]+//g;
       $line[1] =~ s/\r//g;
       $id2sp{$line[1]} = $line[0];
    }

}

# print OFILE Dumper(\%id2sp);

# Rename the sequences
while(<IFILE>)
{
    if(m/^>/)
    {
       chomp;
       $_ =~ m/NC_[0-9]+/;
       # print "$NCID\n";
       $_ =~ m/ \[.*/;
       print OFILE "$`-$id2sp{$NCID}$&\n";
    }
    else
    {    
         print OFILE;
    }
}

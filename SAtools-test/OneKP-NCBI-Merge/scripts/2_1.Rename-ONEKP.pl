#!/usr/bin/perl -w
# Script: Rename-Onekp.pl
# Usage: perl -w Rename-Onekp.pl <infile.fa> <outfile.fa> [species] [taxid] [cds/prot]
# Update date: 2019/09/06
# Author: Zhuofan Zhang
use strict;

@ARGV == 4 or die " Usage: perl -w Rename-Onekp.pl <infile.fa> <outfile.fa>[taxid] [cds/prot].";

my ($ifile,$ofile,$species,$type) = @ARGV;
open IFILE,"<$ifile" or die "$!";
open OFILE,">$ofile" or die "$!";

while(<IFILE>)
{
   if(m/^>/)
   {
        chomp;
        $_ =~ m/-(?<okp_tag>[A-Z]+?-[0-9]+?)-/;
        my $OnekpTag = $+{okp_tag};
        my $Species=$';

        print OFILE ">gnl|onekp|$type_$OnekpTag-$taxid\n";
   }
   else
   {
        print OFILE;
   }
}

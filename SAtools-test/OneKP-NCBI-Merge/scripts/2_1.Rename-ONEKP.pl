#!/usr/bin/perl -w
# Script: Rename-Onekp.pl
# Usage: perl -w Rename-Onekp.pl <infile.fa> <outfile.fa>
# Update date: 2019/08/07
# Author: Zhuofan Zhang
use strict;

@ARGV == 2 or die " Usage: perl -w Rename-Onekp.pl <infile.fa> <outfile.fa> .";

my ($ifile,$ofile) = @ARGV;
open IFILE,"<$ifile" or die "$!";
open OFILE,">$ofile" or die "$!";

while(<IFILE>)
{
   if(m/^>/)
   {
        chomp;
        $_ =~ m/-[A-Z]+?-[0-9]+?-/;
        my $OnekpTag = substr $&,1,-1;
        my $Species=$';
        if ($Species =~ m/cf\._[A-Za-z]+/)
        {
            # case: XXX_cf._XXX[YYY]
            $Species = $`.$&;
        }
        elsif($Species =~ m/[A-Za-z]+?_[a-z]+/)
        {
            # case: XXX_[XXX][YYY]
            # subcase1: XXX_sp.[YYYY]
            $Species =~ s/_sp\.(\w)*//g;
            # subcase2: XXX_sp
            $Species =~ s/_sp\z//g;
            # subcase3: XXX_XXX
            $Species = $&;
        }
        #else
        #{
        #    # case: XXX
        #    $Species = $Species,0,-1;
        #}
        print OFILE ">gnl|onekp|$OnekpTag-$Species\n";
   }
   else
   {
        print OFILE;
   }
}

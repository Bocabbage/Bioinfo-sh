#!/usr/bin/perl -w
# Script: Rename-Onekp.pl
# Usage: perl -w Rename-Onekp.pl <infile.fa> <outfile.fa>
# Update date: 2019/08/26
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
        $_ =~ m/-(?<okp_tag>[A-Z]+?-[0-9]+?)-/;
        my $OnekpTag = $+{okp_tag};
        my $Species=$';
        #if ($Species =~ m/cf\._[A-Za-z]+/)
        #{
        #    # case: XXX_cf._XXX[YYY]
        #    $Species = $`.$&;
        #}
        #elsif($Species =~ m/[A-Za-z]+?_[a-z]+/)
        #{
        #    # case: XXX_[XXX][YYY]
        #    # subcase1: XXX_sp.[YYYY]
        #    $Species =~ s/_sp\..*//g;
        #    # subcase2: XXX_sp
        #    $Species =~ s/(_sp)$//g;
        #    # subcase3: XXX_XXX
        #    #$Species = $&;
        #    print "$Species\n";
        #}
        #else
        #{
        #    # case: XXX
        #    $Species = $Species,0,-1;
        #}

        $Species =~ s/(_sp)$//;
        $Species =~ s/_sp\..*//;
        $Species =~ s/\-.*//;
        #print "$Species\n";
        print OFILE ">gnl|onekp|$OnekpTag-$Species\n";
   }
   else
   {
        print OFILE;
   }
}

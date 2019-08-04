#!/usr/bin/perl -w
# Script: qlen-stat.pl
# Description: get a list of queries'length statistics
# Usage: perl -w qlen-stat.pl <query.fa>
# Update date: 2019/08/04
# Author: Zhuofan Zhang
use strict;

@ARGV == 1 or die "Usage: perl -w qlen-stat.pl <query.fa>";

my ($qfile) = @ARGV;
open QFILE ,"<$qfile" or die "$!";

my $qname;
my $qseq;

while(<QFILE>)
{
    chomp;
    if($_[0] eq '>')
    {
        my $qlen = length($qseq);
        print "$qname\t$qlen";
        $qname = $_;
        $qseq = "";
    }
    else
    {
        $qseq .= $_;
    }
}

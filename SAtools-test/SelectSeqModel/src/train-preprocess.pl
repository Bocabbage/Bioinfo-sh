#!/usr/bin/perl -w
# Script: train-preprocess.pl
# Description: Preprocess the standard BLAST8-FORMAT result for the next TRAINING-step
# Usage: perl -w preprocess.pl <blast6-format file> <name-list> <qlen-list>
# Update date: 2019/08/04(unfinished)
# Author: Zhuofan Zhang
use strict;

@ARGV == 3 or die "Usage: perl -w train-preprocess.pl <blast6-format file> <name-list> <qlen-list>[ > outfile ]";

my ($file,$nlist,$llist) = @ARGV;

open RESULTS, "<$file" or die "$!";
open NLIST,"<$nlist" or die "$!";
open LLIST,"<$llist" or die "$!";

# Get the [NCBI-ID => species] Hash
my %id2sp;
while(<NLIST>)
{
    chomp;
    my @temp = split "\t";
    $id2sp{$temp[1]} = $temp[0];
}

# Get queries' length Hash
my %qlen;
while(<LLIST>)
{
    chomp;
    my @temp = split "\t";
    $qlen{$temp[0]} = $temp[1];
}

# Ignore the header
my $header = <RESULT>;

while(<RESULT>)
{
    chomp;
    my @fields = split "\t";
    my ( $evalue,$score,$id ) = $fields[10,11,2];

    $fields[0] =~ m/\|(\w)+?\./;
    my qsp = $id2sp{substr($&,1,-1)};
    $fields[1] =~ m/-(\w)+-/;
    my ssp = substr($&,1,-1);
    my $label =qsp eq ssp ? 1 : 0;

    my $coverage = abs($fields[7]-$fields[6]) / $qlen{$fields[0]};
    print "$evalue,$score,$id,$coverage,$label\n";

}
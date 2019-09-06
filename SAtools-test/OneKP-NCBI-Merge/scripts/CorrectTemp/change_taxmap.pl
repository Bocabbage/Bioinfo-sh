#!/usr/bin/perl -w
use strict;
@ARGV == 1 or die "$!";
my ($ifile) = @ARGV;
#print $ifile;
open IFILE,"<$ifile" or die "$!";

my $unfinish = 1;

while(<IFILE>)
{
    if($unfinish)
    {
        if(/^(gnl)/)
        {
            $unfinish=0;
            next;
        }
        elsif(/^(lcl)/)
        {
            chomp;
            my($seq,$taxid) = split / /;
            print "$seq-$taxid $taxid\n";
        }
        else
        {
            print;
        }
    }
    else
    {
        print;
    }

}

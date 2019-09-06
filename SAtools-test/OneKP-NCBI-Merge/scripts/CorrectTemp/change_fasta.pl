#!/usr/bin/perl -w 
use strict;
@ARGV == 1 or die "$!";
my ($ifile) = @ARGV;
open IFILE,"<$ifile" or die "$!";

while(<IFILE>)
{
    if(/^>/)
    {
        $_ =~ s/\-[a-zA-Z\._]+\-/\-/g;
    }
    print;
}

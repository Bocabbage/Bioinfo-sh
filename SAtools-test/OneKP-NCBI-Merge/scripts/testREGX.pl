#!/usr/bin/perl -w

use strict;

my ($ifile) = @ARGV;

open IFILE,"<$ifile" or die "$!";

while (<IFILE>)
{
  # print "$`.$&\n" if(m/cf\._[A-Za-z]+/);
  if ( m/cf\._[A-Za-z]+/)
  {
    print;
  }
  elsif(m/[A-Za-z]+?_[a-z]+/)
  {
    print;
  }
}

#!/usr/bin perl -w
=info
Script          : BuildTaxidMap.pl
Description     : Build the Seqid->taxid mapping table
MapTableFormat  : <SequenceId> <TaxonomyId><newline>
Usage           : perl -w BuildTaxidMap.pl <inputFASTA> > <output-table>
Update-date     : 2019/09/05
Author          : Zhuofan Zhang
=cut
use strict;

@ARGV == 1 or die "Usage: perl -w BuildTaxidMap.pl <inputFASTA> > <output-table>";
my ($ifile) = @ARGV;
open IFILE,"<$ifile" or die "$!";

while(<IFILE>)
{
    if(/^>lcl/)
    {
       chomp;
       $_ =~ /(?<SEQID>.*)-(?<TAXID>[0-9]+)\s\[/;
       print "$+{SEQID} $+{TAXID}\n";
    }
    elsif(/^>gnl/)
    {
        chomp;
        my $entry = $_;
        $entry =~ s/\r//g;
        $_ =~ /-(?<TAXID>[0-9]+)\s/;
        $entry = $entry." ".$+{TAXID};
        print "$entry\n";
    
    }
    
}

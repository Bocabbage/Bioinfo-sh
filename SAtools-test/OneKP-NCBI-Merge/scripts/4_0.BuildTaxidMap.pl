#!/usr/bin perl -w
=info
Script          : BuildTaxidMap.pl
Description     : Build the Seqid->taxid mapping table
MapTableFormat  : <SequenceId> <TaxonomyId><newline>
Usage           : perl -w BuildTaxidMap.pl [ncbi/onekp] <inputFASTA> > <output-table>
Update-date     : 2019/09/03
Author          : Zhuofan Zhang
=cut
use strict;

@ARGV == 2 or die "Usage: perl -w BuildTaxidMap.pl [ncbi/onekp] <inputFASTA> > <output-table>";
my ($mode,$ifile) = @ARGV;
open IFILE,"<$ifile" or die "$!";

if($mode eq 'onekp')
{
    $_ = <IFILE>;
    chomp;
    $_ =~ /-(?<TAXID>[0-9]+)\s/;
    my $taxid = $+{TAXID};
    #print "$taxid\n";
    print "$_ $taxid\n";

    while(<IFILE>)
    {
        if(/^>/)
        {
            chomp;
            print "$_ $taxid\n";
        }

    }
}
elsif($mode eq 'ncbi')
{
    while(<IFILE>)
    {
        if(/^>/)
        {
           chomp;
           $_ =~ /(?<SEQID>.*)-(?<TAXID>[0-9]+)\s\[/;
           print "$+{SEQID} $+{TAXID}\n";
        }
    
    }
}
else
{
    die "mode option: 'ncbi' or 'onekp'."
}

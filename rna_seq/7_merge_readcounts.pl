#!/usr/bin/perl -w
=my 
title      : merge_readcounts.pl
usage      : perl merge_readcounts.pl readcounts_directory
description: merge read counts as a matrix
author     : Huamei Li
date       : 10-04-2019
type       : main script
language   : perl script
platform   : ubuntu, unix or windows
=cut

use File::Spec::Functions 'catfile';

use strict;
my $path = shift @ARGV;
opendir DIR, $path or die "USAGE: perl merge_readcounts.pl readcounts_directory";
my @dir_files = readdir DIR;

my $header;
my @sample;
my %hash;

foreach my $file (@dir_files){
	if ($file =~ /^\w+.*\.geneCounts/) {
		push @sample, $file;
		$header .= "\t$file";
		open my $fn, catfile($path, $file) or die;
		while (<$fn>){
			chomp;
			next if ($_ =~ /^\W+/);
			my @array = split /\t/, $_;
			$hash{@array[0]} -> {$file} = $array[1];
		}
		close($fn);
	}
}

print "$header\n";
map {
	my $gene = $_;
	print "$gene";
	foreach my $file (@sample){
		print "\t".$hash{$gene} -> {$file};
	}
	print "\n";
}keys %hash;


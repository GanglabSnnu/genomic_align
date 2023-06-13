#!/bin/perl
use strict;
my $ori_ge = $ARGV[0]; my $genomic = $ARGV[1]; my $abbre = $ARGV[2]; my $out_dir = $ARGV[3];
open(IN, "./$ori_ge/$genomic") or die "$!";
my $id; my %hash;
while(my $line = <IN>){
	chomp($line);
	if($line =~ m/^>(\S+)/){
		$id = $1; $hash{$id} = "";
	}else{
		$line =~ s/[a|t|c|g]/N/g;
		$hash{$id} .= $line;
	}
}close IN;

open(OUT, ">$out_dir/$abbre.genome.fasta") or die "$!";
foreach my $each (keys %hash){
	print OUT ">$each\n$hash{$each}\n";
}close OUT;
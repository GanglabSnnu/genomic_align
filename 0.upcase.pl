#!/bin/perl
use strict;
my $genomic = $ARGV[0];
open(IN, "$genomic") or die "$!";
my $out = $ARGV[1];
open(OUT, ">$out") or die "$!";
my $id; my %hash;
while(my $line = <IN>){
	chomp($line);
	if($line =~ m/^>(\S+)/){
		$id = $1; $hash{$id} = "";
	}else{
		$line = uc($line);
		$hash{$id} .= $line;
	}
}
close IN;

foreach my $each (keys %hash){
	print OUT ">$each\n$hash{$each}\n";
}close OUT;
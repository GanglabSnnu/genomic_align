#!/bin/perl
use strict;
my $in_dir = $ARGV[0]; my $input = $ARGV[1];
open(FA, "$in_dir/$input") or die "$!";
$/ = ">";
my $pre_align = $ARGV[2]; unless(-e "$pre_align"){system("mkdir -p $pre_align");}
my $abbr = $ARGV[3];
while(<FA>){
	chomp;
	if($_ !~ m/^$abbr/){next;}
	my @arr = split(/\n/, $_);
	my $out = $arr[0];
	#system("mkdir $out");
	open(OUT, ">$pre_align/$arr[0].fasta") or die "$!";
	print OUT ">$_";
	close OUT;
}close FA;
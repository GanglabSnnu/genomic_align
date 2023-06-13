#!/bin/perl
use strict;
my $last_dir = shift @ARGV; my $sort_chr = shift @ARGV; my $abbr = shift @ARGV; my $fir_match = shift @ARGV;
opendir(SCHR, "../1.1.lastdb_lastal/$sort_chr") or die $!; 
my @sort_mafs = grep(/^$abbr\_\d+\-$fir_match\.sorted\.maf$/, readdir(SCHR)); close SCHR;
#my @species = ("Pat", "Pau", "Pao", "Pap", "Pal");
my @species = @ARGV;

foreach my $sort_maf (@sort_mafs){
	my $chr_num = $sort_maf; $chr_num =~ s/^\D+//; $chr_num =~ s/\D+$//;
	my $input = $abbr."_".$chr_num."-$fir_match.sorted.maf";
	my $out = $input;
	$input = "../$last_dir/$sort_chr/$input";
	system("sed -i '1,1s/.*/##maf version=1 scoring=multiz/' $input");

	foreach my $each (@species){
		print "$each\n";
		my $query = $abbr."_".$chr_num."-".$each.".sorted.maf"; 
		system("sed -i '1,1s/.*/##maf version=1 scoring=multiz/' ../$last_dir/$sort_chr/$query");
	
		$out =~ s/\.sorted\.maf//; $out = $out."."."$each".".sorted.maf";
		system("multiz $input ../$last_dir/$sort_chr/$query 1 ./$abbr$chr_num.out1.maf ./$abbr$chr_num.out2.maf > $out");
		$input = $out;
	}
}
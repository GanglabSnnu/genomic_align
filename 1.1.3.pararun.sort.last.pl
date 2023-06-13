#!/bin/perl
use strict;

#######this part run very fast, about few minites
#my $last_dir = "/DATADISK/yuanjq/biosoft_shared/multiple_alignment/work_proj/felidea_up02/1.lastdb_lastal/last_out";
my $last_dir = $ARGV[0]; my $abbr = $ARGV[1];
opendir(TOP, $last_dir) or die "$!"; my @chrs = grep(/^$abbr/, readdir(TOP)); close TOP;
chdir $last_dir;


my $pa_lastsort = "1.1.3.para_run.lastsort.txt";
open(PA_LAS, ">$pa_lastsort") or die $!;
foreach my $chr (@chrs){
	opendir(DIR, $chr) or die "$!"; my @mafs = grep(/genome\.fas\.maf$/, readdir(DIR)); close DIR;
	
	foreach my $maf (@mafs){
		my $out = $maf; $out =~ s/\.genome\.fas\.maf$/\.sorted\.maf/;
		my @arr = split(/_|\-|\./, $maf);
		###remove Fec_0x-Fec.genome.fas.maf,the same aligned
		if($arr[0] eq $arr[2]){next;}
		###
		#system("nohup maf-swap $last_dir/$chr/$maf | last-split | maf-swap | last-split | maf-sort > $out_top/$out_dir/$out &");
		print PA_LAS "cd $chr && maf-swap $maf | last-split | maf-swap | last-split | maf-sort > $out && cd ../\n";
	}
}close PA_LAS;

system("ParaFly -c $pa_lastsort -CPU 5");
chdir "../";
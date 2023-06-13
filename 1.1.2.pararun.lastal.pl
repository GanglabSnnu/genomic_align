#!/bin/perl
use strict;
my $db_dir = $ARGV[0]; my $abbr = $ARGV[1];
opendir(FIR, "$db_dir") or die "$!"; my @fir = grep(/^$abbr/, readdir(FIR)); close FIR;
my $query_dir = $ARGV[2]; 
opendir(QUE, "$query_dir") or die "$!"; my @query = grep(/\.fas$/, readdir(QUE)); close QUE;

chdir $db_dir;
my $pa_lastal = "1.1.2.para_run.lastal.txt";
open(PA_LAL, ">$pa_lastal") or die $!;
foreach my $f (@fir){
	foreach my $fas (@query){
		print "$fas\n";
		#system("lastal -P20 -m100 -E0.05 $f.db $query_dir/$fas | last-split -m1 > $f-$fas.maf");
		print PA_LAL "cd $f && lastal -P20 -m100 -E0.05 $f.db $query_dir/$fas | last-split -m1 > $f-$fas.maf && cd ../\n";
	}
}close PA_LAL;
system("ParaFly -c $pa_lastal -CPU 100");
chdir "../";
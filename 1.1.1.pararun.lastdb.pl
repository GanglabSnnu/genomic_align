#!/bin/perl
use strict;
my $fa_dir = $ARGV[0]; opendir(FIR, "$fa_dir") or die "$!"; my @fir = grep(/\.fasta$/, readdir(FIR)); close FIR;
my $last_dir = $ARGV[1]; unless(-e $last_dir){system("mkdir -p $last_dir");} 
chdir $last_dir;

my $pa_lastdb = "1.1.1.para_run.lastdb.txt";
open(PA_LADB, ">$pa_lastdb") or die $!;
foreach my $f (@fir){
	my $last = $f; $last =~ s/\.fasta$//; unless(-e "$last"){system("mkdir -p $last");}
	
	#system("nohup lastdb -uNEAR -cR11 $last_dir/$last/$last.db $fa_dir/$f &");
	print PA_LADB "cd $last && lastdb -uNEAR -cR11 $last.db ../../$fa_dir/$f && cd ../\n";
}close PA_LADB;
system("ParaFly -c $pa_lastdb -CPU 32");
chdir "../";


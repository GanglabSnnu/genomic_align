#!/usr/bin/perl -w
use strict;
use warnings; 

my $s_win = shift @ARGV; #50000, 100000, 200000, 500000
my $foldername = shift @ARGV; opendir(TOPD, "$foldername") or die "$!"; my @chrs = grep(/^chr/, readdir(TOPD)); close TOPD;
my $out_folder = shift @ARGV;

foreach my $chr (@chrs){
	my $chr_num = $chr; $chr_num =~ s/\D+$//;
	opendir(CHRS,"./$foldername/$chr") or die "$!";
	my @array = grep(/^RAxML_bipartitions\.\d+/ ,readdir(CHRS)) or die "$!";
	close CHRS;
	
	my $out_chr = $chr; $out_chr = $out_chr.".tree";
	foreach my $filename ( @array ){
		my $output = $filename; $output =~ s/^\D+//; $output =~ s/\D+$//;
		open(IN, "./$foldername/$chr/$filename") or die "$!";
		my $flag = 0;
		while(my $line = <IN>){
			chomp($line);
			### remove the bootstrap less 70%
			my @arr = ($line =~ m/\)(\d+)\:/g);
			foreach my $bs (@arr){
				$bs =~ s/^\[//; $bs =~ s/\]$//;
				#if($bs < 70){$flag++;}
				if($bs < 50){$flag++;}
			}
			if($flag >= 1){
				#print "the topology concensus less than 70%";
				$flag = 0;
				last;# jump out of this tree!
			}
			###
			#my $out = $line; $out =~ s/[^a-zA-Z\(\)]//g; $out = $out.".txt";
			my $out = $line; $out =~ s/[^a-zA-Z\(\)\,]//g; $out = $out.".txt";
			### catagory the types of topologies of different trees
			open(TREE, ">>./$out_folder/$out") or die "$!";
			print TREE "$line\t".$chr_num."_".$output."\n";
		}
	}
}
close TREE;
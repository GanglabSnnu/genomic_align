#!/usr/bin/perl
### this script mainly increase the whole genome with gap "N"; then we will transform this matrix into alignments;

use strict;
my $renamed_dir = shift @ARGV;
my $maf = shift @ARGV;
my $out_dir = shift @ARGV;
my $sec_dir = shift @ARGV;
my $out = $maf; $out =~ s/^\d+\.species\.//; $out =~ s/\.maf$//; $out = $out.".lst.txt";

my ($fir, $sec, $thi, $for, $fiv, $six) = @ARGV; # manually change
$/ = "a score";
my $i = 0; my $ii = 0; my $iii = 0;
open(MAF, "$renamed_dir/$maf") or die "$!";
open(OUT, ">$out_dir/$sec_dir/$out") or die "$!";
print OUT "species\t$fir\t$sec\t$thi\t$for\t$fiv\t$six\n";
my $lasts = 0;
while(my $line = <MAF>){
	$i++;
	chomp($line);
	if($i == 1){next;}
	$line =~ s/^\s+//; $line =~ s/\s+$//; $line =~ s/[\n|\r]$//;
	my @arr = split(/\n/, $line);#split the input unit(one paragraph of alignment)
	my $score = shift(@arr);
	my $ref = @arr[0];#the first compared species as the reference one
	my @refs = split(/\s+/, $ref);#split the ref. line with the space gap
	my $gap = $refs[2] - $lasts;
	print "$gap\n";
		
	for(my $j=1; $j<=$gap-1; $j++){
		$ii++;
		print OUT "$ii\t";
		for(my $k=1; $k<=$#arr+1; $k++){
			print OUT "N\t";
		}
		print OUT "\n";
	}
		
	#my $ref_len = $refs[3];
	my $ref_len = length($refs[6]);
	$iii = $ii;
	for(my $n=0; $n<=$ref_len-1; $n++){
		$iii++;
		print OUT "$iii\t";
		foreach my $each (@arr){
			my @a = split(/\s+/, $each);
			$a[6] =~ s/-/N/g;
			my @ref = split(//, $a[6]);
			print OUT "$ref[$n]\t";
		}
		print OUT "\n";
	}
	$lasts = $refs[2]+$refs[3]-1;
	$ii = $iii;
}
close MAF; close OUT;
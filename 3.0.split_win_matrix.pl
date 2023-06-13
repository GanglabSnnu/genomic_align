#!/usr/bin/perl
use strict;

my $indir = $ARGV[0];
my $s_win = $ARGV[1];##1000000 or 200000
my $top_dir = $ARGV[2];
my $infile = $ARGV[3];
open(IN, "$indir/$infile") or die "$!";
my $i = 0; 
my $windows = $s_win; ###split_win settled into ** kb
my $r = 1;

my $out_dir = $infile; $out_dir =~ s/lst\.txt/split_matrix/;
unless(-e $out_dir){system("mkdir -p $top_dir/$out_dir");}

my $t_lines = $ARGV[4];
print "total_aligned character number is: $t_lines \n";

my $rounds = $t_lines/$s_win;
my $left = $t_lines%$s_win;
if($left == 0){
	$rounds = $rounds;
}else{$rounds += 1;}

my $count = 0;
while(my $line = <IN>){
	$count++;
	if($count == 1){next;}
	
	$i++;
	chomp($line);
	my @arr = split(/\s+/, $line);
	shift(@arr);
	my $new_line = join "", @arr;
	
#	my $out = "$r.win.txt";
	my $range_s = ($r-1)*$s_win+1; 
	my $range_e = $r*$s_win;
	if($r == ($rounds - 1)){
		$range_e = $t_lines;
	}
	my $range = $range_s."-".$range_e;
	my $out = "$range.win.txt";
	
	if($i > $windows){
		$i = 1;
		$r++;
		#$out = "$r.win.txt";
		$range_s = ($r-1)*$s_win+1; 
		$range_e = $r*$s_win;
		$range = $range_s."-".$range_e;
		$out = "$range.win.txt";
	}
	open(OUT, ">>$top_dir/$out_dir/$out") or die "$!";
	print OUT "$new_line\n";
}close IN; close OUT;
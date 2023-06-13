#!/bin/perl
use strict;
my $s_win = shift @ARGV; ##usually 100kb or 200kb
my $wdir = shift @ARGV;
my $full_align = shift @ARGV; ## 5000
my $aligned_per = shift @ARGV; ## 25%, 30%, 40%, 50%, 60%, 70%
my $full_gap = $aligned_per*$s_win; ## 25%*100000 or 25%*200000
my $dir = shift @ARGV;
opendir(DIR, "$wdir/$dir") or die "$!"; my @files = grep(/\.txt$/, readdir(DIR)); close DIR;
my $top_outdir = shift @ARGV; my $top_dir = $dir; $top_dir =~ s/matrix/windows/; unless(-e $top_dir){system("mkdir -p $top_outdir/$top_dir");}
my $num = scalar @ARGV;
my $fir = shift @ARGV;
my $sec = shift @ARGV;
my $thi = shift @ARGV;
my $for = shift @ARGV;
my $fiv = shift @ARGV;
my $six = shift @ARGV;

my %h_name = ();
foreach (@files){
	my $each = $_; $each =~ s/\.win\.txt$//;
	$h_name{$each} = $_;
}
my @ordered = sort{$a<=>$b}(keys %h_name);
foreach my $matrix (@ordered){
	$matrix = $matrix.".win.txt";
	my $windows = $s_win;
	my $i=0; my $m = 0; my $n = 0;
	my @data = ();
	open(IN, "$wdir/$dir/$matrix") or die "$!";
	while(<IN>){
		chomp;
		if($_ !~ m/N/g){$m++;}
		my $count = 0;
		$count = ($_ =~ s/N/N/g);##对N计数
		### this part you need to change into your own species number
		if($count == $num){$n++;}###判断是否都是gap的个数，7代表所有的物种都是N，即gap
		my @line=split//,$_;
		for my $k(0 .. $#line){
			$data[$k][$i]=$line[$k];
		}
		$i++;
	}
	close IN;
	print "$matrix: $m\t$full_align\t$s_win\|\t$n\t$full_gap\n";	
	if($m<$full_align){next;}##if full aligned number less than the limit (eg. 25000), drop it!
	if($n >= $full_gap){next;}##if the all gap "N" more than the limit(eg. 25%*s_win), drop it! *this not for the seq with repeat region
	#print "$matrix: $m\t$n\n";
	
	my $out = $matrix;
	open(OUT, ">$top_outdir/$top_dir/$out") or die "$!";
	my $j = 0;
	for (@data){
#=pod
		$j++;
		my $each;
		###this part you need to change into your own species
		if($j == 1){$each = $fir;}
		if($j == 2){$each = $sec;}
		if($j == 3){$each = $thi;}
		if($j == 4){$each = $for;}
		if($j == 5){$each = $fiv;}
		if($j == 6){$each = $six;}
		#if($j == 6){$each = "Pap";}
		#if($j == 7){$each = "Pal";}
		print OUT ">$each\n";
#=cut		
		print OUT join("",@{$_}),"\n";
	}
	close OUT;
}
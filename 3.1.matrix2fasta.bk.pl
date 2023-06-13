#!/bin/perl
use strict;
my $s_win = shift @ARGV;##usually 100kb or 200kb
my $wdir = shift @ARGV;
my $dir = shift @ARGV;
my $top_outdir = shift @ARGV;

my ($FCA, $NNE, $NDI $PTI, $PPA, $PLE) = @ARGV;
opendir(DIR, "$wdir/$dir") or die "$!";my @files = grep(/\.txt$/, readdir(DIR));close DIR;

my $top_dir = $dir; $top_dir =~ s/matrix/windows/;
unless(-e $top_dir){system("mkdir -p $top_outdir/$top_dir");}

my $m = 0; my $n = 1;
my %h_name = ();
foreach (@files){
	my $each = $_; $each =~ s/\.win\.txt$//;
	$h_name{$each} = $_;
}

my @ordered = sort{$a<=>$b}(keys %h_name);
foreach my $matrix (@ordered){
	$matrix = $matrix.".win.txt";
	$m++;
	my $out_dir = "$n.50k_files";
#####grouped 5000 files into one directory for convience
#	if($m > 5000){
#		$n++;
#		$m = 1;
#		$out_dir = "$n.50k_files";
#	}
#	unless(-e $out_dir){system("mkdir -p $top_outdir/$top_dir/$out_dir");}
#####


	my $windows = $s_win;
	my $i=0;
	my @data = ();
	open(IN, "$wdir/$dir/$matrix") or die "$!";
	while(<IN>){
		chomp;
		my @line=split//,$_;
		for my $k(0 .. $#line){
			$data[$k][$i]=$line[$k];
		}
		$i++;
	}
	close IN;

	my $out = $matrix;
#	open(OUT, ">$top_outdir/$top_dir/$out_dir/$out") or die "$!";
	open(OUT, ">$top_outdir/$top_dir/$out") or die "$!";
	my $j = 0;
	for (@data){
#=pod		
		$j++;
		my $each;
		if($j == 1){$each = $FCA;}
		if($j == 2){$each = $NNE;}
		if($j == 3){$each = $NDI;}
		if($j == 4){$each = $PTI;}
		if($j == 5){$each = $PPA;}
		if($j == 6){$each = $PLE;}
		#if($j == 7){$each = "Pal";}
		print OUT ">$each\n";
#=cut		
		print OUT join("",@{$_}),"\n";
	}
	close OUT;
}
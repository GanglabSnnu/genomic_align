#!/usr/bin/perl
use strict;

my $main =`pwd`; chomp $main; 
#my $chr_infor = "felidea.karyotype.txt";

##step0: combined the trees,, you should mannually select the top trees at this step
my $chr_infor = shift @ARGV;
open(CIN, $chr_infor) or die $!;
my %hash;
#my $unit = 1000000;
my $unit = 1;
while(<CIN>){
	chomp;
	next if $_ !~ m/^chr/;
	my @arr = split(/\t/, $_);
	my $len = $arr[2]/$unit;
	$hash{$arr[0]} = $len;
	print "$arr[0]\t$hash{$arr[0]}\n";
}close CIN;

my $dir = shift @ARGV; opendir(DIR, "./$dir") or die $!; my @files = grep(/^\(/, readdir(DIR)); close DIR;
my $outdir = shift @ARGV; my $out = "combined.txt"; 
open(OUT, ">$outdir/$out") or die $!;
print OUT "chrom\tstart\tend\tlength\ttype\tvalue\n";
my %hash_win;
foreach (@files){
	print "$_\n";
	my $type = $_; $type =~ s/\.txt$//; my $sign;
	### CHANGE THIS PART BASED ON YOUR OWN SITUATIONS
=pod	#20kb_0.5
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c5";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c6";}
	if($type eq "((((NDI,NNE),PPA),(PLE,PTI)),FCA)"){$sign = "c7";}
	if($type eq "((((NDI,NNE),PLE),(PPA,PTI)),FCA)"){$sign = "c8";}
=cut

=pod	#20kb_0.75
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	if($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),PPA),(PLE,PTI)),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),PLE),(PPA,PTI)),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),(PPA,PTI)),PLE),FCA)"){$sign = "c4";}
	if($type eq "(((((NDI,NNE),PTI),PLE),PPA),FCA)"){$sign = "c4";}
=cut

=pod	#20kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	else{$sign="c4"}
=cut

=pod	#50kb_0.5
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c5";}
	if($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c6";}
	if($type eq "(((((NDI,NNE),PTI),PLE),PPA),FCA)"){$sign = "c7";}
	if($type eq "((((NDI,NNE),PPA),(PLE,PTI)),FCA)"){$sign = "c8";}
=cut

=pod	#50kb_0.75
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c5";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c6";}
	if($type eq "((((NDI,NNE),PPA),(PLE,PTI)),FCA)"){$sign = "c7";}
	if($type eq "((((NDI,NNE),PLE),(PPA,PTI)),FCA)"){$sign = "c8";}
	if($type eq "((((NDI,NNE),(PPA,PTI)),PLE),FCA)"){$sign = "c10";}
	if($type eq "(((((NDI,NNE),PTI),PLE),PPA),FCA)"){$sign = "c11";}
	if($type eq "(((((NDI,NNE),PPA),PLE),PTI),FCA)"){$sign = "c12";}
=cut

=pod	#50kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),PPA),(PLE,PTI)),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),PLE),(PPA,PTI)),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),(PPA,PTI)),PLE),FCA)"){$sign = "c4";}
	else{$sign = "c4";}
=cut

=pod	#100kb_0.5
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c5";}
=cut

=pod	#100kb_0.75
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c5";}
	if($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c6";}
	if($type eq "((((NDI,NNE),PLE),(PPA,PTI)),FCA)"){$sign = "c7";}
	if($type eq "(((((NDI,NNE),PTI),PLE),PPA),FCA)"){$sign = "c8";}	
=cut

=pod	#100kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	else{$sign = "c4";}
=cut

=pod	#200kb_0.75
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c5";}
	if($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c6";}
	if($type eq "(((((NDI,NNE),PPA),PTI),PLE),FCA)"){$sign = "c7";}
=cut

=pod	#200kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	else{$sign = "c4";}
=cut

=pod	#300kb_0.5
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c4";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c5";}
=cut

=pod	#300kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c3";}
	else{$sign = "c4";}
=cut

=pod	#400kb_0.75
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c3";}
	if($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c4";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c5";}
=cut

=pod	#400kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	elsif($type eq "((((NNE,PLE),NDI),(PPA,PTI)),FCA)"){$sign = "c4";}
	else{$sign = "c4";}
=cut

=pod	#500kb_0.75
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	if($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c2";}
	if($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c3";}
	if($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c4";}
	if($type eq "((((NDI,NNE),(PPA,PTI)),PLE),FCA)"){$sign = "c5";}
=cut


=pod	#500kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),(PPA,PTI)),PLE),FCA)"){$sign = "c4";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	else{$sign = "c4";}
=cut

=pod	#1000kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	else{$sign = "c4";}
=cut

#=pod	#2000kb_0.8
	if($type eq "((((PLE,PPA),PTI),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PLE,PTI),PPA),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((PPA,PTI),PLE),(NDI,NNE)),FCA)"){$sign = "c1";}
	elsif($type eq "((((NDI,NNE),PTI),(PLE,PPA)),FCA)"){$sign = "c2";}
	elsif($type eq "((((NDI,NNE),(PLE,PPA)),PTI),FCA)"){$sign = "c3";}
	elsif($type eq "((((NDI,NNE),(PLE,PTI)),PPA),FCA)"){$sign = "c4";}	
	else{$sign = "c5";}
#=cut

	###
	open(TR, "$dir/$_") or die $!;
	while(my $line = <TR>){
		chomp($line);
		my @arr = split(/\s+/, $line);
		my @a = split(/[_|-]/, $arr[1]);
		#my $sta_chr = $a[0];  $sta_chr =~ s/^chr//; $sta_chr = sprintf("%02d", $sta_chr); $sta_chr = "chr".$sta_chr;
		#print OUT "$sta_chr\t$a[1]\t$a[2]\t$hash{$sta_chr}\t$sign\t1\n";
		my $out_print = "$a[0]\t$a[1]\t$a[2]\t$hash{$a[0]}\t$sign\t1";
		print OUT "$out_print\n";
		$hash_win{$arr[1]} = $out_print;
	}close TR;
}close OUT;

=pod
my $out_infor = "out.combined.all.txt";
open(OUT_IF, ">$outdir/$out_infor") or die $!;
print OUT_IF "chrom\tstart\tend\tlength\ttype\tvalue\n";
#my $top_dir = "../3.out.win_500000.tree";
my $top_dir = shift @ARGV;
opendir(TDR, $top_dir) or die $!; my @fdirs = grep(/^chr\d+/, readdir(TDR));close TDR;
foreach my $each (@fdirs){
	print "$each\n";
	my $chr = $each; $chr =~ s/\.split_windows\.tree$//;
	opendir(SDR, "$top_dir/$each") or die $!; my @sfiles = grep(/^RAxML_bestTree/, readdir(SDR));close SDR;
	foreach my $file (@sfiles){
		my @arr = split(/\./, $file); my @a = split(/\-/, $arr[1]);
		my $match = $chr."_".$arr[1];
		if(exists $hash_win{$match}){
			print OUT_IF "$hash_win{$match}\n";
		}else{
			print OUT_IF "$chr\t$a[0]\t$a[1]\t$hash{$chr}\tc9\t1\n";
		}
	}
}close OUT_IF;
=cut

# step1: rename the chromosomes mannually
open(IN, "$outdir/combined.txt") or die $!;
open(OUT, ">$outdir/rename.combined.txt") or die $!;
while(my $line = <IN>){
	chomp($line);
	my @arr = split(/\t/, $line);
	my $chrom;
	if($arr[0] eq "chr1"){$chrom = "A1"}
	if($arr[0] eq "chr2"){$chrom = "A2"}
	if($arr[0] eq "chr3"){$chrom = "A3"}
	if($arr[0] eq "chr4"){$chrom = "B1"}
	if($arr[0] eq "chr5"){$chrom = "B2"}
	if($arr[0] eq "chr6"){$chrom = "B3"}
	if($arr[0] eq "chr7"){$chrom = "B4"}
	if($arr[0] eq "chr8"){$chrom = "C1"}
	if($arr[0] eq "chr9"){$chrom = "C2"}
	if($arr[0] eq "chr10"){$chrom = "D1"}
	if($arr[0] eq "chr11"){$chrom = "D2"}
	if($arr[0] eq "chr12"){$chrom = "D3"}
	if($arr[0] eq "chr13"){$chrom = "D4"}
	if($arr[0] eq "chr14"){$chrom = "E1"}
	if($arr[0] eq "chr15"){$chrom = "E2"}
	if($arr[0] eq "chr16"){$chrom = "E3"}
	if($arr[0] eq "chr17"){$chrom = "F1"}
	if($arr[0] eq "chr18"){$chrom = "F2"}
	if($arr[0] eq "chr19"){$chrom = "X"}
	my $new_line = $line; 
	if($new_line =~ /^chr\d+/){$new_line =~ s/^$arr[0]/$chrom/;}
	print OUT "$new_line\n";
}close IN; close OUT;




## step2: sort the trees
open(RNM, "$outdir/rename.combined.txt") or die $!;
my %hash_pair;
while(my $line = <RNM>){
	chomp($line);
	my @arr = split(/\t/, $line);
	if($line =~ /^chr/i){next;}
	my $str_len = length($arr[3]);# 染色体数量级
	my $start = $arr[1]; $start = sprintf("%010d", $start); # 默认选取了1g长度，将起始位置标准为用于排序
	my $new_pair = "$arr[0]\t$start";
	$hash_pair{$new_pair} = $line;
}close RNM;

open(SORT, ">$outdir/rename.sort.txt") or die $!;
print SORT "chrom\tstart\tend\tlength\ttype\tvalue\n";
foreach my $pair (sort(keys %hash_pair)){
	print SORT "$hash_pair{$pair}\n";
}close SORT;



## step3: fulfil the gaps or the filtered trees
my $s_win = shift @ARGV;
my $aligned_per = shift @ARGV;
open(RIN, "$outdir/rename.sort.txt") or die $!;
open(OUT, ">".$outdir."/".$s_win."_".$aligned_per.".txt") or die $!;
my $last_chr;
my $last_end;
my $last_len;
my $new_end;
my $i = 0;
my @arr;
while(my $line = <RIN>){
	chomp($line);
	next if $line =~ m/^\s+/; #过滤
	if($line =~ /^chr/i){print OUT "$line\n";next;}	# 打印出header
	$i++;	
	@arr = split(/\t/, $line);
	if($last_chr ne $arr[0]){
		if($last_end < $last_len){ # 打印出上一条染色体末端的片段
			$last_end += 1;
			print OUT "$last_chr\t$last_end\t$last_len\t$last_len\tc9\t1\n";
		}
		if($arr[1] ne "0"){
			$last_end = $arr[1]-1;
			print OUT "$arr[0]\t1\t$last_end\t$arr[3]\tc9\t1\n";
			print OUT "$line\n";
			#$last_chr = $arr[0]; $last_end = $arr[2];
		}else{
			print OUT "$line\n";
			#$last_chr = $arr[0]; $last_end = $arr[2];			
		}
	}else{
		$last_end = $last_end+1; 
		if($arr[1] ne $last_end){
			$new_end = $arr[1] - 1;
			print OUT "$arr[0]\t$last_end\t$new_end\t$arr[3]\tc9\t1\n";
			print OUT "$line\n";
			#$last_chr = $arr[0]; $last_end = $arr[2];			
		}else{
			print OUT "$line\n";
			#$last_chr = $arr[0]; $last_end = $arr[2];			
		}
	}
	$last_chr = $arr[0]; $last_end = $arr[2]; $last_len = $arr[3];
}
if($arr[2] < $arr[3]){#文件最后一行，即最后一条染色体末端片段进行输出
	my $add_last_end = $arr[2] + 1;
	print OUT "$arr[0]\t$add_last_end\t$arr[3]\t$arr[3]\tc9\t1\n";
}
close RIN; close OUT;
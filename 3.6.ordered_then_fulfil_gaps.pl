#!/usr/bin/perl
use strict;

open(RIN, "rename.combined.txt") or die $!;
open(OUT, ">final.all.txt") or die $!;
my %hash_line; my %hash_chr; my %hash_e; my %hash_len; 
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
			#print OUT "$hash_chr{$last_chr}\t$hash_e{$last_end}\t$hash_len{$last_len}\t$hash_len{$last_len}\tc9\t1\n";
			print OUT "$last_chr\t$last_end\t$last_len\t$last_len\tc9\t1\n";
		}
		if($arr[1] ne "0"){
			$last_end = $arr[1]-1;
			print OUT "$arr[0]\t0\t$last_end\t$arr[3]\tc9\t1\n";
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

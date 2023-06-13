#!/usr/bin/perl -w
use strict;
use warnings; 

my $s_win = shift @ARGV; #50000, 100000, 200000
my $foldername = shift @ARGV;opendir(TOPD, "./$foldername") or die "$!";my @chrs = grep(/txt$/, readdir(TOPD));close TOPD;
my $out_folder = shift @ARGV;

#my ($c,$n,$u,$t,$o,$p,$l) = ("FCA","NNE","NDI","PTI","PPA","PLE");
#my @sps = ($c,$n,$u,$t,$o,$p,$l);
#my ($g1, $g2, $g3, $g4, $g5, $g6) = ("", "", "", "", "", "");
my @ordered_chrs = sort(@chrs);
foreach my $ori_tree (@ordered_chrs){
	my $tree = $ori_tree; $tree =~ s/\.txt$//;
	my $m1 = "_("; my $m2 = ")_("; my $m3 = "_(("; my $m4 = "_((("; my $m5 = "_(((("; my $m6 = ")_(("; my $m7 = ")_(((";
	
#### replace(order) the inner branch "1-1"
	my @md1 = ($tree =~ m/[a-zA-Z]+\,[a-zA-Z]+/g); 
	foreach my $eh1 (@md1){
		my $cp1 = $eh1;
		my @a1 = split(/\,/, $cp1); my @od1 = sort(@a1); my $li1 = join ",", @od1;
		#print "## 1.repleace: $cp1\t$li1\n";
		$tree =~ s/$eh1/$li1/g;
	}
	#print "\n";
	
	
#### replace the branch with "1-2" branches into "2-1"
	my @md2 = ($tree =~ m/[a-zA-Z]+\,\([a-zA-Z]+\,[a-zA-Z]+\)/g);
	foreach my $eh2(@md2){
		my $cp2 = $eh2; $cp2 =~ s/,\(/$m1/g; 
		#my @a2 = split(/_/, $cp2); my @od2 = sort(@a2); my $li2 = join ",", @od2;
		my @a2 = split(/_/, $cp2); my $li2 = $a2[1].",".$a2[0];
		#print "## 2.repleace:$eh2\t$cp2\t$li2\n";
		$tree =~ s/[a-zA-Z]+\,\([a-zA-Z]+\,[a-zA-Z]+\)/$li2/g;
		#print "## $tree\n";
	}
	#print "\n";
	
	
#### replace(order) the branch "2-2"
	my @md3 = ($tree =~ m/\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+\,[a-zA-Z]+\)/g);
	foreach my $eh3(@md3){
		my $cp3 = $eh3; $cp3 =~ s/\),\(/$m2/g; 
		my @a3 = split(/_/, $cp3); my @od3 = sort(@a3); my $li3 = join ",", @od3; 
		#print "## 3.repleace:$cp3\t$li3\n"; 
		$tree =~ s/\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+\,[a-zA-Z]+\)/$li3/g;	
	}
	#print "\n";
	
	
#### replace the branch with "1-3" branches into "3-1"
	my @md13 = ($tree =~ m/[a-zA-Z]+\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)/g);
	foreach my $eh13(@md13){
		my $cp13 = $eh13;	$cp13 =~ s/,\(\(/$m3/g; 
		#my @a13 = split(/_/, $cp13); my @od13 = sort(@a13); my $li13 = join ",", @od13;
		my @a13 = split(/_/, $cp13); my $li13 = $a13[1].",".$a13[0];
		#print "## 13.repleace:$cp13\t$li13\n";
		$tree =~ s/[a-zA-Z]+\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)/$li13/g;
	}
	#print "\n";
	
	
#### replace the branch with "2-3" branches into "3-2"
	my @md4 = ($tree =~ m/\([a-zA-Z]+\,[a-zA-Z]+\)\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)/g);
	foreach my $eh4(@md4){
		my $cp4 = $eh4;	$cp4 =~ s/\),\(\(/$m6/g; 
		#my @a4 = split(/_/, $cp4); my @od4 = sort(@a4); my $li4 = join ",", @od4;
		my @a4 = split(/_/, $cp4); my $li4 = $a4[1].",".$a4[0];
		#print "## 4.repleace:$cp4\t$li4\n";
		$tree =~ s/\([a-zA-Z]+\,[a-zA-Z]+\)\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)/$li4/g;
	}
	#print "\n";
	
	
#### replace(order) the branch "3-3"
	my @md5 = ($tree =~ m/\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)/g);
	foreach my $eh5(@md5){
		my $cp5 = $eh5; $cp5 =~ s/\),\(\(/$m6/g;
		my @a5 = split(/_/, $cp5); my @od5 = sort(@a5); my $li5 = join ",", @od5;
		print "## 5.repleace:$cp5\t$li5\n";
		$tree =~ s/\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)/$li5/g;
	}
	#print "\n";


#### replace the branch with "1-4(2_2, or 3_1)" branches into "4-1"
	# 1-4(2_2) to 4-1
	my @md6 = ($tree =~ m/[a-zA-Z]+\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+,[a-zA-Z]+\)\)/g);
	foreach my $eh6(@md6){
		my $cp6 = $eh6; $cp6 =~ s/\,\(\(/$m3/g; 
		#my @a6 = split(/_/, $cp6); my @od6 = sort(@a6); my $li6 = join ",", @od6;
		my @a6 = split(/_/, $cp6); my $li6 = $a6[1].",".$a6[0];
		#print "## 6.repleace:$cp6\t$li6\n";
		$tree =~ s/[a-zA-Z]+\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+,[a-zA-Z]+\)\)/$li6/g;
	}
	#print "\n";
	
	# 1-4(3_1) to 4-1
	my @md7 = ($tree =~ m/[a-zA-Z]+\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,[a-zA-Z]+\)/g);
	foreach my $eh7(@md7){
		my $cp7 = $eh7;	$cp7 =~ s/\,\(\(\(/$m4/g; 
		#my @a7 = split(/_/, $cp7); my @od7 = sort(@a7); my $li7 = join ",", @od7;
		my @a7 = split(/_/, $cp7); my $li7 = $a7[1].",".$a7[0];
		#print "## 7.repleace:$cp7\t$li7\n";
		$tree =~ s/[a-zA-Z]+\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,[a-zA-Z]+\)/$li7/g;
	}
	#print "\n";	
	
	
#### replace the branch with "1-5(4_1 or 3_2)" branches into "5-1"
	# 1-5(4_1) to 5-1
	## 1-5[4(3_1)_1]
	my @md81 = ($tree =~ m/[a-zA-Z]+\,\(\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,[a-zA-Z]+\)/g);
	foreach my $eh81(@md81){
		my $cp81 = $eh81; $cp81 =~ s/,\(\(\(\(/$m5/g; 
		#my @a81 = split(/_/, $cp81); my @od81 = sort(@a81); my $li81 = join ",", @od81;
		my @a81 = split(/_/, $cp81); my $li81 = $a81[1].",".$a81[0];
		#print "## 81.repleace:$cp81\t$li81\n";
		$tree =~ s/[a-zA-Z]+\,\(\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,[a-zA-Z]+\)/$li81/g;
	}
	#print "\n";		
	## 1-5[4(2_2)_1]
	my @md8 = ($tree =~ m/[a-zA-Z]+\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+\,[a-zA-Z]+\)\)\,[a-zA-Z]+\)/g);
	foreach my $eh8(@md8){
		my $cp8 = $eh8; $cp8 =~ s/\,\(\(\(/$m4/g; 
		#my @a8 = split(/_/, $cp8); my @od8 = sort(@a8); my $li8 = join ",", @od8;
		my @a8 = split(/_/, $cp8); my $li8 = $a8[1].",".$a8[0];
		#print "## 8.repleace:$cp8\t$li8\n";
		$tree =~ s/[a-zA-Z]+\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+\,[a-zA-Z]+\)\)\,[a-zA-Z]+\)/$li8/g;
	}
	#print "\n";	
	
	# 1-5(3_2) to 5-1
	my @md9 = ($tree =~ m/[a-zA-Z]+\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,\([a-zA-Z]+,[a-zA-Z]+\)\)/g);
	foreach my $eh9(@md9){
		my $cp9 = $eh9;	$cp9 =~ s/\,\(\(\(/$m4/g; 
		#my @a9 = split(/_/, $cp9); my @od9 = sort(@a9); my $li9 = join ",", @od9;
		my @a9 = split(/_/, $cp9); my $li9 = $a9[1].",".$a9[0];
		#print "## 9.repleace:$cp9\t$li9\n";
		$tree =~ s/[a-zA-Z]+\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\)\,\([a-zA-Z]+,[a-zA-Z]+\)\)/$li9/g;
	}
	#print "\n";
#=pod
#### replace the branch with "2-4(2_2 or 3_1)" branches into "4-2"
	# 2-4(2_2) to 4-2
	my @md242 = ($tree =~ m/\([a-zA-Z]+,[a-zA-Z]+\)\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+\,[a-zA-Z]+\)\)/g);
	foreach my $eh242(@md242){
		my $cp242 = $eh242;	$cp242 =~ s/\),\(\(/$m6/g; 
		#my @a242 = split(/_/, $cp242); my @od242 = sort(@a242); my $li242 = join ",", @od242;
		my @a242 = split(/_/, $cp242); my $li242 = $a242[1].",".$a242[0];
		#print "## 242.repleace:$cp242\t$li242\n";
		$tree =~ s/\([a-zA-Z]+,[a-zA-Z]+\)\,\(\([a-zA-Z]+\,[a-zA-Z]+\)\,\([a-zA-Z]+\,[a-zA-Z]+\)\)/$li242/g;
	}
	#print "\n";
	# 2-4(3_1) to 4-2
	my @md243 = ($tree =~ m/\([a-zA-Z]+,[a-zA-Z]+\)\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\),[a-zA-Z]+\)/g);
	foreach my $eh243(@md243){
		my $cp243 = $eh243;	$cp243 =~ s/\),\(\(\(/$m7/g; 
		#my @a243 = split(/_/, $cp243); my @od243 = sort(@a243); my $li243 = join ",", @od243;
		my @a243 = split(/_/, $cp243); my $li243 = $a243[1].",".$a243[0];
		#print "## 243.repleace:$cp243\t$li243\n";
		$tree =~ s/\([a-zA-Z]+,[a-zA-Z]+\)\,\(\(\([a-zA-Z]+\,[a-zA-Z]+\)\,[a-zA-Z]+\),[a-zA-Z]+\)/$li243/g;
	}
	#print "\n";	
#=cut




	my $out_tree = $tree.".txt";
	open(I_T, "./$foldername/$ori_tree") or die "$!";
	open(O_T, ">>./$out_folder/$out_tree") or die "$!";
	while(my $line = <I_T>){
		chomp($line);
		print O_T "$line\n";
	}
	close I_T;
	close O_T;
}
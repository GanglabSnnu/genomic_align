#!/usr/bin/perl -w
use strict;
use warnings;    

my $s_win = shift @ARGV; 
my $foldername=shift @ARGV; opendir(TOPD, "$foldername") or die "$!"; my @chrs = grep(/^chr/, readdir(TOPD)); close TOPD;
my $out_folder = shift @ARGV; unless(-e $out_folder){system("mkdir $out_folder");}
my $fir = shift @ARGV;
my $sec = shift @ARGV;
my $thi = shift @ARGV;
my $for = shift @ARGV;
my $fiv = shift @ARGV;
my $six = shift @ARGV;

foreach my $chr (@chrs){
	my @order=($fir,$sec,$thi,$for,$fiv,$six);    #first sequences will be used as the reference in CODEML results
	
	opendir(CHRS,"$foldername/$chr") or die "$!";
	my @array = grep(/txt$/,readdir(CHRS)) or next;#whether exists, the .txt file
	#my @array = grep(/txt$/,readdir(CHRS)) or die "$!";
	close CHRS;
	
	my $out_chr = $chr;
	unless(-e $out_chr){system("mkdir -p $out_folder/$out_chr");}
	
	my $count; 
	foreach my $filename ( @array )
	{
		my $input=$filename;
		my $output=$filename; $output=~s/txt$/phy/;

		open (FILE,"$foldername/$chr/$filename") or die "$!";
		open (OUT, ">./$out_folder/$out_chr/$output") or die "$!";
		my $species; my %sequences; my $count2=0;
		while(my $line = <FILE> ){          
			chomp $line;     
			if( $line =~ /^>(.+)/ ){
				#$species = $1;
				if($line =~ m/^>$fir/){$species = $fir;}
				if($line =~ m/^>$sec/){$species = $sec;}
				if($line =~ m/^>$thi/){$species = $thi;}
				if($line =~ m/^>$for/){$species = $for;}
				if($line =~ m/^>$fiv/){$species = $fiv;}
				if($line =~ m/^>$six/){$species = $six;}
				#if($line =~ m/^>Pap/){$species = "Pap";}
				#if($line =~ m/^>Pal/){$species = "Pal";}
				$sequences{$species} = '';
				$count2++;
			}
			else{
				$sequences{$species} .= $line;                      
			}
		}
		close FILE;
		my $len=length($sequences{$species});
		print OUT "$count2        $len\n";   

		foreach my $name (@order){  
			my $spacen=50-length($name);                 
			print OUT $name,' 'x$spacen,$sequences{$name},"\n";                
		}
		$count++;
		print "$count files done--\n";	
		close OUT;
	}
}
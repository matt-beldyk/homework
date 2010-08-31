#!/usr/local/bin/perl 
use warnings;
use strict;
use Carp;
use Data::Dumper;

if(!$ARGV[0]){
		print STDERR "$0 <corpus_file>\n";
		exit 1;
}

my $fname = $ARGV[0];


open(my $fh, "< $fname") or croak "$fname wouldn't open, sorry.\n";

my $index = read_file($fh);
deserialize($index);


exit;

sub deserialize {
	my $index = shift;

	foreach my $key (sort keys %$index){
		print "$key,";
		if(!defined @{$index->{$key}}){
				print STDERR Dumper($key);
				carp "Whoah!! '$key' doesn't have a list of docs";
		}
		print join(',', @{$index->{$key}}). "\n";
	}
}

sub read_file {
	my $fh = shift;
	my %index;

	my $current_doc = undef;;
	while(my $line = <$fh>){
		if(!defined $line){
			last;
		}elsif ($line =~ /^\.I\s+(\d+)$/){
			($current_doc) = $line =~ /^\.I\s+(\d+)$/;
		} elsif ($line =~ /^\.W$/){
		} else { #part of the document
			
			# split the line on NOT valid word chars
			chomp $line;
			$line =~ s/^([^\-\w])+//;

			my @words = split(/[^\-\w]+/, $line);
			map {
				if(!defined $index{$_}){
					$index{$_}= [];
				}
				push (@{$index{$_}}, $current_doc);
			} @words;
		}
	}

	# incase the documents aren't in order
	foreach my $key (sort keys %index){
		# I explicitly want to sort these as numbers, not strings
		@{$index{$key}} = sort {$a <=> $b }(@{$index{$key}});
	}
	return \%index;
}



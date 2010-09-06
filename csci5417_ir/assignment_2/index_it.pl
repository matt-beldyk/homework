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
my @c = qw(a b c d e);
my @d = qw(b d e f g h);

print join(' ', intersection(\@c, \@d)). "\n";
exit;

open(my $fh, "< $fname") or croak "$fname wouldn't open, sorry.\n";

my $index = read_file($fh);
#deserialize($index);
print STDERR "Terms: ".(scalar (keys %$index)). "\n";
my $postings_count = 0;
map {$postings_count += (scalar @{$index->{$_}})} (keys %$index);

print STDERR "Postings: $postings_count\n";


# If I have this module, wonderful, if not I can't get this info easily
# http://search.cpan.org/~browseruk/Devel-Size/lib/Devel/Size.pm
eval {
    require Devel::Size;
    Devel::Size->import(qw(size total_size));

    print STDERR "Size of pointers internal to \$index = " .size($index)."\n";
    print STDERR "Total Size of \$index = " .total_size($index)."\n";
};

exit;

sub intersection {
    my $c = shift;
    my $d = shift;

    my %existance;
    map {$existance{$_} += 1} (@$c);
    map {$existance{$_} += 1} (@$d);

    return (grep {$existance{$_} >= 2;} (keys %existance));
}
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
		@{$index{$key}} = prune_and_sort_list(@{$index{$key}});
	}
	return \%index;
}

sub prune_and_sort_list {

    my @list = @_;

	# I explicitly want to sort these as numbers, not strings
    @list = sort {$a <=> $b} @list;

    my @n;
    my $last;

    # Pruning some duplicate items from the lists
    foreach my $item (@list){
        if(!(defined $last && $item == $last)){
            push (@n, $item);
            $last = $item;
        }
    }
    return @n;
}


=head1 COPYRIGHT 

Copyright 2010 Matthew Beldyk.

This software is subject to either of two licenses (BSD or D&R), which you can choose
from in your use of the code. The terms for each of these licenses is listed below:

BSD License
===========

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to
deal in the Software without restriction, including without limitation the
rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
     
	 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
	 THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
	 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
	 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

D&R (Death and Repudiation) License
===================================

This software may not be used directly by any living being. ANY use of this
software (even perfectly legitimate and non-commercial uses) until after death
is explicitly restricted. Any living being using (or attempting to use) this software
will be punished to the fullest extent of the law.

For your protection, corpses will not be punished. We respectfully request
that you submit your uses (revisions, uses, distributions, uses, etc.) to
your children, who may vicariously perform these uses on your behalf. If
you use this software and you are found to be not dead, you will be punished
to the fullest extent of the law.

If you are found to be a ghost or angel, you will be punished to the fullest
extent of the law.

After your following the terms of this license, the author has vowed to repudiate
your claim, meaning that the validity of this contract will no longer be recognized.
This license will be unexpectedly revoked (at a time which is designated to be
most inconvenient) and involved heirs will be punished to the fullest extent
of the law.

Furthermore, if any parties (related or non-related) escape the punishments
outlined herein, they will be severely punished to the fullest extent of a new
revised law that (1) expands the statement "fullest extent of the law" to encompass
an infinite duration of infinite punishments and (2) exacts said punishments
upon all parties (related or non-related).

=cut

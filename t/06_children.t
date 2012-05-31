#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;
use FreezeThaw qw(freeze thaw);

use Test::More tests => 2;

use lib './lib';
use GenePool::Person;

my @p  = GenePool::Person->search({name => "Papa Bear"});
my $p = shift @p;
my @peeps = $p->children();
is(@peeps, 3, 'right number of children');

@p  = GenePool::Person->search({name => "Mother Bear"});
$p = shift @p;
my @peeps2 = $p->children();

my $peeps1 = freeze(\@peeps);
my $peeps2 = freeze(\@peeps2);

is($peeps1, $peeps2, 'same children!'); 


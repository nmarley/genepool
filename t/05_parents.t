#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;
use FreezeThaw qw(freeze thaw);

use Test::More tests => 1;

use lib './lib';
use GenePool::Person;

my @p  = GenePool::Person->search({name => "Baby Bear"});
my $p = shift @p;
my @peeps = $p->parents();

@p  = GenePool::Person->search({name => "Sister Bear"});
$p = shift @p;
my @peeps2 = $p->parents();

my $peeps1 = freeze(\@peeps);
my $peeps2 = freeze(\@peeps2);

is($peeps1, $peeps2, 'same parents!');


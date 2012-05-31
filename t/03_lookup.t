#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;

use Test::More tests => 6;

use lib './lib';
use GenePool::Person;

my @p = GenePool::Person->search({
                                    name => "Baby Bear"
                                 });
my $p = shift @p;

ok($p->isa('GenePool::Person'), 'got the right class');
is($p->name, "Baby Bear", 'got the right name');
is($p->age, 12, 'got the right age');


@p = GenePool::Person->search({
                                    name => "Papa Bear"
                              });
$p = shift @p;
ok($p->isa('GenePool::Person'), 'got the right class');
is($p->age, 43, 'got the right age');


@p = GenePool::Person->search({
                              birthplace => "Detroit, Michigan"
                              });
$p = shift @p;

my $fn = (split /\s+/, $p->name)[0];

is($fn, 'Brother', 'Got the right kid.');




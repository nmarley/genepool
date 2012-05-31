#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;

use Test::More tests => 5;

use lib './lib';
use GenePool::Person;

my @p  = GenePool::Person->find(3);
my $p = shift @p;

my @sibs = $p->siblings();

is(@sibs, 2, 'got the right number of siblings');
is($sibs[0]->name, 'Sister Bear', 'got the right name');
is($sibs[0]->age, 22, 'got the right age');

is($sibs[1]->name, 'Baby Bear', 'got the right other name');
is($sibs[1]->age, 12, 'got the right other age');


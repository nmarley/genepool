#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;
use FreezeThaw qw(freeze thaw);

use Test::More tests => 3;

use lib './lib';
use GenePool::Person;

my (@p, $p);

@p  = GenePool::Person->find(4);
$p = shift @p;

my $dad = $p->dad();

is($dad->name, "Papa Bear", 'Got dad!');
is($dad->age , 43, "Got dad's age");
is($dad->birthplace, 'New York City, NY, USA', "Dad's place of birth");



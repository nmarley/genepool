#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;

use lib './lib';
use GenePool::Person;
use Test::More tests => 2;

my $person = GenePool::Person->find(3);

ok( defined($person) , "got something");
ok( $person->isa('GenePool::Person') , "...and it's the right class");



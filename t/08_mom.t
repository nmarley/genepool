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

my $mom = $p->mom();

is($mom->name, "Mother Bear", 'Got mom!');
is($mom->age , 42, "Got mom's age...");
is($mom->birthdate, '1970-04-05', "Got mom's birthday");


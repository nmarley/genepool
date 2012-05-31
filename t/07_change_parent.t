#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;
use FreezeThaw qw(freeze thaw);

use Test::More tests => 4;

use lib './lib';
use GenePool::Person;

my (@p, $p);

@p  = GenePool::Person->search({name => "Papa Bear"});
$p = shift @p;
my $papa_id = $p->id;

@p  = GenePool::Person->search({name => "Mother Bear"});
$p = shift @p;
my $mama_id = $p->id;

@p  = GenePool::Person->search({name => "Baby Bear"});
$p = shift @p;


$p->mother($mama_id);
$p->father($papa_id);
$p->save();

undef $p;
undef @p;
undef $mama_id;
undef $papa_id;

@p  = GenePool::Person->search({name => "Baby Bear"});
$p = shift @p;

my @rents = $p->parents();
my @sibs  = $p->siblings();

is(@rents, 2, 'got 2 parents');
is(@sibs , 2, 'got 2 siblings...');

my @mom_and_dad = sort { $a cmp $b }  map { (split(/\s+/, $_->name))[0]  } @rents;
is(join(' ',@mom_and_dad), 'Mother Papa', 'got the right mom & dad.');

my @sisbro = sort { $a cmp $b } map { (split(/\s+/, $_->name))[0] } @sibs;
is(join(' ',@sisbro), 'Brother Sister', 'got the right sis & bro.');



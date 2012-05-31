#! /usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use File::Basename;
use Carp;

use lib './lib';
use DBIC::GenePool;
use Test::More tests => 2;

my $dsn = "dbi:SQLite:dbname=genes.db";
my $schema = DBIC::GenePool->connect( $dsn,,,
    {RaiseError => 1, AutoCommit => 1});

my $model  = $schema->resultset('Person');
my $person  = $model->find({name => "Papa Bear"});

ok( defined( $person) , "got something");
ok( $person->isa('DBIC::GenePool::Result::Person') , "...and it's the right class");


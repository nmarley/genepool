#! /usr/bin/perl

use common::sense;
use Data::Dumper;
use File::Basename;
use Carp;
use JSON;

use GenePool::Person;

my $x = GenePool::Person->new(
    id         => 7,
    name       => 'Nate Thon',
    birthplace => 'São Paulo',
    birthdate  => '1982-10-13',
    gender     => 'M',
);

say encode_json($x->TO_JSON);


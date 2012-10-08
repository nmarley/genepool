#! /usr/bin/perl

use common::sense;
use Data::Dumper;
use File::Basename;
use Carp;

use GenePool::Person;

my $schema = $GenePool::Person::schema;

$schema->populate('Person' => [
  [ 'name', 'gender', 'birthdate', 'birthplace', 'father', 'mother' ],
  [ 'Papa Bear', 'f', '1968-12-18', 'New York City, NY, USA', 0, 0 ],
  [ 'Mother Bear', 'm', '1970-04-05', 'Der Schwarzwald, Baden-Württemberg, Deutschland', 0, 0 ],
  [ 'Brother Bear', 'm', '1988-06-29', 'Detroit, Michigan', 1, 2 ],
  [ 'Sister Bear', 'f', '1990-05-30', 'San Francisco', 1, 2 ],
  [ 'Baby Bear', 'm', '1999-07-21', 'Portland, OR', 1, 2 ],
]);



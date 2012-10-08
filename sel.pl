#! /usr/bin/perl

use common::sense;
use Data::Dumper;
use File::Basename;
use Carp;

use GenePool::Person;

#my @attrs = (qw/id name gender birthdate birthplace date_of_death place_of_death comments father mother/);
my @attrs = (qw/id name gender birthdate birthplace father mother/);

for my $p ( GenePool::Person->all ) {
    #my $hr = $p->TO_JSON;
    #my @attrs = keys %$hr;
    # join(", ", @$hr{ @attrs });

    my @values = map { $p->$_ } @attrs;
    for my $index ( 1 .. (@values - 3) ) {
        $values[$index] = "'" . $values[$index] . "'";
    }
    my $valstr = join(', ', @values);

    say "insert into person (" . join(', ', @attrs) .  ") values (" . $valstr . ")";
}

__END__

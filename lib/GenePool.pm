package GenePool;

use common::sense;
use Dancer ':syntax';
use Data::Dumper;
use GenePool::Person;

our $VERSION = '0.1';

get '/' => sub {
    my @all = GenePool::Person->all();
    template 'index', { people => \@all };
};

# TODO: display PERSON object via a 'card'
# (this will mean wirting a style with TT in views,
#  e.g. creating views/person.tt)
get '/person/:id' => sub {
    my $id = params->{id};
    my $person = GenePool::Person->find($id);
    debug "birthplace: [" . $person->birthplace . "]";

    return undef unless defined $person;

    debug "birthplace: [" . $person->birthplace . "]";

    template 'person', { person => $person };
};

get '/umlaut' => sub {
    #my $text = "This is söme tëxt";
    my $text = GenePool::Person->umlaut();
    template 'umlaut', { text => $text };
};

true;


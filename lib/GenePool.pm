package GenePool;

use Dancer;

use lib './lib';
use GenePool::Person;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

# TODO: display PERSON object via a 'card'
# (this will mean wirting a style with TT in views,
#  e.g. creating views/person.tt)
get '/get/:id' => sub {
    my $person = GenePool::Person->find(params->{id});

    return undef unless defined $person;
    # $person->name;
    template 'person', { person => $person };

};

true;

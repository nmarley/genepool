package GenePool::Person;

use Moose;
use Carp;
use Data::Dumper;
use POSIX qw/strftime/;
use Data::UUID;

our @EXPORT_OK = qw( dbic_to_moose );

# persistent storage for data
# =============================================
use lib './lib';
use DBIC::GenePool;
my $dsn = "dbi:SQLite:dbname=genes.db";
my $schema = DBIC::GenePool->connect( $dsn,,,
    {RaiseError => 1, AutoCommit => 1});
# =============================================

has 'id' => (
    is  => 'ro',
    isa => 'Int',
    writer => 'set_id'
);

has 'name' => (
    is  => 'rw',
    isa => 'Str',
);

has 'gender' => (
    is  => 'rw',
    isa => 'Str',
);

has 'birthplace' => (
    is  => 'rw',
    isa => 'Str',
);

has 'birthdate' => (
    is  => 'rw',
    isa => 'Str',
);

has 'father' => (
    is  => 'rw',
    isa => 'Int',
);

has 'mother' => (
    is  => 'rw',
    isa => 'Int',
);

sub BUILD {
    my $self = shift;

    if ( !defined($self->name) ) {
        croak("Error! Person must have a name");
    }
    if ( !defined($self->gender) ) {
        croak("Error! Person must have a gender");
    }

    # lowercase gender indicator
    $self->gender(lc($self->gender()));

    if( $self->gender !~ m/^[mf]$/ ) {
        croak("Error! Invalid gender value: [" . $self->gender . "]. Valid values are: 'm', 'f'");
    }

    if ( !defined($self->mother) ) {
        $self->mother(0);
    }
    if ( !defined($self->father) ) {
        $self->father(0);
    }

}

sub save {
    my $self  = shift;
    my $model = $schema->resultset('Person');

    my %store_values = ( name       => $self->name,
                         gender     => $self->gender,
                         birthplace => $self->birthplace,
                         birthdate  => $self->birthdate,
                         father     => $self->father,
                         mother     => $self->mother,
                       );

    my ($person, $rc);
    if ( defined($self->id) && $self->id != 0 ) {
        $person = $model->find({id => $self->id});
        $rc = $person->update( \%store_values );
    }
    else {
        $rc = $model->create( \%store_values );
        $person = $model->find(\%store_values);
    }

    $self->set_id($person->id);

    return $rc;
}


sub find {
    my $class = shift;
    my $id    = shift;
    my $model = $schema->resultset('Person');

    my @attrs = qw(name gender birthplace birthdate);

    my $person;
    if ( defined($id) && $id != 0 ) {
        $person = $model->find({id => $id});
    }

    return if (!defined($person));

    my %new_attrs = map { $_ => $person->$_ } @attrs;
    $new_attrs{father} = $person->father->id;
    $new_attrs{mother} = $person->mother->id;

    my $p = $class->new(%new_attrs);
    $p->set_id($id);

    return $p;
}


sub search {
    my $class = shift;
    my $hr    = shift;

    my @attrs = qw(name gender birthplace birthdate mother father);

    for my $k (keys %$hr) {
        delete $hr->{$k} if (!(grep { /$k/ } @attrs));
    }

    my $model = $schema->resultset('Person');
    my @people = $model->search( $hr )->all();

    my @results = map { dbic_to_moose($_) } @people;

    return @results;
}

sub age {
    my $self = shift;

    return undef unless defined($self->birthdate);

    my $now_ts = time();
    my $this_year = POSIX::strftime("%Y", localtime($now_ts));
    my ($year, $month, $day) = (split/-/, $self->birthdate);

    my $now = POSIX::strftime("%m%d", localtime($now_ts));
    my $birthddmm = sprintf("%02d%02d", $month, $day);

    my $age = $this_year - $year;

    # don't count current year if birthday has not yet passed
    $age-- if ( $now < $birthddmm );

    return $age;
}


sub dbic_to_moose {
    my $person = shift;
    my $moose;

    my @attrs = qw(name gender birthplace birthdate);

    my %new_attrs = map { $_ => $person->$_ } @attrs;

    $new_attrs{father} = $person->father->id;
    $new_attrs{mother} = $person->mother->id;
    $moose = __PACKAGE__->new(%new_attrs);
    $moose->set_id($person->id);

    return $moose;
}


# Returns an array of GenePool::Person objects.
# The order is random and not guaranteed.
sub siblings {
    my $self = shift;
    my $model = $schema->resultset('Person');

    my $person;
    if ( defined($self->id) && $self->id != 0 ) {
        $person = $model->find({id => $self->id});
    }


    # here is the equivalent SQL that this where clause should
    # generate:
    # select * from person
    # where id != 1 and ( (mother = 0 and mother != 0) or (father = 0 and father != 0) )
    
    # select * from person
    # where id != 2 and ( (mother = 4 and mother != 0) or (father = 3 and father != 0) ) ;

    my %where =
        ( id => { '!=' => $person->id } 
        , -or => { -and => [father => $person->father->id, father => {'!=' => 0} ],
                   -and => [mother => $person->mother->id, mother => {'!=' => 0} ] }
        );

    my @siblings = $model->search( \%where )->all();

    my @p;
    for my $sib ( @siblings ) {
        my $p = dbic_to_moose($sib);
        push @p, $p;
    }

    return @p;
}


# Returns an array of GenePool::Person objects.
# The order is random and not guaranteed.
sub parents  {
    my $self = shift;
    my $model = $schema->resultset('Person');

    my $person;
    if ( defined($self->id) && $self->id != 0 ) {
        $person = $model->find({id => $self->id});
    }

    my %where =
        ( id => { -in => [ $person->father->id, $person->mother->id ] } );

    my @parents = $model->search( \%where )->all();

    my @p;
    for my $par ( @parents ) {
        my $p = dbic_to_moose($par);
        push @p, $p;
    }

    return @p;
}


# Returns an array of GenePool::Person objects.
# The order is random and not guaranteed.
sub children {
    my $self = shift;
    my $model = $schema->resultset('Person');

    my $person;
    if ( defined($self->id) && $self->id != 0 ) {
        $person = $model->find({id => $self->id});
    }

    my @where = ( -or => [ {father => $person->id},
                           {mother => $person->id} ] );
    my @peeps = $model->search( \@where )->all();

    my @p;
    for my $pobj ( @peeps ) {
        my $p = dbic_to_moose($pobj);
        push @p, $p;
    }

    return @p;
}


sub delete {
    my $self  = shift;
    my $model = $schema->resultset('Person');

    my ($person, $rc);
    if ( defined($self->id) && $self->id != 0 ) {
        $person = $model->find({id => $self->id});
        $rc = $person->delete();
    }

    return $rc;
}

sub mom {
    my $self  = shift;
    my $model = $schema->resultset('Person');

    return undef unless (defined($self->id) && $self->id != 0);
    my $person = $model->find({id => $self->id});
    return undef unless defined ($person);

    my $momobj = $model->find({id => $person->mother->id});
    my $mom = dbic_to_moose( $momobj );
    return $mom;
}

sub dad {
    my $self  = shift;
    my $model = $schema->resultset('Person');

    return undef unless (defined($self->id) && $self->id != 0);
    my $person = $model->find({id => $self->id});
    return undef unless defined ($person);

    my $dadobj = $model->find({id => $person->father->id});
    my $dad = dbic_to_moose( $dadobj );
    return $dad;
}


no Moose;
__PACKAGE__->meta->make_immutable;


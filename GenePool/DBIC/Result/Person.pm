use utf8;
package GenePool::DBIC::Result::Person;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

GenePool::DBIC::Result::Person

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<person>

=cut

__PACKAGE__->table("person");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 gender

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 birthdate

  data_type: 'date'
  is_nullable: 1

=head2 birthplace

  data_type: 'text'
  is_nullable: 1

=head2 date_of_death

  data_type: 'date'
  is_nullable: 1

=head2 place_of_death

  data_type: 'text'
  is_nullable: 1

=head2 comments

  data_type: 'text'
  is_nullable: 1

=head2 father

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 mother

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "gender",
  { data_type => "char", is_nullable => 1, size => 1 },
  "birthdate",
  { data_type => "date", is_nullable => 1 },
  "birthplace",
  { data_type => "text", is_nullable => 1 },
  "date_of_death",
  { data_type => "date", is_nullable => 1 },
  "place_of_death",
  { data_type => "text", is_nullable => 1 },
  "comments",
  { data_type => "text", is_nullable => 1 },
  "father",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "mother",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 father

Type: belongs_to

Related object: L<GenePool::DBIC::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "father",
  "GenePool::DBIC::Result::Person",
  { id => "father" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 mother

Type: belongs_to

Related object: L<GenePool::DBIC::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "mother",
  "GenePool::DBIC::Result::Person",
  { id => "mother" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 person_fathers

Type: has_many

Related object: L<GenePool::DBIC::Result::Person>

=cut

__PACKAGE__->has_many(
  "person_fathers",
  "GenePool::DBIC::Result::Person",
  { "foreign.father" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 person_mothers

Type: has_many

Related object: L<GenePool::DBIC::Result::Person>

=cut

__PACKAGE__->has_many(
  "person_mothers",
  "GenePool::DBIC::Result::Person",
  { "foreign.mother" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 personoldl_fathers

Type: has_many

Related object: L<GenePool::DBIC::Result::Personoldl>

=cut

__PACKAGE__->has_many(
  "personoldl_fathers",
  "GenePool::DBIC::Result::Personoldl",
  { "foreign.father" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 personoldl_mothers

Type: has_many

Related object: L<GenePool::DBIC::Result::Personoldl>

=cut

__PACKAGE__->has_many(
  "personoldl_mothers",
  "GenePool::DBIC::Result::Personoldl",
  { "foreign.mother" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-10-03 19:43:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WDv2y6l8lLMZ5Mhsk2rpWA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

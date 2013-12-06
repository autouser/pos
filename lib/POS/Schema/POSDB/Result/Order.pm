use utf8;
package POS::Schema::POSDB::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

POS::Schema::POSDB::Result::Order

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<orders>

=cut

__PACKAGE__->table("orders");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  is_nullable: 1

=head2 customer_id

  data_type: 'integer'
  is_nullable: 1

=head2 item_id

  data_type: 'integer'
  is_nullable: 1

=head2 price

  data_type: 'money'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "created_at",
  { data_type => "datetime", is_nullable => 1 },
  "customer_id",
  { data_type => "integer", is_nullable => 1 },
  "item_id",
  { data_type => "integer", is_nullable => 1 },
  "price",
  { data_type => "money", is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<id_created_at_customer_id_item_id_price_unique>

=over 4

=item * L</id>

=item * L</created_at>

=item * L</customer_id>

=item * L</item_id>

=item * L</price>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "id_created_at_customer_id_item_id_price_unique",
  ["id", "created_at", "customer_id", "item_id", "price"],
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-07-17 19:21:09
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yQcDHsS8B3MB0nShJN4QzQ

__PACKAGE__->belongs_to( customer => 'POS::Schema::POSDB::Result::Customer', 'customer_id' );
__PACKAGE__->belongs_to( item => 'POS::Schema::POSDB::Result::Item', 'item_id' );

__PACKAGE__->resultset_class('POS::Schema::POSDB::ResultSet::Order');

__PACKAGE__->meta->make_immutable;
1;

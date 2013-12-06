use utf8;
package POS::Schema::POSDB::Result::ReportDates;

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');

__PACKAGE__->table('year2000cds');
__PACKAGE__->result_source_instance->is_virtual(1);
__PACKAGE__->result_source_instance->view_definition(
  "select distinct date(created_at) as date from orders order by 1"
);
__PACKAGE__->add_columns(
  'date' => { data_type => "varchar", is_nullable => 1, size => 255 },
);

__PACKAGE__->meta->make_immutable;

1;
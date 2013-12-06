package POS::Model::POSDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

my $dsn = $ENV{TEST_DSN} || $ENV{POS_DSN} || 'dbi:SQLite:dbname=pos.db';
__PACKAGE__->config(
    schema_class => 'POS::Schema::POSDB',
    
    connect_info => {
        dsn => $dsn,
        user => '',
        password => '',
    }
);

=head1 NAME

POS::Model::POSDB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<POS>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<POS::Schema::POSDB>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.6

=head1 AUTHOR

eugene

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
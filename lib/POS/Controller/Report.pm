package POS::Controller::Report;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

POS::Controller::Report - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub show :Local Args(1) {
  my ( $self, $c, $date ) = @_;
  $c->stash->{date} = $date;
  $c->stash->{report} = [ $c->model('POSDB::Order')->report($date) ];
}

sub text :Local Args(1) {
  my ( $self, $c, $date ) = @_;
  $c->res->content_type('text/plain');
  my $content = $c->model('POSDB::Order')->report_text($date);
  $c->res->header('Content-Disposition', qq[attachment; filename="$date.txt"]);
  $c->res->body($content);
}


=encoding utf8

=head1 AUTHOR

eugene,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

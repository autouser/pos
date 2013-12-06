package POS::View::TT;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    WRAPPER => 'layout/default.tt'
);

=head1 NAME

POS::View::TT - TT View for POS

=head1 DESCRIPTION

TT View for POS.

=head1 SEE ALSO

L<POS>

=head1 AUTHOR

eugene,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

package POS::Controller::CSV;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
}

sub import_file :Local {
  my ($self, $c) = @_;
  my $csv = $c->model('CSV');
  if ($c->req->upload('csv')) {
    if( $csv->convert($c->req->upload('csv')->fh) ) {
      $c->flash->{result} = 'Report was successfully generated.';
    } else {
      $c->flash->{errors} = $csv->errors;
    }
  } else {
    $c->flash->{errors} = ['Empty file']
  }
  $c->res->redirect($c->uri_for('/csv'));
}

__PACKAGE__->meta->make_immutable;

1;

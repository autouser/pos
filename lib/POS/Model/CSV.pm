package POS::Model::CSV;
use Moose;
use namespace::autoclean;
use Text::CSV;

extends 'Catalyst::Model';

has ctx => ( is => 'rw');
has valid => (is => 'rw', default => 1);
has errors => ( is => 'rw', isa => 'ArrayRef', default => sub {[]});

sub convert {
  my ($self, $fh) = @_;

  eval {
    my $csv = Text::CSV->new({allow_whitespace => 1});

    # discard headers
    $csv->getline($fh);

    # loop
    while (my $row = $csv->getline($fh)) {
      $row = $self->_validate_and_transform_row($row);
      my $hrow = _row2href($row);

      # Save customer
      my $customer = $self->ctx->model('POSDB::Customer')->find_or_create({
        id => $hrow->{c_id},
        first_name => $hrow->{c_first_name},
        last_name => $hrow->{c_last_name},
      });

      # Save item
      my $item = $self->ctx->model('POSDB::Item')->find_or_create({
        name => $hrow->{i_name},
        manufacturer => $hrow->{i_manufacturer}
      });

      # Save order
      my $order = $self->ctx->model('POSDB::Order')->find_or_create({
        id => $hrow->{o_id},
        created_at => $hrow->{o_date},
        customer_id => $customer->id,
        item_id => $item->id,
        price => $hrow->{i_price},
      });
    }

  };

  if ($@) {
    unless ($@ =~ /^validation/) {
      push @{$self->errors}, "Invalid CSV File: $@";
    }
    $self->valid(0)
  }

  $self->valid;
}

sub _row2href {
  my $row = shift;
  {
    o_date => $row->[0],
    c_id => $row->[1],
    c_first_name => $row->[2],
    c_last_name => $row->[3],
    o_id => $row->[4],
    i_name => $row->[5],
    i_manufacturer => $row->[6],
    i_price => $row->[7],
  }
}

sub _validate_and_transform_row {
  my ($self, $row) = @_;
  if (@$row != 8) {
    push @{$self->errors}, "Wrong number of fields";
    die "validation\n";
  }
  # Price
  if ($row->[7] =~ /(\d*\.\d+)/) {
    $row->[7] = 0 + $1;
  } else {
    push @{$self->errors}, "Wrong price '$row->[7]'";
    die "validation\n";
  }

  # Order date
  unless ($row->[0] =~ /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/) {
    push @{$self->errors}, "Wrong order date '$row->[0]'";
    die "validation";
  }

  $row;
}

sub ACCEPT_CONTEXT {
  my ($self, $c, @args) = @_;
  $self->ctx($c);
  $self;
}

__PACKAGE__->meta->make_immutable;

1;

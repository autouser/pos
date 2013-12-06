package POS::Schema::POSDB::ResultSet::Order;
use base 'DBIx::Class::ResultSet';

sub report {
  my ($self, $date) = @_;
  $self->search(
    \[ 'DATE(created_at) = ?', [ {} => $date ] ],
    {
      join => ['customer', 'item'],
      order_by => ['me.customer_id', 'me.id', 'me.item_id']
    });
}

sub report_text {
  my ($self, $date) = @_;
  my $records = [ $self->report($date) ];
  my $res = '';
  my $format = "| %-20s | %-10s | %-30s | %-10s |\n";
  my $sep = ('-' x 83)."\n";
  $res .= sprintf($format, 'CUSTOMER', 'ORDER ID', 'ITEM', 'PRICE');
  $res .= $sep;
  my $prev = undef;
  my $count = 0;
  my $sum = 0;
  for my $record (@$records) {
    $res .= $sep if defined $prev && $prev->customer_id != $record->customer_id;
    $res .= sprintf($format,
      ( defined $prev && $prev->customer_id == $record->customer_id ? '' : $record->customer->first_name.' '.$record->customer->last_name ),
      ( defined $prev && $prev->id == $record->id ? '' : $record->id),
      $record->item->name.' ('.$record->item->manufacturer.')',
      '$'.$record->price,
    );
    $prev = $record;
    $count += 1;
    $sum += $record->price;
  }
  $res .= $sep;
  $res .= sprintf($format, 'TOTAL', '', $count, '$'.$sum);
  $res;
}
1;
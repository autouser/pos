use strict;
use warnings;
use Test::More;


BEGIN { use_ok 't::test_db' }

use Test::WWW::Mechanize::Catalyst;
use POS::Controller::CSV;

my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'POS');

# Get index
$mech->get_ok("/csv", "get '/csv'");
$mech->title_is("POS Report", "valid /csv title");

# Submit valid CSV

$mech->field('csv', './t/data/orders.csv');
$mech->submit();

ok( $mech->success, 'post /csv/import_file');
$mech->content_contains("Report was successfully generated", "Correct CSV");

# Submit invalid CSV
$mech->get_ok("/csv", "get '/csv'");
$mech->field('csv', './t/data/wrong_data.csv');
$mech->submit();
$mech->content_contains("Wrong", "Invalid CSV");

# Submit no file
$mech->get_ok("/csv", "get '/csv'");
$mech->submit();
$mech->content_contains("Empty file", "Empty Submit");

done_testing();

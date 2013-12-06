use strict;
use warnings;

use POS;

my $app = POS->apply_default_middlewares(POS->psgi_app);
$app;


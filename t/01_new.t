use strict;
use warnings;
use Test::More tests => 1;

use Log::Buffered;

ok my $logger = Log::Buffered->new;

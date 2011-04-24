use strict;
use warnings;
use Test::More tests => 2;

use Log::Buffered;

ok my $logger = Log::Buffered->new;
isa_ok $logger, 'Log::Buffered';

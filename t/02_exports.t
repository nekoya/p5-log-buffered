use strict;
use warnings;
use Test::More;

use Log::Buffered;

my $logger = Log::Buffered->new;
is LOG_DEBUG, 'debug';
is LOG_INFO, 'info';
is LOG_NOTICE, 'notice';
is LOG_WARN, 'warn';
is LOG_ERROR, 'error';
is LOG_CRIT, 'crit';

done_testing;

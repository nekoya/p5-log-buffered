use strict;
use warnings;
use Test::More;

use Log::Buffered;

my $logger = Log::Buffered->new;
is LOG_DEBUG, $logger->LOG_DEBUG;
is LOG_INFO, $logger->LOG_INFO;
is LOG_NOTICE, $logger->LOG_NOTICE;
is LOG_WARN, $logger->LOG_WARN;
is LOG_ERROR, $logger->LOG_ERROR;
is LOG_CRIT, $logger->LOG_CRIT;

done_testing;

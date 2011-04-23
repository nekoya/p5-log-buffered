use strict;
use warnings;
use Test::More;

use Log::Buffered;

my $logger = Log::Buffered->new;
can_ok $logger, 'LOG_DEBUG';
can_ok $logger, 'LOG_INFO';
can_ok $logger, 'LOG_NOTICE';
can_ok $logger, 'LOG_WARN';
can_ok $logger, 'LOG_ERROR';
can_ok $logger, 'LOG_CRIT';

done_testing;

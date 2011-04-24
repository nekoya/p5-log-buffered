use strict;
use warnings;
use Test::More;

use Log::Buffered;

subtest "debug log" => sub {
    my $logger = Log::Buffered->new;

    is $logger->is_debug, 0, 'default, not in debug mode';
    $logger->debug('debug1');

    $logger->debug_on;
    is $logger->is_debug, 1, 'debug mode on';
    $logger->debug('debug2');

    $logger->debug_off;
    is $logger->is_debug, 0, 'debug mode off';
    $logger->debug('debug3');

    is_deeply $logger->{logs}, [
    { level => LOG_DEBUG, message => 'debug2' },
    ], 'assert logs';
};

subtest "instantiate with debug option" => sub {
    my $logger = Log::Buffered->new({ debug => 1 });
    is $logger->is_debug, 1, 'in debug mode';
};

done_testing;

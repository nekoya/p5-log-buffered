use strict;
use warnings;
use Test::More;

use Log::Buffered;

subtest "logging methods" => sub {
    my $logger = Log::Buffered->new;
    $logger->append('my first log', LOG_INFO);
    $logger->logging('second log', LOG_WARN);
    $logger->prepend('prepend log', LOG_NOTICE);

    is_deeply $logger->{logs}, [
    { level => LOG_NOTICE, message => 'prepend log' },
    { level => LOG_INFO, message => 'my first log' },
    { level => LOG_WARN, message => 'second log' },
    ], 'assert logs';
};

subtest "other level methods" => sub {
    my $logger = Log::Buffered->new;
    $logger->info('log info');
    $logger->notice('log notice');
    $logger->warn('log warn');
    $logger->error('log error');
    $logger->crit('log crit');

    is_deeply $logger->{logs}, [
    { level => LOG_INFO, message => 'log info' },
    { level => LOG_NOTICE, message => 'log notice' },
    { level => LOG_WARN, message => 'log warn' },
    { level => LOG_ERROR, message => 'log error' },
    { level => LOG_CRIT, message => 'log crit' },
    ], 'assert logs';
};

done_testing;

use strict;
use warnings;
use Test::More;

use Log::Buffered;

subtest "increase level" => sub {
    my $logger = Log::Buffered->new;
    $logger->debug_on;

    $logger->debug('log');
    is $logger->detect_max_level, LOG_DEBUG;

    $logger->info('log');
    is $logger->detect_max_level, LOG_INFO;

    $logger->info('log');
    is $logger->detect_max_level, LOG_INFO;

    $logger->notice('log');
    is $logger->detect_max_level, LOG_NOTICE;

    $logger->warn('log');
    is $logger->detect_max_level, LOG_WARN;

    $logger->error('log');
    is $logger->detect_max_level, LOG_ERROR;

    $logger->crit('log');
    is $logger->detect_max_level, LOG_CRIT;
};

subtest "deccrease level" => sub {
    my $logger = Log::Buffered->new;

    $logger->crit('log');
    is $logger->detect_max_level, LOG_CRIT;

    $logger->error('log');
    is $logger->detect_max_level, LOG_CRIT;

    $logger->warn('log');
    is $logger->detect_max_level, LOG_CRIT;

    $logger->notice('log');
    is $logger->detect_max_level, LOG_CRIT;

    $logger->info('log');
    is $logger->detect_max_level, LOG_CRIT;
};

done_testing;

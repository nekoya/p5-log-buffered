use strict;
use warnings;
use Test::More;

use Log::Buffered;

subtest "default setting" => sub {
    my $logger = Log::Buffered->new;
    is $logger->is_failed, 0, 'default';

    $logger->notice('notice');
    is $logger->is_failed, 0, 'notice';

    $logger->warn('warn');
    is $logger->is_failed, 1, 'warn';
};

subtest "custom fail level" => sub {
    my $logger = Log::Buffered->new({ failed => LOG_ERROR });
    $logger->warn('warn');
    is $logger->is_failed, 0, 'warn';
    $logger->error('error');
    is $logger->is_failed, 1, 'error';
};

done_testing;

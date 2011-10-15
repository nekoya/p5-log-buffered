use strict;
use warnings;
use Test::More;

use Log::Buffered;

subtest "logging methods" => sub {
    my $logger = Log::Buffered->new;
    $logger->append('my first log', LOG_INFO);
    $logger->logging('second log', LOG_WARN);
    $logger->prepend('prepend log', LOG_NOTICE);

    is $logger->to_str, <<'...';
[notice] prepend log
[info] my first log
[warn] second log
...
};

subtest "other level methods" => sub {
    my $logger = Log::Buffered->new;
    $logger->info('log info');
    $logger->notice('log notice');
    $logger->warn('log warn');
    $logger->error('log error');
    $logger->crit('log crit');

    is $logger->to_str, <<'...';
[info] log info
[notice] log notice
[warn] log warn
[error] log error
[crit] log crit
...
};

done_testing;

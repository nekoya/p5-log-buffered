use strict;
use warnings;
use Test::More;

use Log::Buffered;

use IO::Capture::Stdout;
use IO::Capture::Stderr;

subtest "stdout" => sub {
    my $logger = Log::Buffered->new({ stream => 1 });
    my $capture = IO::Capture::Stdout->new;
    $capture->start;
    $logger->info('testing');
    $logger->crit('critical error');
    $capture->stop;

    my $lines = [ $capture->read ];
    is_deeply $lines, [
    "[info] testing\n",
    "[crit] critical error\n",
    ];
};

subtest "stderr" => sub {
    my $logger = Log::Buffered->new({ stream => 2 });
    my $capture = IO::Capture::Stderr->new;
    $capture->start;
    $logger->info('testing');
    $logger->crit('critical error');
    $capture->stop;

    my $lines = [ $capture->read ];
    is_deeply $lines, [
    "[info] testing\n",
    "[crit] critical error\n",
    ];
};

done_testing;

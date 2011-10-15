use strict;
use warnings;
use Test::More;

use Log::Buffered;

my $logger = Log::Buffered->new;
$logger->info('log info');
$logger->notice('log notice');
$logger->warn('log warn');
$logger->error('log error');
$logger->crit('log crit');

my $expect =
"[info  ] log info
[notice] log notice
[warn  ] log warn
[error ] log error
[crit  ] log crit
";

is $logger->to_str, $expect, 'to_str';
is $logger->flush, $expect, 'flush';
is_deeply $logger->{logs}, [], 'all logs flushed';
is $logger->to_str, '', 'empty log str';

done_testing;

use inc::Module::Install;
name 'Log-Buffered';
all_from 'lib/Log/Buffered.pm';

requires 'Exporter::Lite';

author_tests('xt');

test_requires 'Test::More';
test_requires 'IO::Capture::Stdout';
test_requires 'IO::Capture::Stderr';

WriteAll;

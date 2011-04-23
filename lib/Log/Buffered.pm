package Log::Buffered;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp;
use Exporter::Lite;

our @EXPORT = qw(LOG_DEBUG LOG_INFO LOG_NOTICE LOG_WARN LOG_CRIT);
sub LOG_DEBUG  { 'debug' }
sub LOG_INFO   { 'info' }
sub LOG_NOTICE { 'notice' }
sub LOG_WARN   { 'warn' }
sub LOG_ERROR  { 'error' }
sub LOG_CRIT   { 'crit' }

sub new {
    my $class = shift;
    bless {}, $class;
}

1;
__END__

=head1 NAME

Log::Buffered - 

=head1 SYNOPSIS

    my $logger = Log::Buffered->new;

=head1 DESCRIPTION

B<Log::Buffered> 

=head1 METHODS

=over 4

=item new

=back

=head1 AUTHOR

Ryo Miyake E<lt>ryo.studiom {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

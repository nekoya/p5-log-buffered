package Log::Buffered;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp;

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

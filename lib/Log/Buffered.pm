package Log::Buffered;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp;
use Exporter::Lite;

our @EXPORT = qw(LOG_DEBUG LOG_INFO LOG_NOTICE LOG_WARN LOG_ERROR LOG_CRIT);
sub LOG_DEBUG  { 'debug' }
sub LOG_INFO   { 'info' }
sub LOG_NOTICE { 'notice' }
sub LOG_WARN   { 'warn' }
sub LOG_ERROR  { 'error' }
sub LOG_CRIT   { 'crit' }

sub new {
    my $class = shift;
    bless {
        logs => [],
        debug_mode => 0,
    }, $class;
}

sub debug_on  { $_[0]->{debug_mode} = 1 }
sub debug_off { $_[0]->{debug_mode} = 0 }

sub append {
    my $self = shift;
    push @{ $self->{logs} }, $self->_set_log(@_);
    shift; # return message
}
sub logging { shift->append(@_) }
sub prepend {
    my $self = shift;
    unshift @{ $self->{logs} }, $self->_set_log(@_);
    shift; # return message
}

sub debug  { $_[0]->append($_[1], 'debug') if $_[0]->{debug_mode} }
sub info   { $_[0]->append($_[1], 'info') }
sub notice { $_[0]->append($_[1], 'notice') }
sub warn   { $_[0]->append($_[1], 'warn') }
sub error  { $_[0]->append($_[1], 'error') }
sub crit   { $_[0]->append($_[1], 'crit') }

sub _set_log {
    my ($self, $message, $level) = @_;
    my $log = {
        level   => $level   || $self->LOG_INFO,
        message => $message || '',
    };
    $log;
}

sub to_str {
    my ($self) = @_;
    my @logs;
    for my $row (@{ $self->{logs} }) {
        push @logs, sprintf("[%s] %s", $row->{level}, $row->{message});
    }
    my $log = join("\n", @logs);
    $log ? "$log\n" : '';
}

sub flush {
    my ($self) = @_;
    my $log = $self->to_str;
    $self->{logs} = [];
    $log;
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

package Log::Buffered;
use strict;
use warnings;

our $VERSION = '0.01';

use Carp;
use Exporter::Lite;

our @EXPORT = qw(LOG_DEBUG LOG_INFO LOG_NOTICE LOG_WARN LOG_ERROR LOG_CRIT);
sub LOG_DEBUG  { 10 }
sub LOG_INFO   { 20 }
sub LOG_NOTICE { 30 }
sub LOG_WARN   { 40 }
sub LOG_ERROR  { 50 }
sub LOG_CRIT   { 60 }

our $LEVEL = {
    10 => 'debug',
    20 => 'info',
    30 => 'notice',
    40 => 'warn',
    50 => 'error',
    60 => 'crit',
};

sub new {
    my ($class, $args) = @_;
    bless {
        logs => [],
        debug_mode => $args->{debug} || 0,
        fail_criteria => $args->{failed} || LOG_WARN,
    }, $class;
}

sub debug_on  { $_[0]->{debug_mode} = 1 }
sub debug_off { $_[0]->{debug_mode} = 0 }
sub is_debug  { $_[0]->{debug_mode} }

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

sub debug  { $_[0]->append($_[1], $_[0]->LOG_DEBUG) if $_[0]->{debug_mode} }
sub info   { $_[0]->append($_[1], $_[0]->LOG_INFO) }
sub notice { $_[0]->append($_[1], $_[0]->LOG_NOTICE) }
sub warn   { $_[0]->append($_[1], $_[0]->LOG_WARN) }
sub error  { $_[0]->append($_[1], $_[0]->LOG_ERROR) }
sub crit   { $_[0]->append($_[1], $_[0]->LOG_CRIT) }

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
        push @logs, sprintf("[%s] %s", $LEVEL->{ $row->{level} }, $row->{message});
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

sub detect_max_level {
    my ($self) = @_;
    my $max = 0;
    for my $row (@{ $self->{logs} }) {
        $max = $row->{level} if $row->{level} > $max;
    }
    $max;
}

sub is_failed {
    my ($self) = @_;
    return ($self->detect_max_level >= $self->{fail_criteria}) ? 1 : 0;
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

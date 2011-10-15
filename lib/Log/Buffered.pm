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
        stream => $args->{stream} || 0,
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
    my $row = {
        level   => $level   || $self->LOG_INFO,
        message => $message || '',
    };
    if ($self->{stream}) {
        my $msg = $self->format_row($row) . "\n";
        if ($self->{stream} == 2) {
            print STDERR $msg;
        } else {
            print $msg;
        }
    }
    $row;
}

sub format_row {
    my ($self, $row) = @_;
    sprintf "[%s] %s", $LEVEL->{ $row->{level} }, $row->{message};
}

sub to_str {
    my ($self) = @_;
    my @logs;
    for my $row (@{ $self->{logs} }) {
        push @logs, $self->format_row($row);
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

Log::Buffered - Log buffering module

=head1 SYNOPSIS

    my $logger = Log::Buffered->new;
    $logger->info('information');
    $logger->warn('warning');
    print STDERR $logger->to_str if $logger->is_failed;

=head1 DESCRIPTION

B<Log::Buffered> is log buffering module. This module does not have function that publish log for any device (file, e-mail, etc.).

B<Log::Buffered> store all logs into the object. You can determine to use that logs when the application finished. For example, write logs to STDERR if any errors occurred.

=head1 METHODS

=over 4

=item new([\%options])

    $logger = Log::Buffered({ debug => 1, failed => LOG_ERROR });

debug: debug mode on.

failed: alert criteria for I<is_failed> method.

=item append($message, [$level])

Append log. Default level is I<LOG_INFO>.

=item logging($message, [$level])

This method is alias for I<append>.

=item prepend($message, [$level])

Prepend log.

=item info($message)

=item notice($message)

=item warn($message)

=item error($message)

=item crit($message)

Append log for each level.

=item debug($message)

Append debug log when debug mode on.

=item debug_on

=item debug_off

Debug mode on/off.

=item is_debug

Return debug mode is enabled or not.

=item to_str

Get all logs as strings.

=item flush

Flush all logs and return text by I<to_str>.

=item detect_max_level

Return max level of stored logs.

=item is_failed

Return that max log level is over alert criteria or not.

Default alert criteria is I<LOG_WARN>, you can specify that level by constructor's B<failed> option.

=back

=head1 AUTHOR

Ryo Miyake E<lt>ryo.studiom {at} gmail.comE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

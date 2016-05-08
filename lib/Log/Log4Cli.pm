package Log::Log4Cli;

use 5.006;
use strict;
use warnings;
use Term::ANSIColor "colored";
use parent "Exporter";

our $VERSION = '0.01'; # Don't forget to change in pod below
our @EXPORT = qw(log_fatal log_error log_warn log_info log_debug log_trace);

our $C = undef;
our $F = \*STDERR;
our $L = 0;
our $N = undef;

sub _pfx($$) {
    my ($S, $M, $H, $d, $m, $y) = localtime(time);
    my $pfx = sprintf "[%04i-%02i-%02i %02i:%02i:%02i %i %5s] ", $y + 1900, $m + 1, $d, $H, $M, $S, $$, shift;
    return (-t $F ? colored($pfx, shift) : $pfx) . (($N or $L > 5) ? join(":", (caller(1))[1,2]) . " " : "");
}

sub log_fatal(&) { print $F _pfx('FATAL', $C->{FATAL} || 'bold red'), $_[0]->($_), "\n" if $L > -2 }
sub log_error(&) { print $F _pfx('ERROR', $C->{ERROR} || 'red'),      $_[0]->($_), "\n" if $L > -1 }
sub log_warn(&)  { print $F _pfx('WARN',  $C->{WARN}  || 'yellow'),   $_[0]->($_), "\n" if $L >  0 }
sub log_info(&)  { print $F _pfx('INFO',  $C->{INFO}  || 'cyan'),     $_[0]->($_), "\n" if $L >  1 }
sub log_debug(&) { print $F _pfx('DEBUG', $C->{DEBUG} || 'blue'),     $_[0]->($_), "\n" if $L >  2 }
sub log_trace(&) { print $F _pfx('TRACE', $C->{TRACE} || 'magenta'),  $_[0]->($_), "\n" if $L >  3 }

1;

__END__

=head1 NAME

Log::Log4Cli -- Lightweight perl logger for command line tools

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use Log;

    $Log::C = { 'ERROR' => 'green' };   # redefine color for errors
    $Log::F = \*STDOUT                  # print to STDOUT (STDERR by default)
    $Log::L = 5;                        # loglevel
    $Log::N = 1;                        # force file:line indicators (also enables if loglevel > 5)

    log_error { "blah-blah, it's an error" };
    log_trace { "Guts:\n" . Dumper $struct }; # Dumper will be called only when TRACE level enabled

=head1 EXPORT

=head2 Subrotines exported by default:

=over 4

=item log_fatal log_error log_warn log_info log_debug log_trace

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2016 Michael Samoglyadov.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/> for more information.

=cut
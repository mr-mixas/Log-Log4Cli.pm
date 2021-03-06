# NAME

Log::Log4Cli -- Lightweight logger for command line tools

<a href="https://travis-ci.org/mr-mixas/Log-Log4Cli.pm"><img src="https://travis-ci.org/mr-mixas/Log-Log4Cli.pm.svg?branch=master" alt="CI"></a>
<a href='https://coveralls.io/github/mr-mixas/Log-Log4Cli.pm?branch=master'><img src='https://coveralls.io/repos/github/mr-mixas/Log-Log4Cli.pm/badge.svg?branch=master' alt='Coverage Status'></a>
<a href="https://badge.fury.io/pl/Log-Log4Cli"><img src="https://badge.fury.io/pl/Log-Log4Cli.svg" alt="CPAN version"></a>

# VERSION

Version 0.22

# SYNOPSIS

    use Log::Log4Cli;

    $Log::Log4Cli::COLORS->{DEBUG} = 'green'; # redefine color (Term::ANSIColor notation)
    $Log::Log4Cli::LEVEL = 4;                 # set loglevel
    $Log::Log4Cli::POSITIONS = 1;             # force file:line marks (also enables if loglevel > 4)

    log_fd(\*STDOUT);                         # print to STDOUT (STDERR by default)

    log_error { "blah-blah, it's an error" };

    $Log::Log4Cli::COLOR = 0;                 # now colors disabled

    my $guts = { some => "value" };
    log_trace {                               # block executed when appropriate level enabled only
        require Data::Dumper;
        return "Guts:\n" . Data::Dumper->Dump([$guts]);
    };

    die_info 'All done', 0;

# DESCRIPTION

Lightweight, but sufficient and user friendly logging for command line tools
with minimal impact on performance, optional configuration and no non-core
dependencies.

# EXPORT

All subroutines described below are exported by default.

# SUBROUTINES

## die\_fatal, die\_alert, die\_info

    die_fatal "Something terrible happened", 8;

Log message and exit with provided code. In eval blocks `Carp::croak` used
instead of exit(). All arguments are optional. If second arg (exit code)
omitted die\_fatal, die\_alert and die\_info will exit with `127`, `0` and `0`
respectively.

## log\_fatal, log\_error, log\_alert, log\_warn, log\_info, log\_debug, log\_trace

    log_error { "Something went wrong!" };

Execute passed code block and write it's return value if loglevel permit so. Set
`$Log::Log4Cli::COLOR` to false value to disable colors.

## log\_fd

Get/set file descriptor for log messages. `STDERR` is used by default.

# LOG LEVELS

Only builtin loglevels supported:

    FATAL       -1      'bold red',
    ERROR        0      'red',
    ALERT        0      'bold yellow',
    WARN         1      'yellow',
    INFO         2      'cyan',
    DEBUG        3      'blue',
    TRACE        4      'magenta'

Colors may be changed, see ["SYNOPSIS"](#synopsis). Default loglevel is `ERROR` (0).

# SEE ALSO

[Log::Dispatch](https://metacpan.org/pod/Log::Dispatch), [Log::Log4perl](https://metacpan.org/pod/Log::Log4perl)

[Term::ANSIColor](https://metacpan.org/pod/Term::ANSIColor)

# LICENSE AND COPYRIGHT

Copyright 2016-2018 Michael Samoglyadov.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See [http://dev.perl.org/licenses/](http://dev.perl.org/licenses/) for more information.

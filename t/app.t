#!perl

use strict;
use warnings;

use Test::More tests => 10;

use_ok('Module::Version::App');

my $app = Module::Version::App->new;

isa_ok( $app, 'Module::Version::App' );

{
    # check that error exists
    eval { $app->error('bwahaha') };

    ok(
        $@ =~ /^Error: bwahaha/,
        'error() ok',
    );
}

    # check functions are called
#
#{
#    # check that help prints help
#}
#
#{
#    # parse_args
#
#}

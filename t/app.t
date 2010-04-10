#!perl

use strict;
use warnings;

use Test::More;

eval 'use File::Temp';
$@ and plan skip_all => 'File::Temp is required to run these tests';

## TESTS ##
plan tests => 30;

use_ok('Module::Version::App');
my $app = Module::Version::App->new;
isa_ok( $app, 'Module::Version::App' );

{
    # check error()
    eval { $app->error('bwahaha') };

    ok(
        $@ =~ /^Error: bwahaha/,
        'error() ok',
    );
}

{
    # checking process()
    my @modules = qw( Test::More File::Temp Module::Version );
    $app->process(@modules);
    is_deeply(
        $app->{'modules'},
        \@modules,
        'process() ok',
    );
}

{
    my $run;
    $app->{'modules'} = ['Test::More'];
    $app->run();
    ok( $run, 'run() ok' );
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

#!perl

use strict;
use warnings;

use Test::More;

eval 'use File::Temp qw(tempfile)';
$@ and plan skip_all => 'File::Temp is required to run these tests';

eval 'use Test::Output';
$@ and plan skip_all => 'Test::Output is required to run these tests';

## TESTS ##
plan tests => 10;

use_ok('Module::Version::App');
my $app = Module::Version::App->new;
isa_ok( $app, 'Module::Version::App' );

{
    # check error()
    eval { $app->error('bwahaha') };
    ok( $@ =~ /^Error: bwahaha/, 'error() ok' );
}

{
    # check warn()
    my $sub = sub { $app->warn('bwahaha') };
    stderr_is( $sub, "Warning: bwahaha\n", 'warn() ok' );
}

{
    # check help()
    my $sub = sub { $app->help() };
    stdout_like( $sub, qr/\[ OPTIONS \] Module Module Module/, 'help() ok' );
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

my $run = sub { $app->run() };

{
    # check run() without input
    $app->{'modules'} = ['Test::More'];
    stdout_is( $run, "$Test::More::VERSION\n", 'run() ok - regular' );
}

{
    # check run() without modules or input
    delete $app->{'modules'};
    eval { $run->() };
    is( $@, "Error: no modules to check\n", 'run() ok - no modules or input' );
}

{
    # check run() with input
    # create temp file
    my ( $fh, $filename ) = tempfile();
    print {$fh} "Module::Version\n";
    $app->{'input'} = $filename;
    stdout_is( $run, "$Module::Version::VERSION\n", 'run() ok - with input' );
}

{
    # check parse()

1
}

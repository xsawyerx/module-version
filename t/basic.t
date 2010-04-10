#!perl

use strict;
use warnings;
use Test::More tests => 5;

use_ok( 'Module::Version', qw(get_version) );

my $version = get_version('Module::Version');

ok( $version, 'Got a version of ourselves' );
ok( $version gt '0.01', 'It is greater than 0.01' );

eval { $version = get_version('ThisModuleDoesntExistaaaa') };

ok( ! $@,       'No crash when module does not exist' );
ok( ! $version, 'No version either'                   );


package Module::Version;

use strict;
use warnings;

use base 'Exporter';
use Carp;
use ExtUtils::MakeMaker;

our $VERSION   = '0.03';
our @EXPORT_OK = 'get_version';

sub get_version {
    my $module = shift or croak 'Must get a module name';
    my $file   = MM->_installed_file_for_module($module);

    $file || return;

    return MM->parse_version($file)
}

1;

__END__

=head1 NAME

Module::Version - Get module versions

=head1 VERSION

Version 0.03

=head1 SYNOPSIS

This module fetches the version of any other module.

It comes with a CLI program C<module-version> which does the same.

    use Module::Version 'get_version';

    print get_version('Search::GIN'), "\n";

Or using C<module-version>:

    $ module-version Search::GIN
    0.04

    $ module-version Doesnt::Exist
    Warning: module 'Doesnt::Exist' does not seem to be installed.

    $ module-version --quiet Doesnt::Exist
    (no output)

    $ module-version --full Search::GIN Moose
    Search::GIN 0.04
    Moose 1.01

    $ module-version --input modules.txt
    Search::GIN 0.04
    Data::Collector 0.03
    Moose 1.01

=head1 EXPORT

=head2 get_version

C<get_version> will be exported if explicitly specified.

    use Module::Version 'get_version';

B<Nothing> is exported by default.

=head1 SUBROUTINES/METHODS

=head2 get_version

Accepts a module name and fetches the version of the module.

If the module doesn't exist, returns undef.

=head1 AUTHOR

Sawyer X, C<< <xsawyerx at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-module-version at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Module-Version>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Module::Version

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Module-Version>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Module-Version>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Module-Version>

=item * Search CPAN

L<http://search.cpan.org/dist/Module-Version/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Sawyer X.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


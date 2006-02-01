#	$Id: Storable.pm,v 1.1.1.1 2006-02-01 21:46:33 adam Exp $

=head1 NAME

Config::Trivial::Storable - Very simple tool for reading and writing very simple Storable configuration files

=head1 SYNOPSIS

  use Config::Trivial::Storable;
  my $config = Config::Trivial::Storable->new(config_file => "path/to/my/config.conf");
  my $settings = $config->read;
  print "Setting Colour is:\t", $settings->{'colour'};
  $settings->{'new-item'} = "New Setting";
  $settings->store;

=head1 DESCRIPTION

Use this module when you want use "Yet Another" very simple, light
weight configuration file reader. The module extends Config::Trivial
by providing Storable Support. See that module for more details.

=cut

package Config::Trivial::Storable;

use base qw( Config::Trivial );

use 5.006;
use strict;
use warnings;
use Carp;
use Storable qw(lock_store lock_retrieve);

our $VERSION = "0.10";
my ($_package, $_file) = caller;

#
#	STORE
#

=head2 store

The store method outputs a storable binary version of the configuration
rather than a plain text version that the write version would.

There are two optional parameters that can be passed, a file
name to use instead of the current one, and a reference of a
hash to write out instead of the currently loaded one.

  $config->store(
    file_name => "/path/to/somewhere/else",
    configuration => $settings);

The method returns true on success. If the file already exists
then it is backed up first. The write is not "atomic" or
locked for reading in anyway. If the file cannot be written to
then it will die.

Configuration data passed by this method is only written to
file, it is not stored in the internal configuration object.
To store data in the internal use the set_configuration data
method. The option to pass a hash_ref in this method may
be removed in future versions.

=cut

sub store {
	my $self = shift;
	my %args = @_;

	my $file = $args{"config_file"} || $self->{_config_file};
	if (($_file eq $file) ||
		($0 eq $file)) {
			return $self->_raise_error("Not allowed to write to the calling file.")
		};

	if (-e $file) {
		croak "ERROR: Insufficient permissions to write to: $file" unless (-w $file);
		rename $file, $file.$self->{_backup_char} or croak "ERROR: Unable to rename $file.";
	}

	my $settings = $args{"configuration"} || $self->{_configuration};

	lock_store $settings, $file;

	return 1;
}


#
#	RETRIEVE
#  

=head2 retrieve

This is the analog to read, only it reads data from a storable binary.

  $config->retrieve;

=cut

sub retrieve {
	my $self = shift;
	my $key  = shift;			# If there is a key, return only it's value

	return undef unless $self->_check_file($self->{_config_file});

	my $retrieved_hash_ref = lock_retrieve($self->{_config_file});

	return undef unless $retrieved_hash_ref;

	$self->{_configuration} = $retrieved_hash_ref; 

	return $self->{_configuration}->{$key} if $key;
	return $self->{_configuration};
}

1;

__END__

=head1 CONFIG FORMAT

=head2 About The Configuration File Format

This module extends C<Config::Trivial> with optional support for using
Storable binaries as a configuration file format, rather than plain
text files.

The format of the text files is as with C<Config::Trivial> and remains
unchanged, as this module inherits from that one. The Storable format
is offerd so that modules can simple "retrieve" their configuration
without the use of any particular configuration module.

This module extends C<Config::Trivial> so that they can be used to quickly
read configuration in one format and convert to another.

=head1 MISC

=head2 Prerequisites

At the moment the module only uses core modules, plus C<Config::Trivial>
The test suite optionally uses C<POD::Coverage> and C<Test::Pod>, which
will be skipped if you don't have them.

=head2 History

See Changes file.

=head2 Defects and Limitations

Patches Welcome... ;-)

=head1 EXPORT

None.

=head1 AUTHOR

Adam Trickett, E<lt>atrickett@cpan.orgE<gt>

=head1 SEE ALSO

L<perl>, L<Config::Trivial>.

=head1 COPYRIGHT

This version as C<Config::Trivial::Storable>, Copyright iredale consulting 2006

OSI Certified Open Source Software.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published
by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details. 

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111, USA.

=cut

#	$Id: 05-store.t,v 1.2 2006-02-05 18:01:22 adam Exp $

use strict;
use Test;
BEGIN { plan tests => 34 }

use Config::Trivial::Storable;

ok(1);

#
#	Basic Constructor (2-5)
#
ok(my $config = Config::Trivial::Storable->new(
	config_file => "./t/test.data"));			# Create Config object
ok($config->read);								# Read it in
ok($config->store(
	config_file => "./t/test2.data"));			# Write it out
ok(-e "./t/test2.data");						# Was written out

#
#	Create New (6-7)
#

$config = Config::Trivial::Storable->new();
my $data = {test => "womble"};					# New Data
ok($config->store(
	config_file => "./t/test3.data",		
	configuration => $data));					# Write it too
ok(-e "./t/test3.data");

#
#	Read things back (8-19)
#

ok($config = Config::Trivial::Storable->new(
    config_file => "./t/test2.data"));          # Create Config object
ok($data = $config->retrieve);
ok($data->{test1}, "foo");
ok($data->{test3}, "baz");
ok($config->write);								# write it back (should make a backup)
ok(-e "./t/test2.data~");

ok($config = Config::Trivial::Storable->new(
    config_file => "./t/test3.data"));          # Create Config object
ok($config->retrieve("test"), "womble");        # Retrive a single value

ok($config = Config::Trivial::Storable->new);       # New empty setting 
ok($config->set_storable_file("./t/test3.data"));   # Manuall set the storefile
ok($config->{_storable_file}, "./t/test3.data");
ok($config->retrieve("test"), "womble");            # Get the file using the storefile

#
#   Magic reading ... (20-29)
#

sleep (2);                                          # Ensure config file is younger than storeable 

$data = {test => "bulgaria"};                       # New Data
ok(! -e "./t/test4.data");
ok($config->write(
    config_file => "./t/test4.data",
    configuration => $data));
ok(-e "./t/test4.data");                            # Text Data saved okay

ok($config = Config::Trivial::Storable->new(
    config_file => "./t/test.data"));               # Create Config object (text version)
ok($config->set_storable_file("./t/test3.data"));   # Manually set the storefile
ok($config->retrieve("test"), "womble");            # Get the file using the storefile
ok($config->set_config_file("./t/test4.data"));     # Manually set the storefile
ok($config->{_storable_file}, "./t/test3.data");    # The Storable file
ok($config->{_config_file}, "./t/test4.data");      # The Config file
ok($config->retrieve("test"), "bulgaria");          # Get the file using the storefile


#
#	Make sure we clean up (30-34)
#
ok(unlink("./t/test2.data", "./t/test2.data~", "./t/test3.data", "./t/test4.data"), 4);
ok(! -e "./t/test2.data");						# Deleted test2.data okay
ok(! -e "./t/test2.data~");						# Deleted test2.data~ okay
ok(! -e "./t/test3.data");						# Deleted test3.data okay
ok(! -e "./t/test4.data");						# Deleted test4.data okay

__DATA__

foo bar

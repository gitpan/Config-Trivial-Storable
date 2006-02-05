#	$Id: 03-error.t,v 1.3 2006-02-05 18:01:22 adam Exp $
use strict;
use Test;

BEGIN { plan tests => 34 };

use Config::Trivial::Storable;
ok(1);

#
#	Basic Constructor
#
my $config = Config::Trivial::Storable->new;

# Try and write to self (by default) (2-5)
ok(! $config->write );
ok($config->get_error(), "Not allowed to write to the calling file.");

ok(! $config->store );
ok($config->get_error(), "Not allowed to store to the calling file.");

# Missing file (6-7)
ok(! $config->set_config_file("./t/file.that.is.not.there")); 
ok($config->get_error(), "File error: Cannot find ./t/file.that.is.not.there");

# Not a file (8-9)
ok(! $config->set_config_file("./t"));
ok($config->get_error(), "File error: ./t isn't a real file");

# Empty filename (10-11)
ok(! $config->set_config_file(""));
ok($config->get_error(), "File error: No file name supplied");

# Empty file (12-13)
ok(! $config->set_config_file("./t/empty"));
ok($config->get_error(), "File error: ./t/empty is zero bytes long");

# write to self (explicit) (14-17)
$config->set_config_file($0);
ok(! $config->write );
ok($config->get_error(), "Not allowed to write to the calling file.");

ok(! $config->store );
ok($config->get_error(), "Not allowed to store to the calling file.");

# duped keys, normal mode (18-20)
ok($config->set_config_file("./t/bad.data"));
ok(my $settings = $config->read());
ok($settings->{test1}, "bar");

# setting not a hash_ref (21-22)
ok(! $config->set_configuration("foo"));
ok($config->get_error(), "Configuration data isn't a hash reference");

$settings = undef;
$config = Config::Trivial::Storable->new(strict => "on");

# Try and write to self (23-24)
eval { $config->write };
ok($@ =~ "Not allowed to write to the calling file.");

eval { $config->store };
ok($@ =~ "Not allowed to store to the calling file.");

# duped keys, strict mode (25-27)
ok($config->set_config_file("./t/bad.data"));
eval { $settings = $config->read(); };
ok(! defined($settings->{test1}));
ok($@ =~ 'ERROR: Duplicate key "test1" found in config file on line 5');

# Missing File, Strict mode (28)
eval { $config->set_config_file("./t/file.that.is.not.there"); };
ok($@ =~ "File error: Cannot find ./t/file.that.is.not.there");

# Empty file, Strict mode (29)
eval { $config->set_config_file("./t/empty"); };
ok($@ =~ "File error: ./t/empty is zero bytes long");

# write to self, Strict mode (30-32)
$config->set_config_file($0);
eval { $config->write };
ok($@ =~ "Not allowed to write to the calling file.");

eval { $config->retrieve };
ok($@ =~ "Can't retrieve store from the calling file.");

#print STDERR "\n\n $@ \n\n";

eval { $config->store };
ok($@ =~ "Not allowed to store to the calling file.");

# setting not a hash_ref, Strict mode (33)
eval { $config->set_configuration("foo"); };
ok($@ =~ "Configuration data isn't a hash reference");

# Try and read the wrong kind of files (34)
$config->set_config_file("./t/test.data");
eval { $config->retrieve };
ok($@ =~ "ERROR: File is not a perl storable");

# Try and read from self (34)


exit;

__END__

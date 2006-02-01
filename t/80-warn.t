#	$Id: 80-warn.t,v 1.1.1.1 2006-02-01 21:46:33 adam Exp $

use strict;
use Test;
use IO::Capture::Stderr;
BEGIN { plan tests => 7 };

use Config::Trivial::Storable;
ok(1);

my $capture = IO::Capture::Stderr->new();

#
#	Test Warnings
#
my $config = Config::Trivial::Storable->new(debug => "on");
ok($config);

# duped keys, strict mode (3-5)
ok($config->set_config_file("./t/bad.data"));
$capture->start;
my $settings = $config->read();
$capture->stop;
ok(defined($settings->{test1}));
ok($capture->read =~ /WARNING: Duplicate key "test1" found in config file on line 5 at t\/07-warn\.t line 22/);

# Missing File (6)
$capture->start;
$config->set_config_file("./t/file.that.is.not.there");
$capture->stop;
ok($capture->read =~ /File error: Cannot find \.\/t\/file\.that\.is\.not\.there at t\/07-warn\.t line 29/);

# Empty file, Strict mode (7)
$capture->start;
$config->set_config_file("./t/empty");
$capture->stop;
ok($capture->read =~ /File error: \.\/t\/empty is zero bytes long at t\/07-warn\.t line 35/);

exit;

__END__

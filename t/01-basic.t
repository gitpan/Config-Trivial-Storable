#	$Id: 01-basic.t,v 1.1.1.1 2006-02-01 21:46:33 adam Exp $

use strict;
use Test;
BEGIN { plan tests => 4 }

use Config::Trivial::Storable;

ok(1);
ok($Config::Trivial::Storable::VERSION, "0.10");

my $config = Config::Trivial::Storable->new;
ok(defined $config);
ok($config->isa('Config::Trivial::Storable'));

exit;
__END__

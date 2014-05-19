#   $Id: 01-basic.t 57 2014-05-19 19:17:51Z adam $

use strict;
use Test;
BEGIN { plan tests => 4 }

use Config::Trivial::Storable;

ok(1);
ok($Config::Trivial::Storable::VERSION, "0.31_2");

my $config = Config::Trivial::Storable->new;
ok(defined $config);
ok($config->isa('Config::Trivial::Storable'));

exit;
__END__

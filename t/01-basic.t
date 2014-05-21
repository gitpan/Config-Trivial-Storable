#   $Id: 01-basic.t 64 2014-05-21 22:34:42Z adam $

use strict;
use Test::More tests => 4;

BEGIN { use_ok( 'Config::Trivial::Storable' ); }

is( $Config::Trivial::Storable::VERSION, "0.31_3", 'Version Check' );

my $config = Config::Trivial::Storable->new;
ok(defined $config, 'Object is defined' );
isa_ok( $config, 'Config::Trivial::Storable', 'Oject/Class Check' );

exit;
__END__

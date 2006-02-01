#	$Id: 91-pod.t,v 1.1.1.1 2006-02-01 21:46:33 adam Exp $

use strict;
use Test;
use Pod::Coverage;

plan tests => 1;

my $pc = Pod::Coverage->new(package => 'Config::Trivial::Storable');
ok($pc->coverage == 1);

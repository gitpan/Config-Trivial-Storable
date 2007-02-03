use strict;
use Test;
use YAML qw/LoadFile/;
BEGIN { plan tests => 1 }

ok(LoadFile('./META.yml'));

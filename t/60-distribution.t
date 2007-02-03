#   $Id: 60-distribution.t,v 1.1 2007-02-03 15:23:30 adam Exp $

use Test::More;
BEGIN {
    eval { require Test::Distribution; };
    if($@) {
        plan skip_all => 'Test::Distribution not installed';
    }
    else {
        import Test::Distribution;
    }
};

#	$Id: 92-pod.t,v 1.1.1.1 2006-02-01 21:46:33 adam Exp $

use strict;
use Test::Pod::Coverage tests=>1;
pod_coverage_ok( "Config::Trivial", "Config::Trivial is covered" );

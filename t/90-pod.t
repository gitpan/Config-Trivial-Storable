#	$Id: 90-pod.t,v 1.1.1.1 2006-02-01 21:46:33 adam Exp $

use strict;
use Test::More tests => 1;
use Test::Pod;

pod_file_ok("./lib/Config/Trivial/Storable.pm", "Valid POD file" );


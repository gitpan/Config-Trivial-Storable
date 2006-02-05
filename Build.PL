#	$Id: Build.PL,v 1.2 2006-02-02 19:11:17 adam Exp $;

use Module::Build;

my @tests = qw(t/00-use.t t/01-basic.t t/02-read.t t/03-error.t t/04-write.t t/05-store.t);

eval { require IO::Capture; };
push @tests, 't/80-warn.t' unless ($@);

eval { require Test::Pod; };
push @tests, 't/90-pod.t' unless ($@);

eval { require Pod::Coverage; };
push @tests, 't/91-pod.t' unless ($@);

eval { require Test::Pod::Coverage; };
push @tests, 't/92-pod.t' unless ($@);

my $build = Module::Build->new(
	module_name => 'Config::Trivial::Storable',
	license     => 'gpl',
	test_files  => \@tests,
	requires    => {
		'perl'  			=> '5.6.1',
		'Storable'			=> '2.0',
		'Config::Trivial'	=> '0.51',
	},
);

$build->create_build_script;

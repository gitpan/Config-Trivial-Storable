#   $Id: Build.PL 59 2014-05-19 19:29:27Z adam $;

use Module::Build;

my $build = Module::Build->new(
    module_name => 'Config::Trivial::Storable',
    license     => 'gpl',
    requires    => {
        'perl'              => '5.010',
        'Storable'          => '2.24',
        'Config::Trivial'   => '0.60',
        'Module::Build'     => '0.40',
    },
    build_requires => {
        'IO::Capture'   => 0,
        'Test::Pod'     => 0,
        'Test::More'    => 0,
        'Pod::Coverage' => 0,
        'YAML'          => 0,
        'Test::Pod::Coverage'   => 0,
    },
);

$build->create_build_script;

use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Factory;
my $CLASS = 'Plantuml::Factory';

BEGIN { use_ok 'Plantuml::Factory'};

my $fixtures = +[
    +{
        string => 'foo()',
        expect => 'Plantuml::Method',
        description => 'normal method',
    },
    +{
        string => '{static} foo()',
        expect => 'Plantuml::Method',
        description => 'static method',
    },
    +{
        string => '{abstract} foo()',
        expect => 'Plantuml::Method',
        description => 'abstract method',
    },
    +{
        string => 'foo',
        expect => 'Plantuml::Variable',
        description => 'normal variable',
    },
];

subtest "create" => sub {
    for my $fixture (@$fixtures){
        my $got = $CLASS->create($fixture->{string});
        is ($got, $fixture->{expect}, $fixture->{description});
    }
};

done_testing;

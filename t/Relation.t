use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Relation;

my $CLASS = 'Plantuml::Relation';
BEGIN { use_ok $CLASS };

subtest "<|--" => sub {
    my $fixture = 'Left <|-- Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'generalization', 'relation name');
    is ($relation->from, 'Right', 'from');
    is ($relation->from, 'Left', 'to');
};

subtest "<|.." => sub {
    my $fixture = 'Left <|.. Right';
};

subtest "*.." => sub {
    my $fixture = 'Left *.. Right';
};

subtest "--|>" => sub {
    my $fixture = 'Left --|> Right';
};

subtest "..|>" => sub {
    my $fixture = 'Left ..|> Right';
};

subtest "..*" => sub {
    my $fixture = 'Left ..* Right';
};


done_testing;

use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Relation;

my $CLASS = 'Plantuml::Relation';
BEGIN { use_ok 'Plantuml::Relation' };

subtest "<|-- generalization" => sub {
    my $fixture = 'Left <|-- Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'generalization', 'relation name');
    is ($relation->get_from, 'Right', 'from');
    is ($relation->get_to, 'Left', 'to');
};

subtest "--|> generalization" => sub {
    my $fixture = 'Left --|> Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'generalization', 'relation name');
    is ($relation->get_from, 'Left', 'from');
    is ($relation->get_to, 'Right', 'to');
};


subtest "<|.. realization" => sub {
    my $fixture = 'Left <|.. Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'realization', 'relation name');
    is ($relation->get_from, 'Right', 'from');
    is ($relation->get_to, 'Left', 'to');
};

subtest "o-- aggregation" => sub {
    my $fixture = 'Left o-- Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'aggregation', 'relation name');
    is ($relation->get_from, 'Right', 'from');
    is ($relation->get_to, 'Left', 'to');
};

subtest "--o aggregation" => sub {
    my $fixture = 'Left --o Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'aggregation', 'relation name');
    is ($relation->get_from, 'Left', 'from');
    is ($relation->get_to, 'Right', 'to');
};

subtest "*-- composite" => sub {
    my $fixture = 'Left *-- Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'composite', 'relation name');
    is ($relation->get_from, 'Right', 'from');
    is ($relation->get_to, 'Left', 'to');
};

subtest "--* composite" => sub {
    my $fixture = 'Left --* Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'composite', 'relation name');
    is ($relation->get_from, 'Left', 'from');
    is ($relation->get_to, 'Right', 'to');
};

subtest "<-- association " => sub {
    my $fixture = 'Left <-- Right';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'association', 'relation name');
    is ($relation->get_from, 'Right', 'from');
    is ($relation->get_to, 'Left', 'to');
};

subtest "extract class name" => sub {
    my $fixture = 'Plantuml <|-- Plantuml::Class';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'generalization', 'relation name');
    is ($relation->get_from, 'Plantuml::Class', 'from');
    is ($relation->get_to, 'Plantuml', 'to');
};

subtest "with arrow direction" => sub {
    my $fixture = 'Plantuml <|-up- Plantuml::Class';

    my $relation = $CLASS->build($fixture);
    is ($relation->get_name, 'generalization', 'relation name');
    is ($relation->get_from, 'Plantuml::Class', 'from');
    is ($relation->get_to, 'Plantuml', 'to');
};

done_testing;

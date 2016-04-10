use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Relation;
use Plantuml::Class::Variable;
use Plantuml::Class::Method;
use t::Util qw/load_fixture/;

my $CLASS = 'Plantuml::Class';
BEGIN { use_ok 'Plantuml::Class' };

subtest "private_methods" => sub {
    subtest "_get_class_name" => sub {
        my $string = 'class Plantuml::Class {';
        my $expect = 'Plantuml::Class';
        is ($CLASS->_get_class_name($string), $expect, 'short class name');

        $string = 'class Plantuml::Class::Foo::Long::Long {';
        $expect = 'Plantuml::Class::Foo::Long::Long';
        is ($CLASS->_get_class_name($string), $expect, 'Long class name');

        $string = 'class Plantuml::Class << D >> {';
        $expect = 'Plantuml::Class';
        is ($CLASS->_get_class_name($string), $expect, 'class name with specific spot');
    };

    subtest "_get_class_attribute" => sub {
        my $class_line = 'class Plantuml::Class {';
        is ($CLASS->_get_class_attribute($class_line), '', 'normal class');

        my $abstract_class_line = 'abstract class Plantuml::Class {';
        is ($CLASS->_get_class_attribute($abstract_class_line), 'abstract', 'abstract class');
    };

    subtest "_get_relations" => sub {
        my $class_name = 'Foo';
        my $relative_relation = Plantuml::Relation->new('generalization', $class_name, 'Bar'); # Bar <|-- Foo
        my $not_relative_relation = Plantuml::Relation->new('composite', 'Hoge', 'Baz'); # Baz *-- Hoge
        my $relations = +[
            $relative_relation,
            $not_relative_relation,
        ];
        my $expect = +[$relative_relation];
        is_deeply ($CLASS->_get_relations($class_name, $relations), $expect);
    };
};

subtest "public methods" => sub {
    my $fixture = load_fixture('class.pu');
    my $class_name = 'Plantuml::Class'; # should be same as fixture class name
    my $generalization_relations = Plantuml::Relation->new('generalization', $class_name, 'Plantuml');
    my $composite_relations = Plantuml::Relation->new('composite', 'Hoge', $class_name);
    my $relations = +[
        $generalization_relations,
        $composite_relations,
    ];

    my $class_instance = $CLASS->build($fixture, $relations);

    subtest "build" => sub {
        is ($class_instance->get_name, $class_name, 'class name');
        is ($class_instance->get_attribute, 'abstract', 'class attribute');
        is_deeply ($class_instance->get_variables, +[
            Plantuml::Class::Variable->new('name'),
            Plantuml::Class::Variable->new('attribute'),
            Plantuml::Class::Variable->new('variables'),
            Plantuml::Class::Variable->new('methods'),
            Plantuml::Class::Variable->new('relations'),
        ], 'class variables');
        is_deeply ($class_instance->get_methods, +[
            Plantuml::Class::Method->new('build', 'static'),
            Plantuml::Class::Method->new('get_parents'),
        ], 'class metdhos');
        is_deeply ($class_instance->get_relations, $relations, 'class relations');
    };

    subtest "get_parents" => sub {
        is_deeply ($class_instance->get_parents(), +['Plantuml'], 'get_parents');
    };
};

done_testing;

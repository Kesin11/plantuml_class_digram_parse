use strict;
use warnings;
use utf8;
use Test::More;
use PlantUML::ClassDiagram::Parse;
use t::Util qw/load_fixture/;

my $CLASS = 'PlantUML::ClassDiagram::Parse';
BEGIN { use_ok 'PlantUML::ClassDiagram::Parse' };

my $fixture = load_fixture('all.pu');

subtest "parse()" => sub {
    my $parser = $CLASS->parse($fixture);

    subtest "_extract_class_strings()" => sub {
        my $expect_classes = +[
'class Base {
}',
'class Main {
  run()
}',
'class PlantUML::ClassDiagram::Parse {
  classes
  relations
  {static} parse()
  _extract_class_strings()
  _extract_relation_strings()
}',
'class PlantUML::ClassDiagram::Class::Factory {
  {static} create()
  _check_is_method()
  _check_is_variable()
}',
'class PlantUML::ClassDiagram::Class {
  attribute
  parents
  variables
  methods
  build()
}',
'abstract class PlantUML::ClassDiagram::Class::Base {
  name
  attribute
  build()
}',
'class PlantUML::ClassDiagram::Class::Variable {
  name
  attribute
  build()
}',
'class PlantUML::ClassDiagram::Class::Method {
  name
  attribute
  build()
}',
'class PlantUML::ClassDiagram::Relation {
  from
  to
  name
  build()
}',
        ];
        is_deeply($parser->get_classes, $expect_classes);
    };

    subtest "_extract_relation()" => sub {
        my $expect = +[
    'Class *-- Class::Variable',
    'Class *-- Class::Method',
    'Class <-- Relation',
    'Class::Factory <-- Class',
    'Class::Factory ..|> Class::Variable',
    'Class::Factory ..|> Class::Method',
    'Class::Variable -down-|> Class::Base',
    'Class::Method   -down-|> Class::Base',
        ];
        is_deeply($CLASS->_extract_relation_strings($fixture), $expect);
    };
};


done_testing;

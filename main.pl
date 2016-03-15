use strict;
use warnings;
use utf8;

use File::Spec;
use File::Basename;
use lib File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), ''));

use Plantuml::Parser;
use Plantuml::Relation;
use Plantuml::Class;

main();

sub main {

    my $text = _slurp('self_class_diagram.pu');
    my $parser = Plantuml::Parser->parse($text);
    my $class_strings = $parser->get_classes;
    my $relation_strings = $parser->get_relations;
    my $relations = +[ map { Plantuml::Relation->build($_) } @$relation_strings ];
    my $classes = +[ map { Plantuml::Class->build($_) } @$class_strings ];

    use Data::Dumper; warn Dumper $classes;
    use Data::Dumper; warn Dumper $relations;

    use Data::Dumper; warn Dumper "parents:";
    for my $class (@$classes){
        use Data::Dumper; warn Dumper $class->get_name ,$class->get_parents();
    }

}

sub _slurp {
    my $fname = shift;
    open my $fh, '<:encoding(UTF-8)', $fname or die "$fname: $!";
    do { local $/; <$fh> };
}

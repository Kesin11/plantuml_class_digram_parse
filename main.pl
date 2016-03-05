use strict;
use warnings;
use utf8;

use File::Spec;
use File::Basename;
use lib File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__), ''));

use Plantuml::Parser;

main();

my $fh;
my $string;

sub main {

    my $text = _slurp('self_class_diagram.pu');
    my $parser = Plantuml::Parser->parse($string);
    use Data::Dumper; warn Dumper $parser->get_classes;
    use Data::Dumper; warn Dumper $parser->get_relations;
}

sub _slurp {
    my $fname = shift;
    open my $fh, '<:encoding(UTF-8)', $fname or die "$fname: $!";
    do { local $/; <$fh> };
}

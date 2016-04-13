package PlantUML::ClassDiagram::Parser;

use strict;
use warnings;
use utf8;

use parent qw/Class::Accessor::Fast/;
__PACKAGE__->follow_best_practice;

my @self_valiables = qw/
classes
relations
/;
__PACKAGE__->mk_ro_accessors(@self_valiables);

sub new {
    my ($class, $class_strings, $relation_strings) = @_;
    my $attr = +{
        classes   => $class_strings,
        relations => $relation_strings,
    };
    return $class->SUPER::new($attr);
}

sub parse {
    my ($class, $text) = @_;

    my $filtered_text    = $class->_remove_commentout($text);
    my $class_strings    = $class->_extract_class_strings($filtered_text);
    my $relation_strings = $class->_extract_relation_strings($filtered_text);

    return $class->new($class_strings, $relation_strings);
}

sub _remove_commentout {
    my ($class, $string) = @_;

    $string =~ s/\/'.*?'\///sg;
    return $string;
}

sub _extract_class_strings {
    my ($class, $string) = @_;

    my @class_strings = $string =~ /(?:abstract\s+)*class.*?{.*?\n}/sg; # '\n}' for capture nest bracket
    return \@class_strings;
}

sub _extract_relation_strings {
    my ($class, $string) = @_;

    my $relation_strings = +[];
    my @lines = split('\n', $string);
    for my $line (@lines){
        # *- , <- , <|- , <|.
        if ($line =~ /(\*|<)\|?(-|\.)/) {
            push(@$relation_strings, $line);
        # -* , -> , -|> , .|>
        } elsif ($line =~ /(-|\.)\|?(\*|>)/) {
            push(@$relation_strings, $line);
        }
    }

    chomp $_ for @$relation_strings;
    return $relation_strings;
}


1;

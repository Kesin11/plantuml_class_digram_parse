package Plantuml::Parser;

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
    my ($class, $string) = @_;
    my $attr = +{};
    return $class->SUPER::new($attr);
}

sub parse {
    my ($class, $string) = @_;

    return $class->new();
}

sub _extract_class {
    my ($class, $string) = @_;

    my @class_strings = $string =~ /class.*?{.*?}/sg;
    return \@class_strings;
}

sub _extract_relation {
    my ($class, $string) = @_;

    my $relation_strings = +[];
    my @lines = split('\n', $string);
    for my $line (@lines){
        # *-- , <-- , <|-- , <|..
        if ($line =~ /(\*|<)\|?(--|\.\.)/) {
            push(@$relation_strings, $line);
        # --* , --> , --|> , ..|>
        } elsif ($line =~ /(--|\.\.)\|?(\*|>)/) {
            push(@$relation_strings, $line);
        }
    }

    chomp $_ for @$relation_strings;
    return $relation_strings;
}


1;

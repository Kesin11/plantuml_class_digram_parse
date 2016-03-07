package Plantuml::Method;

use strict;
use warnings;
use utf8;

use parent qw/Class::Accessor::Fast/;
__PACKAGE__->follow_best_practice;

my @self_valiables = qw/
name
attribute
/;
__PACKAGE__->mk_ro_accessors(@self_valiables);

sub new {
    my ($class, $name, $attribute) = @_;
    my $attr = +{
        name => $name || '',
        attribute => $attribute || '',
    };
    return $class->SUPER::new($attr);
}

sub build {
    my ($class, $string) = @_;

    my ($name) = $string =~ /(\w+)\(.*\)/;
    my ($attribute) = $string =~ /\{(\w+)\}/;

    return $class->new($name, $attribute);
}

sub is_static {
    my ($self) = @_;

    return ($self->get_attribute eq 'static') ? 1 : 0;
}

sub is_abstract {
    my ($self) = @_;

    return ($self->get_attribute eq 'abstract') ? 1 : 0;
}

1;

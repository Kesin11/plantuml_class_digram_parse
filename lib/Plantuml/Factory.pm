package Plantuml::Factory;

use strict;
use warnings;
use utf8;
use Plantuml::Method;
use Plantuml::Variable;

my $METHOD = 'Plantuml::Method';
my $VARIABLE = 'Plantuml::Variable';

sub create {
    my ($class, $string) = @_;

    return $METHOD if $class->_check_is_method($string);
    return $VARIABLE if $class->_check_is_variable($string);

    return undef;
}

sub _check_is_method {
    my ($class, $string) = @_;

    return 1 if ($string =~ /\w+\(.*\)/);
    return 0;
}

sub _check_is_variable {
    my ($class, $string) = @_;

    return 1 if ($string =~ /\w+/);
    return 0;
}

1;

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

    return undef if $class->_check_is_separator($string);
    return undef if $class->_check_is_comment($string);

    return $METHOD   if $class->_check_is_method($string);
    return $VARIABLE if $class->_check_is_variable($string);

    return undef;
}

sub _check_is_separator {
    my ($class, $string) = @_;

    return 1 if ($string =~ /(--|__|==|\.\.)/);
    return 0;
}

sub _check_is_comment {
    my ($class, $string) = @_;

    return 1 if ($string =~ /'.*'/);
    return 0;
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

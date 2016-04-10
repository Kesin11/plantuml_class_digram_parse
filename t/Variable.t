use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Class::Variable;

my $CLASS = 'Plantuml::Class::Variable';
BEGIN { use_ok 'Plantuml::Class::Variable' };

subtest "normal" => sub {
    my $fixture = 'foo';

    my $method = $CLASS->build($fixture);
    is ($method->get_name, 'foo', 'name');
    is ($method->get_attribute, '', 'attribute');
};

done_testing;

use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Variable;

my $CLASS = 'Plantuml::Variable';
BEGIN { use_ok 'Plantuml::Variable' };

subtest "normal" => sub {
    my $fixture = 'foo';

    my $method = $CLASS->build($fixture);
    is ($method->get_name, 'foo', 'name');
    is ($method->get_attribute, '', 'attribute');
};

done_testing;

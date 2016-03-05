use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Variable;

my $CLASS = 'Plantuml::Variable';
BEGIN { use_ok $CLASS };

subtest "build" => sub {
    my $fixture = 'foo';

    my $method = $CLASS->build($fixture);
    is ($relation->get_name, 'foo', 'name');
    is ($relation->get_attribute, undef, 'attribute');
};

done_testing;

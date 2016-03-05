use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Method;

my $CLASS = 'Plantuml::Method';
BEGIN { use_ok $CLASS };

subtest "normal" => sub {
    my $fixture = 'foo()';

    my $method = $CLASS->build($fixture);
    is ($relation->get_name, 'foo', 'name');
    is ($relation->get_attribute, undef, 'attribute');
    not_ok ($relation->is_abstract, 'is_abstract');
    not_ok ($relation->is_static, 'is_static');
};

subtest "static method" => sub {
    my $fixture = '{static} foo()';

    my $method = $CLASS->build($fixture);
    is ($relation->get_name, 'foo', 'name');
    is ($relation->get_attribute, 'static', 'attribute');
    ok ($relation->is_static, 'is_static');
};

subtest "abstract method" => sub {
    my $fixture = '{abstract} foo()';

    my $method = $CLASS->build($fixture);
    is ($relation->get_name, 'foo', 'name');
    is ($relation->get_attribute, 'abstract', 'attribute');
    ok ($relation->is_abstract, 'is_abstract');
};

done_testing;

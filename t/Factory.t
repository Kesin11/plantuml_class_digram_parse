use strict;
use warnings;
use utf8;
use Test::More;
use Plantuml::Parser;
use t::Util qw/load_fixture/;

BEGIN { use_ok 'Plantuml::Class' };

subtest "class" => sub {
    my $fixture = load_fixture('class.pu');
    subtest "_get_class_basic" => sub {
        my $expect = +{
        }
    };
};

subtest "abstract class" => sub {
    my $fixture = load_fixture('abstract_class.pu');
};


done_testing;

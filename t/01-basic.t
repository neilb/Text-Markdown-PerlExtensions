#!perl

use strict;
use warnings;

use Text::Markdown::PerlExtensions qw(markdown);
use Test::More;

my @TESTS =
(

    {
        title => 'Simple paragraph text',
        in    => 'This is a simple test.',
        out   => '<p>This is a simple test.</p>',
    },

    {
        title => 'Module name with simple pragma',
        in    => "Don't forget to use M<strict>!",
        out   => qq{<p>Don't forget to use <a href="https://metacpan.org/pod/strict" class="module">strict</a>!</p>},
    },

    {
        title => 'Module name with more typical module name',
        in    => "Don't forget to use M<Foo::Bar::Baz>!",
        out   => qq{<p>Don't forget to use <a href="https://metacpan.org/pod/Foo::Bar::Baz" class="module">Foo::Bar::Baz</a>!</p>},
    },

    {
        title => 'Author id',
        in    => 'The module was written by A<ANDK>.',
        out   => qq{<p>The module was written by <a href="https://metacpan.org/author/ANDK" class="cpanAuthor">ANDK</a>.</p>},
    },

    {
        title => 'Author and Module',
        in    => 'Module M<Module::Path> was written by A<NEILB>.',
        out   => qq{<p>Module <a href="https://metacpan.org/pod/Module::Path" class="module">Module::Path</a> was written by <a href="https://metacpan.org/author/NEILB" class="cpanAuthor">NEILB</a>.</p>},
    },

    {
        title => 'Multiline input',
        in    => "Look at M<Moops>.\nIt's written by A<TOBYINK>.",
        out   => qq{<p>Look at <a href="https://metacpan.org/pod/Moops" class="module">Moops</a>.\nIt's written by <a href="https://metacpan.org/author/TOBYINK" class="cpanAuthor">TOBYINK</a>.</p>},
    },

);

foreach my $test (@TESTS) {
    my $in       = $test->{in};
    my $expected = $test->{out};
    my $out      = markdown($in);

    $out =~ s/^\s+|\s+$//;
    is($out, $expected, 'Functional: '.$test->{title});
}

my $formatter = Text::Markdown::PerlExtensions->new();

foreach my $test (@TESTS) {
    my $in       = $test->{in};
    my $expected = $test->{out};
    my $out      = $formatter->markdown($in);

    $out =~ s/^\s+|\s+$//;
    is($out, $expected, 'OO: '.$test->{title});
}

done_testing();

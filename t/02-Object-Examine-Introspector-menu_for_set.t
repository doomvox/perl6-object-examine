use v6;

use Test;
use Object::Examine;

## checking behavior of .menu on a Set object, 
## new core behavior for menu expands the report, gets a more complete list of methods


my $test_case = "Method 'menu' from 'Introspector' role run on a Set";
subtest {
    my @monsters = < godzilla mothera rhodan tingler wolfman dracula horta blob >;
#     my @japanese = < godzilla mothera rhodan >;
#     my @expected = < tingler wolfman dracula horta blob >;

    my $monster_set = @monsters.Set;
    $monster_set does Introspector;
    my $report = $monster_set.menu;

    my @report = $report.lines;
    my $l = @report.elems;  # 
    my $a_few_dozen = 24;
    cmp-ok($l, '>', $a_few_dozen, "Report shows over $a_few_dozen methods: $l");

#    say "count: ", $report.lines.elems;
#    say $report;

    my @expected = (('values',   'Set'),
                    ('keys',     'Set'),
                    ('split',    'Mu'),  ## Mu, huh? Not Cool?
                    ('pick',     'Set'),
                    ('keyof',    'Set'), 
                    ('map',      'Any'), 
                    ('say',      'Mu'), 
                   );

  my @not_expected = ( ('Method+{is-nodal}.new',     'List'),
                       ('Method+{is-nodal}.new',     'Array'),
                       ('Method+{is-nodal}.new',     'Set'),
                       ('Classy',                    'Microsoft'),
                       ('Inexpensive',               'Apple'),
                     ); 

  for @expected -> @pair {
      my ($expected_method, $expected_class) = @pair;
      my $pattern = /^ $expected_method \s*? $expected_class/; #  e.g. /^ grab \s*? Array/
      ok @report.grep({ / $pattern / }).so, "Found expected row for $expected_method method";
  }

  for @not_expected -> @pair {
      my ($expected_method, $expected_class) = @pair;
      my $pattern = /^ $expected_method \s*? $expected_class/; #  my $pattern = /^ grab \s*? Array/;
      ok @report.grep({ $pattern }).so.not,
           "Did not find any row for $expected_method method in class $expected_class";
  }


}, $test_case;

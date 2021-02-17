use v6;

use Test;
use Object::Examine;

# plan 2;

my $test_case = "Method 'menu' from 'Introspector' role run on an Array";
subtest {
  my @creatures = <alphan betazoid gammera>;
  @creatures does Introspector;
  my $report = @creatures.menu;

  # To force a test to fail (to make sure it can):
  # $report ~= 'Method+{is-nodal}.new     List                     ';

  my @report = $report.lines;
  # say @report[203];

  my $l = @report.elems;  # 203
  my $a_few_dozen = 24;
  cmp-ok($l, '>', $a_few_dozen, "Report shows over $a_few_dozen methods: $l");

  # Scrape the 'menu' report checking for lines like:
  # grab                      Array                    
  # take                      Mu                       
  # split                     Cool                     
  # rotate                    List                     

  # Method+{is-nodal}.new     List                     

  my @expected = (('grab',    'Array'),
                  ('take',    'Mu'),
                  ('split',   'Cool'),
#                  ('rotate',  'List')  ## originally rotate was a List method, now it's an Array
                  ('rotate',  'Array'),
                 );

  
  my @not_expected = ( ('Method+{is-nodal}.new',     'List'),
                       ('Method+{is-nodal}.new',     'Array'),
                       ('Method+{is-nodal}.new',     'Cool'),
                       ('progressive-regressive',    'Dialectic'),
                       ('reducto ad absurdum',       'Pretentious'),
                       ('brazillian wax',            'Fluffer'),
                     ); 

  # my ($expected_method, $expected_class) = @expected[0].flat;

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

done-testing;

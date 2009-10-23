#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Expense::Date' );
}

diag( "Testing Expense::Date $Expense::Date::VERSION, Perl $], $^X" );

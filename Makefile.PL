use inc::Module::Install;

name     'Expense-Date';
all_from 'lib/Expense/Date.pm';
author   q{STKEVIN <zard1989@gmail.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;


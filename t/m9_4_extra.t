#
# Test for internation movies
#

use strict;

use Test::More tests => 13;
use IMDB::Film;

#
# Check the status of loaded IMDB object for some internation movies
#
my $crit = 'delicatessen';
my %pars = (cache => 0, debug => 0, crit => $crit);
my $obj = new IMDB::Film(%pars);
is($obj->status, 2, 'Object status');
is($obj->code, '0101700', 'Movie code');
%pars = (cache => 0, debug => 0, crit => 'ben-hur');
$obj = new IMDB::Film(%pars);
is($obj->status, 2, 'Object status');
is($obj->code, '0052618', 'Movie code');

#
# Check parsing writers in case when there is an only one person
#
$obj = new IMDB::Film(cache => 0, debug => 0, crit => 'Stay');
is($obj->code, '0371257', 'Movie Code');
is($obj->status, 2, 'Object status');
is_deeply($obj->writers, [{id => '1125275', name => 'David Benioff'}], 'Modie Writes');

#
# Check retrieving movie by its title and year
#
$obj = new IMDB::Film(cache => 0, debug => 0, crit => 'Jack', year => 2003);
is($obj->code, '0379836', 'Movie Code');
is($obj->year, 2003, 'Movie Year');


$obj = new IMDB::Film(cache => 0, debug => 0, crit => '0431035');
my($rate, $num) = $obj->rating;
like($rate, qr/\d+/, 'Movie rating');
like($num, qr/\d+/, 'Rated people');
ok($rate > 1, 'Rate is greater than 1');
ok($num >= 8, 'Votes greater than 8');

#!usr/bin/env perl

use strict;
use warnings;

use Test::Most;
use Plack::Test;

use_ok('Plack::Middleware::WarnStash');

done_testing();

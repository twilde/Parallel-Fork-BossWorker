#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Parallel::Fork::BossWorker' );
}

diag( "Testing Parallel::Fork::BossWorker $Parallel::Fork::BossWorker::VERSION, Perl $], $^X" );

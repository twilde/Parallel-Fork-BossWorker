#!perl

use Test::More tests => 4;
use Parallel::Fork::BossWorker;
use Test::Warn;

my @testdata = (
    { foo => 'bar', action => 'die' },
    { bar => 'baz', action => 'timeout' },
);

foreach my $quiet (0, 1) {
    # Create new BossWorker instance
    my $bw = new Parallel::Fork::BossWorker(
        quiet => $quiet,
        worker_count => 5,
        global_timeout => 3,
        work_handler => sub {
            my $work = shift;
            my $data = $work->{data};
            if ($data->{action} eq 'die') {
                die "I'm supposed to die, mom!";
            } elsif ($data->{action} eq 'timeout') {
                sleep(10);
            }
            return $work;
        },
    );

    isa_ok($bw, 'Parallel::Fork::BossWorker');

    # Add work to the BW
    foreach my $index (0..$#testdata) {
        $bw->add_work({index => $index, data => $testdata[$index]});
    }

    # Process the work in the queue
    if ($quiet) {
        warnings_are { $bw->process(); } [ ], 'Quiet, no warnings';
    } else {
        warnings_like { $bw->process(); } [ { carped => qr/died/ }, { carped => qr/timed out/ } ], "Not quiet";
    }
}

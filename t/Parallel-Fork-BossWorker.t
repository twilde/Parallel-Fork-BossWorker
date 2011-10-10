use Test::More tests => 3;
BEGIN { use_ok('Parallel::Fork::BossWorker') };
require_ok('Parallel::Fork::BossWorker');

# When the result handler is executed, the value is stored here
my $result_value = 0;

# Create new BossWorker instance
my $bw = new Parallel::Fork::BossWorker(
	work_handler => sub {
			my $work = shift;
			return {
				result => $work->{value}
			};
		},
	result_handler => sub {
		my $result = shift;
		if ($result->{result} && $result->{result} eq "ok") {
			$result_value++;
		}
	}
);

# Add work to the BW
foreach (1..10) {
	$bw->add_work({value => "ok"});
}

# Process the work in the queue
$bw->process();

is($result_value, 10, "End to end test");


use strict;
use warnings;

use WebService::SmartRow;

my $workouts = WebService::SmartRow->new->get_workouts();

my %pbs = (
    2000 => 9999,
    4000 => 9999,
    5000 => 9999,
    6000 => 9999,
);

for my $session (@$workouts) {
    next unless exists $pbs{ $session->{distance} };

    if ( $pbs{ $session->{distance} } > $session->{elapsed_seconds} ) {
        $pbs{ $session->{distance} } = $session->{elapsed_seconds};
    }
}

print "Personal Bests\n";
for my $key ( sort keys %pbs ) {
    print sprintf( "%sM:  %.02f minutes\n", $key, $pbs{$key} / 60 );
}


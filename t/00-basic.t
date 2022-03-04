use Test2::V0;

use WebService::SmartRow;

subtest 'Contruction' => sub {
    my $sr = WebService::SmartRow->new(
        username => 'foo',
        password => 'pass',
    );

    is $sr->username(), 'foo', 'username';
    is $sr->password(), 'pass', 'password';

};


done_testing;


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

subtest 'Construction using environment variables' => sub {
    # To prevent having to include username and password
    # make it so they can be read from ENV

    local %ENV = %ENV;
    $ENV{SMARTROW_USERNAME} = 'bar@tree';

    my $sr = WebService::SmartRow->new();
    is $sr->username(), 'bar', 'username';
};

done_testing;


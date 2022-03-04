use strict;
use warnings;

package WebService::SmartRow;

# ABSTRACT: Connect and get data from SmartRow API

use HTTP::Tiny;
use Cpanel::JSON::XS;

use Moo;
use namespace::clean;

has username => ( is => 'ro', required => 1 );
has password => ( is => 'ro', required => 1 );

has http => (
    is => 'ro',
    default => sub {
        return HTTP::Tiny->new();
    },
);

# https://smartrow.fit/api/account
sub get_profile {
    my $self = shift;

    my $response = $self->http->request(
        'GET',
        'https://'
        . $self->username
        . ':'
        . $self->password
        . '@'
        . 'smartrow.fit/api/account'
    );

    if (!$response->{success}) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->[0];
}

# https://smartrow.fit/api/public-game
sub get_workouts {
    my $self = shift;

    my $response = $self->http->request(
        'GET',
        'https://'
        . $self->username
        . ':'
        . $self->password
        . '@'
        . 'smartrow.fit/api/public-game'
    );

    if (!$response->{success}) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json;
}

1;

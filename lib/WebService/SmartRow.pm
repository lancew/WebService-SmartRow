use strict;
use warnings;

use v5.6.0;

package WebService::SmartRow;

# ABSTRACT: Connect and get data from SmartRow API

use HTTP::Tiny;
use Cpanel::JSON::XS;

use Moo;
use namespace::clean;

has username => ( is => 'ro', required => 0 );
has password => ( is => 'ro', required => 0 );

has http => (
    is      => 'ro',
    default => sub {
        return HTTP::Tiny->new();
    },
);

# https://smartrow.fit/api/account
sub get_profile {
    my $self = shift;

    my ( $user, $pass ) = $self->_credentials_via_env;

    my $response = $self->http->request( 'GET',
        'https://' . $user . ':' . $pass . '@' . 'smartrow.fit/api/account' );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json->[0];
}

# https://smartrow.fit/api/public-game
sub get_workouts {
    my $self = shift;

    my ( $user, $pass ) = $self->_credentials_via_env;

    my $response = $self->http->request( 'GET',
              'https://'
            . $user . ':'
            . $pass . '@'
            . 'smartrow.fit/api/public-game' );

    if ( !$response->{success} ) {
        return 'Response error';
    }

    my $json = decode_json $response->{content};

    return $json;
}

sub _credentials_via_env {
    my $self = shift;

    my $user = $self->username || $ENV{SMARTROW_USERNAME};
    # Escape the "@" as perl basic auth requirement
    $user =~ s/@/%40/g;

    my $pass = $self->password || $ENV{SMARTROW_PASSWORD};

    return ( $user, $pass ),;
}

=pod
=head1 SYNOPSIS

 This module is a basic wrapper to allow Perl apps to access data from https://smartrow.fit

 my $smartrow = WebService::SmartRow->new(
  username => 'foo',
  password => 'bar',
 );

 my $profile  = $smartrow->get_profile;
 my $workouts = $smartrow->get_workouts;

 Credentials can be passed via environment variables

 * SMARTROW_USERNAME
 * SMARTROW_PASSWORD

 If passing credentials via ENV you can simply use WebService::SmartRow->new;

=head2 http

  http is a HTTP::Tiny object by default, you can provide your own on construction.

  This might be helpful if, for example, you wanted to change the user agent.

=head2 username

  get/set the username for the API

  Note that we parse the username in get_ methods to escape the "@" char.

  You can also set the SMARTROW_USERNAME environment variable.

=head2 password

  get/set the password for the API

  You can also set the SMARTROW_PASSWORD environment variable.

=head2 get_profile

  This method obtains your profile information

=head2 get_workouts

  This method returns all the workouts you have done via SmartRow
=cut

1;

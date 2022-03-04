use strict;
use warnings;
package WebService::SmartRow;

# ABSTRACT: Connect and get data from SmartRow API

use Moo;
use namespace::clean;

has username => ( is => 'ro', required => 1);
has password => ( is => 'ro', required => 1);
1;

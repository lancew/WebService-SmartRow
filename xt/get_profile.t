use Test2::V0;

use WebService::SmartRow;

die 'You need to set SMARTROW_USERNAME' unless $ENV{SMARTROW_USERNAME};
die 'You need to set SMARTROW_PASSWORD' unless $ENV{SMARTROW_PASSWORD};

my $sr = WebService::SmartRow->new;

my $profile = $sr->get_profile;

is $profile,
    {
    'activation_key'     => E,
    'active'             => E,
    'age'                => E,
    'avatar'             => E,
    'clearance'          => E,
    'country'            => E,
    'country_flag'       => E,
    'country_name'       => E,
    'created'            => E,
    'data_permission'    => E,
    'dob'                => E,
    'email'              => E,
    'first_name'         => E,
    'force_curve_max'    => E,
    'gender'             => E,
    'height'             => E,
    'id'                 => E,
    'is_public'          => E,
    'language'           => E,
    'last_login'         => E,
    'last_name'          => E,
    'max_hr'             => E,
    'metric_measurement' => E,
    'mod'                => E,
    'public_id'          => E,
    'reset_key'          => E,
    'strava_connection'  => E,
    'weight'             => E,
    };

my $workouts = $sr->get_workouts;
use Data::Dumper;
note Dumper $workouts;

is $workouts->[0],

    {
    "accessory_mac"        => E,
    "account"              => E,
    "ave_bpm"              => E,
    "ave_power"            => E,
    "calc_ave_split"       => E,
    "calc_avg_stroke_rate" => E,
    "calc_avg_stroke_work" => E,
    "calories"             => E,
    "confirmed"            => E,
    "created"              => E,
    "curve"                => E,
    "device_mac"           => E,
    "distance"             => E,
    "elapsed_seconds"      => E,
    "extra_millies"        => E,
    "id"                   => E,
    "mod"                  => E,
    "option"               => E,
    "option_distance"      => E,
    "option_time"          => E,
    "p_ave"                => E,
    "protocol_version"     => E,
    "public_id"            => E,
    "race"                 => E,
    "strava_id"            => E,
    "stroke_count"         => E,
    "time"                 => E,
    "user_age"             => E,
    "user_max_hr"          => E,
    "user_weight"          => E,
    "watt_kg"              => E,
    "watt_per_beat"        => E,
    },

    , 'First item from array has correct structure';

done_testing;

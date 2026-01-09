# @summary Manages Immich configuration
#
# @api private
#
class immich::config {
  assert_private()

  $ensure = $immich::ensure

  if $ensure == 'present' {
    # Configuration directory
    file { '/etc/immich':
      ensure => directory,
      owner  => 'root',
      group  => 'immich',
      mode   => '0750',
    }

    # Environment file with database and service configuration
    file { '/etc/immich/env':
      ensure  => file,
      owner   => 'root',
      group   => 'immich',
      mode    => '0640',
      content => epp('immich/env.epp', {
        'db_hostname'      => $immich::db_hostname,
        'db_username'      => $immich::db_username,
        'db_password'      => $immich::db_password,
        'db_database_name' => $immich::db_database_name,
        'redis_hostname'   => $immich::redis_hostname,
        'upload_location'  => $immich::upload_location,
      }),
      require => File['/etc/immich'],
    }
  } else {
    file { ['/etc/immich/env', '/etc/immich']:
      ensure => absent,
      force  => true,
    }
  }
}

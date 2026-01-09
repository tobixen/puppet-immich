# @summary Installs Immich on Debian/Ubuntu
#
# Uses the immich-native installation approach.
# See: https://github.com/arter97/immich-native
#
# @api private
#
class immich::install::debian {
  assert_private()

  $ensure = $immich::ensure

  # TODO: Implement immich-native installation
  # This requires:
  # - Node.js 24 LTS
  # - PostgreSQL with pgvector extension
  # - Redis/Valkey
  # - FFmpeg (jellyfin-ffmpeg recommended)
  # - Python venv for ML
  # - Building from source

  notify { 'immich_debian_not_implemented':
    message  => 'Immich installation on Debian/Ubuntu is not yet fully implemented. See immich-native project.',
    loglevel => warning,
  }

  # Create immich user
  if $ensure == 'present' {
    user { 'immich':
      ensure     => present,
      system     => true,
      home       => '/var/lib/immich',
      shell      => '/usr/sbin/nologin',
      managehome => true,
    }

    # Ensure upload directory exists
    file { $immich::upload_location:
      ensure  => directory,
      owner   => 'immich',
      group   => 'immich',
      mode    => '0750',
      require => User['immich'],
    }
  }
}

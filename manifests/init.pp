# @summary Installs and manages Immich photo management server
#
# This module installs Immich, a self-hosted photo and video backup solution.
#
# On Arch Linux, it uses the AUR packages via the yay provider.
# On Ubuntu, it uses the immich-native installation method.
#
# @param ensure
#   Whether Immich should be installed or removed.
#
# @param db_password
#   Password for the PostgreSQL database. Required.
#
# @param upload_location
#   Directory where uploaded photos/videos are stored.
#   Defaults to /var/lib/immich/upload.
#
# @param db_hostname
#   PostgreSQL hostname. Defaults to localhost.
#
# @param db_username
#   PostgreSQL username. Defaults to immich.
#
# @param db_database_name
#   PostgreSQL database name. Defaults to immich.
#
# @param redis_hostname
#   Redis/Valkey hostname. Defaults to localhost.
#
# @param machine_learning
#   Whether to install the machine learning component.
#   Defaults to true.
#
# @param manage_database
#   Whether to manage PostgreSQL installation and configuration.
#   Defaults to false (assumes external database management).
#
# @param manage_redis
#   Whether to manage Redis/Valkey installation.
#   Defaults to false.
#
# @example Basic usage
#   class { 'immich':
#     db_password => 'secure_password_here',
#   }
#
class immich (
  Enum['present', 'absent'] $ensure           = 'present',
  String[1]                 $db_password,
  Stdlib::Absolutepath      $upload_location  = '/var/lib/immich/upload',
  String[1]                 $db_hostname      = 'localhost',
  String[1]                 $db_username      = 'immich',
  String[1]                 $db_database_name = 'immich',
  String[1]                 $redis_hostname   = 'localhost',
  Boolean                   $machine_learning = true,
  Boolean                   $manage_database  = false,
  Boolean                   $manage_redis     = false,
) {
  case $facts['os']['family'] {
    'Archlinux': {
      contain immich::install::archlinux
      contain immich::config
      contain immich::service

      Class['immich::install::archlinux']
      -> Class['immich::config']
      ~> Class['immich::service']
    }
    'Debian': {
      contain immich::install::debian
      contain immich::config
      contain immich::service

      Class['immich::install::debian']
      -> Class['immich::config']
      ~> Class['immich::service']
    }
    default: {
      fail("Unsupported OS family: ${facts['os']['family']}")
    }
  }
}

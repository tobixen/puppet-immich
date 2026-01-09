# @summary Manages Immich services
#
# @api private
#
class immich::service {
  assert_private()

  $ensure = $immich::ensure

  $service_ensure = $ensure ? {
    'present' => 'running',
    'absent'  => 'stopped',
  }

  $service_enable = $ensure ? {
    'present' => true,
    'absent'  => false,
  }

  # Main Immich server service
  service { 'immich':
    ensure => $service_ensure,
    enable => $service_enable,
  }

  # Machine learning service (if enabled)
  if $immich::machine_learning {
    service { 'immich-machine-learning':
      ensure => $service_ensure,
      enable => $service_enable,
    }
  }
}

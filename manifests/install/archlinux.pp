# @summary Installs Immich on Arch Linux using AUR packages
#
# @api private
#
class immich::install::archlinux {
  assert_private()

  # Require the aur_yay module for AUR package management
  # Users must have yay installed and include aur_yay class

  $ensure = $immich::ensure

  # Main Immich server package
  package { 'immich-server':
    ensure   => $ensure ? {
      'present' => 'installed',
      'absent'  => 'absent',
    },
    provider => 'yay',
  }

  # Machine learning component (optional)
  if $immich::machine_learning {
    package { 'immich-machine-learning':
      ensure   => $ensure ? {
        'present' => 'installed',
        'absent'  => 'absent',
      },
      provider => 'yay',
      require  => Package['immich-server'],
    }
  }

  # Ensure upload directory exists
  if $ensure == 'present' {
    file { $immich::upload_location:
      ensure => directory,
      owner  => 'immich',
      group  => 'immich',
      mode   => '0750',
    }
  }
}

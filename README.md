# puppet-immich

Puppet module for installing and managing [Immich](https://immich.app/), a self-hosted photo and video backup solution.

## Description

This module installs and configures Immich on:
- **Arch Linux** - using AUR packages via the [puppet-aur-yay](https://github.com/tobixen/puppet-aur-yay) module
- **Ubuntu/Debian** - using the immich-native installation method (work in progress)

## Requirements

### Arch Linux

- yay must be installed
- The `tobixen-aur_yay` module must be available
- PostgreSQL with vectorchord extension
- Valkey (Redis replacement)

### Ubuntu/Debian

- PostgreSQL 14+ with pgvector extension
- Redis or Valkey
- Node.js 20+
- (Full implementation pending)

## Usage

### Basic installation (Arch Linux)

```puppet
# Ensure yay is available
include aur_yay

# Install Immich
class { 'immich':
  db_password => 'secure_password_here',
}
```

### With custom configuration

```puppet
class { 'immich':
  db_password      => lookup('immich::db_password'),
  upload_location  => '/srv/immich/upload',
  db_hostname      => 'db.example.com',
  machine_learning => true,
}
```

### Hiera example

```yaml
immich::db_password: ENC[PKCS7,...]
immich::upload_location: /mnt/photos/immich
immich::machine_learning: true
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `ensure` | Enum['present', 'absent'] | 'present' | Whether Immich should be installed |
| `db_password` | String | (required) | PostgreSQL database password |
| `upload_location` | Stdlib::Absolutepath | '/var/lib/immich/upload' | Photo/video storage directory |
| `db_hostname` | String | 'localhost' | PostgreSQL hostname |
| `db_username` | String | 'immich' | PostgreSQL username |
| `db_database_name` | String | 'immich' | PostgreSQL database name |
| `redis_hostname` | String | 'localhost' | Redis/Valkey hostname |
| `machine_learning` | Boolean | true | Install ML component |
| `manage_database` | Boolean | false | Manage PostgreSQL (not yet implemented) |
| `manage_redis` | Boolean | false | Manage Redis/Valkey (not yet implemented) |

## Dependencies

- puppetlabs/stdlib
- tobixen/aur_yay (for Arch Linux only)

## Limitations

- Ubuntu/Debian installation is not yet fully implemented
- Database and Redis management is not yet implemented
- Tested only on Arch Linux so far

## Development

Contributions welcome at https://github.com/tobixen/puppet-immich

## License

Apache-2.0

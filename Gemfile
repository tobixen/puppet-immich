source 'https://rubygems.org'

gem 'puppet', ENV['PUPPET_GEM_VERSION'] || '>= 7.0'
gem 'puppetlabs_spec_helper', '~> 7.0'
gem 'puppet-lint', '>= 2.0'
gem 'facter', '>= 4.0'

group :development do
  # Ruby 3.4 no longer ships syslog as a default gem; puppet 8.10
  # still needs it to detect a POSIX system
  gem 'syslog'
  gem 'rake'
  gem 'rspec-puppet', '~> 4.0'
  gem 'rspec-puppet-facts'
end

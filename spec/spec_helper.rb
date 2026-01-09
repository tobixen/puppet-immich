require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.default_facts = {
    kernel: 'Linux',
    os: {
      'family' => 'Archlinux',
      'name' => 'Archlinux',
    },
  }
end

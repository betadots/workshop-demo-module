# frozen_string_literal: true

require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'app_config_2',
  docs: <<-EOS,
@summary app_config_2 type
@example
app_config_2 { 'key':
  ensure => present,
  value  => 'value',
}

This type provides Puppet with the capabilities to manage our application config
EOS
  features: [],
  attributes: {
    ensure: {
      type:    'Enum[present, absent]',
      desc:    'Whether this application config should be present or absent on the target system.',
      default: 'present',
    },
    key: {
      type:      'String',
      desc:      'The key of the application config you want to manage.',
      behaviour: :namevar,
    },
    value: {
      type: 'String',
      desc: 'The value of the specific application configuration you want to set.',
    },
  },
)

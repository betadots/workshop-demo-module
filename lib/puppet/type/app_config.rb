Puppet::Type.newtype(:app_config) do
  @doc = 'Manage application settings using the app binary.'

  ensurable

  newproperty(:value) do
    desc 'The value of the key'
  end

  newparam(:key, namevar: true) do
    desc 'The key to manage'
    validate do |value|
      unless value =~ %r(\w+)
        raise ArgumentError, "key must be a string, not #{value.class}"
      end
    end
  end
end

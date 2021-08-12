require_relative 'to_yaml.rb'
Facter.add(:reusing_code) do
  setcode do
    m = Example42.new
    result = m.convert_to_yaml({ foo: 'bar', bar: 'foo' })
    result
  end
end

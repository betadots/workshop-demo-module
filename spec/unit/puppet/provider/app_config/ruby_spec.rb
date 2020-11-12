require 'spec_helper'
provider_class = Puppet::Type.type(:app_config).provider(:ruby)

describe provider_class do
  let(:resource) do
    Puppet::Type::App_config.new do
      {
        key: 'test',
        value: '1G',
      }
    end
  end

  let(:provider) do
    provider_class.new(@resource) # rubocop:disable RSpec/InstanceVariable
  end

  it 'exists' do
    provider_class.new(@resource) # rubocop:disable RSpec/InstanceVariable
  end
end

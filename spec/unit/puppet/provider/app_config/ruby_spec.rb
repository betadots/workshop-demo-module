require 'spec_helper'
provider_class = Puppet::Type.type(:app_config).provider(:ruby)

describe provider_class do
  let(:resource) {
    Puppet::Type::App_config.new do {
      key: 'test',
      value: '1G',
    }
    end
  }

  let(:provider) {
    @provider = provider_class.new(@resource)
  }
  it 'should exist' do
    @provider
  end
end


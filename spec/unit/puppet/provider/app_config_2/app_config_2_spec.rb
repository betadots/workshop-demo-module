# frozen_string_literal: true

require 'spec_helper'

ensure_module_defined('Puppet::Provider::AppConfig2')
require 'puppet/provider/app_config_2/app_config_2'

RSpec.describe Puppet::Provider::AppConfig2::AppConfig2 do # rubocop:disable RSpec/FilePath
  subject(:provider) { described_class.new }

  let(:context) { instance_double('Puppet::ResourceApi::BaseContext', 'context') }

  describe '#get' do
    it 'processes resources' do
      expect(context).to receive(:debug).with('Returning data from command')
      status = instance_double('status message', success?: true)
      allow(Open3).to receive(:capture3).with('/opt/app/bin/app.exe list').and_return(["---\nkey: value\n", '', status])
      expect(provider.get(context)).to eq [
        {
          key: 'key',
          ensure: 'present',
          value: 'value',
        },
      ]
    end
  end

  describe 'create(context, key, should)' do
    it 'creates the resource' do
      expect(context).to receive(:notice).with(%r{\ACreating 'a'})
      status = instance_double('status message', success?: true)
      allow(Open3).to receive(:capture3).with('/opt/app/bin/app.exe set a a').and_return(['', '', status])

      provider.create(context, 'a', key: 'a', ensure: 'present', value: 'a')
    end
  end

  describe 'update(context, key, should)' do
    it 'updates the resource' do
      expect(context).to receive(:notice).with(%r{\AUpdating 'a'})
      status = instance_double('status message', success?: true)
      allow(Open3).to receive(:capture3).with('/opt/app/bin/app.exe set a a').and_return(['', '', status])

      provider.update(context, 'a', key: 'a', ensure: 'present', value: 'a')
    end
  end

  describe 'delete(context, key)' do
    it 'deletes the resource' do
      expect(context).to receive(:notice).with(%r{\ADeleting 'a'})
      status = instance_double('status message', success?: true)
      allow(Open3).to receive(:capture3).with('/opt/app/bin/app.exe rm a').and_return(['', '', status])

      provider.delete(context, 'a')
    end
  end
end

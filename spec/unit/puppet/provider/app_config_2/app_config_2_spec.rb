# frozen_string_literal: true

require 'spec_helper'

ensure_module_defined('Puppet::Provider::AppConfig2')
require 'puppet/provider/app_config_2/app_config_2'

RSpec.describe Puppet::Provider::AppConfig2::AppConfig2 do
  subject(:provider) { described_class.new }

  let(:context) { instance_double('Puppet::ResourceApi::BaseContext', 'context') }

  describe '#get' do
    it 'processes resources' do
      expect(context).to receive(:debug).with('Returning pre-canned example data')
      allow(Open3).to receive(:open).with('/opt/app/bin/app.exe list').and_return("---\nkey: value\n")
      expect(provider.get(context)).to eq [
        {
          name: 'key',
          ensure: 'present',
          value: 'value',
        },
      ]
    end
  end

  describe 'create(context, key, should)' do
    it 'creates the resource' do
      expect(context).to receive(:notice).with(%r{\ACreating 'a'})

      provider.create(context, 'a', key: 'a', ensure: 'present')
    end
  end

  describe 'update(context, key, should)' do
    it 'updates the resource' do
      expect(context).to receive(:notice).with(%r{\AUpdating 'foo'})

      provider.update(context, 'foo', key: 'foo', ensure: 'present')
    end
  end

  describe 'delete(context, key)' do
    it 'deletes the resource' do
      expect(context).to receive(:notice).with(%r{\ADeleting 'foo'})

      provider.delete(context, 'foo')
    end
  end
end

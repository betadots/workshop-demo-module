# frozen_string_literal: true

require 'spec_helper'

describe 'demo_module::app_config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      Puppet::Functions.create_function(:'sort') do
        return ['1', '2']
      end

      it { is_expected.to compile }
      it { should contain_notify(['1', '2']) }
    end
  end
end

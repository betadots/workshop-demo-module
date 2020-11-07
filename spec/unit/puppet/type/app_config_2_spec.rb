# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/app_config_2'

RSpec.describe 'the app_config_2 type' do
  it 'loads' do
    expect(Puppet::Type.type(:app_config_2)).not_to be_nil
  end
end

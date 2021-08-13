# frozen_string_literal: true

require 'spec_helper'
require 'puppet/type/foo'

RSpec.describe 'the foo type' do
  it 'loads' do
    expect(Puppet::Type.type(:foo)).not_to be_nil
  end
end

require 'spec_helper'
describe 'app_config' do
  let(:title) { 'testkey' }

  it { is_expected.to be_valid_type.with_properties('value') }
  it { is_expected.to be_valid_type.with_parameters('key') }
end

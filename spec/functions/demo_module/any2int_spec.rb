require 'spec_helper'

describe 'demo_module::any2int' do
  context 'bool' do
    it { is_expected.to run.with_params(true).and_return(0) }
  end
  context 'with integer parameter' do
    it { is_expected.to run.with_params('1').and_return(1) }
  end
  context 'with array as param causes error' do
    it { is_expected.to run.with_params(['1']).and_raise_error(ArgumentError) }
  end
end

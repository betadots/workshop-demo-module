require 'spec_helper'
require 'facter/cert_extension_fact'

describe 'Puppet Agent Fact' do
  describe 'cert_extension_fact.rb', type: :fact do
    subject { Facter.fact(:puppet_agent_fact).value }

    before(:each) do
      Facter.clear
      allow(Facter.fact(:os)).to receive(:value).and_return(
        'name' => 'CentOS',
        'release' => {
          'major' => '7',
        },
      )
    end
    after(:each) { Facter.clear }

    context 'when running' do
      it 'returns cert_extension_fact' do
      end
    end
  end
end

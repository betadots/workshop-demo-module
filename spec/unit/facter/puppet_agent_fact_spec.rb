require 'spec_helper'
require 'facter/puppet_agent_fact'

describe 'Puppet Agent Fact' do
  describe 'puppet_agent_fact', type: :fact do
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
    subject { Facter.fact(:puppet_agent_fact).value }

    context 'when running' do
      it 'returns puppet-agent' do
        allow(Facter::Core::Execution).to receive(:execute).with('rpm -q --queryformat \'[%{NAME} %{VERSION}-%{RELEASE}\n]\' puppet-agent').and_return('puppet-agent 5.5.21-1.el7')
        expect(Facter.fact(:puppet_agent_fact).value).to eq('puppet-agent')
      end
    end
  end
end

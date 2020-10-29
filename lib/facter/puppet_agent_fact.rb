Facter.add('puppet_agent_fact') do
  Facter.debug 'Check OS Major'
  confine :os do |os|
   os['release']['major'] == '7'
  end

  Facter.debug 'Check os.name'
  confine :os do |os|
   os['name'] == 'CentOS'
  end

  setcode do
    Facter.debug 'We ar enow in puppet fact setcode'
    result = Facter::Core::Execution.execute('rpm -q --queryformat \'[%{NAME} %{VERSION}-%{RELEASE}\n]\' puppet-agent')
    Facter.debug "Result from cli command is #{result}"
    name = result.split[0]
    Facter.debug "Finished puppet fact with result #{name}"
    name
  end
end

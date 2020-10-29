Facter.add('puppet_agent_fact_new') do
  # Confinement mit legacy fact (single line)
  confine kernel: 'Linux'

  Facter.debug 'Check OS Major'

  # confinement mit structured fact (ruby block)
  confine :os do |os|
    !(os['release']['major'] == '22' && os['name'] == 'CentOS')
  end

  Facter.debug 'Check os.name'

  confine :os do |os|
    os['name'] == 'CentOS'
  end

  # confinement mit ruby code (als block)
  confine do
    File.exist?('/usr/bin/rpm')
  end

  setcode do
    Facter.debug 'We ar enow in puppet fact setcode'

    result = Facter::Core::Execution.execute('rpm -q --queryformat \'[%{NAME} %{VERSION}-%{RELEASE}\n]\' puppet-agent')

    Facter.debug "Result from cli command is #{result}"

    # result.split[0]

    Facter.debug 'Finished puppet fact'
    result
  end
end

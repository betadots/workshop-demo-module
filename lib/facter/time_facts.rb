Facter.add('time_facts') do
  setcode do
    result = Facter::Core::Execution.execute('date')
    result
  end
end

Facter.add('time_facts2') do
  setcode 'date'
end

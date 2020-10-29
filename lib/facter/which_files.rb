Facter.add('which_files') do
  # Confinement mit legacy fact (single line)
  confine kernel: 'Linux'

  setcode do
    list = ['grep', 'rpm', 'awk']
    result = {}
    list.each do |element|
      result[element] = Facter::Core::Execution.execute("which #{element} | grep -v alias")
    end
    result
  end
end

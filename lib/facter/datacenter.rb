# overwriting external facts works with puppet 6 and newer
Facter.add(:datacenter) do
  has_weight 1100
  confine do
    File.exist?('/etc/datacenter')
  end
  setcode 'echo cloud'
end
Facter.add(:datacenter) do
  has_weight 100
  confine do
    File.exist?('/etc/motd')
  end
  setcode 'echo workstation'
end

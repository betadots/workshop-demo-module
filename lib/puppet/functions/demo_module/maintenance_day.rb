Puppet::Functions.create_function(:'demo_module::maintenance_day') do
  dispatch :noparam do
  end

  def noparam
    mintag = 1
    maxtag = 4
    res = call_function('fqdn_rand', maxtag - mintag) + mintag
    res
  end
end

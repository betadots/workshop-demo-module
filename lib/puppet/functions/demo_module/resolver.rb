require 'resolv'
require 'socket'
Puppet::Functions.create_function(:'demo_module::resolver') do
  dispatch :ip_to_name do
    param 'Pattern[/\A([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])){3}\z/]', :ip
  end
  dispatch :name_to_ip do
    param 'String', :name
  end
  dispatch :local do
  end

  def ip_to_name(ip)
    Resolv.getname ip
  end

  def name_to_ip(name)
    Resolv.getaddress name
  end

  def local
    Socket.gethostname
  end
end

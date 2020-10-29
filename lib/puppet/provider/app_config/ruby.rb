require 'pry'
Puppet::Type.type(:app_config).provide(:ruby) do
  desc 'Provider description'

  confine :exists => '/opt/app/bin/app.exe'
  has_command(:app_cli, '/opt/app/bin/app.exe')

  # pruefen, ob die resource existiert.
  def exists?
    binding.pry
    @result = app_cli('list').split(/\n/).grep(/^#{resource[:key]}/)
    if @result.length > 1
      raise ParserError, 'found multiple config items found, please fix this'
    end
    if @result.length == 0
      return false
    else
      return true
    end
  end

  # resource entfernen
  def destroy
    app_cli('rm', resource[:key])
  end

  # reosurce anlegen
  def create
    app_cli('set', resource[:key], resource[:value])
  end

  # getter - value auslesen
  def value
    @result[0].split[1]
  end

  # setter - value setzen
  def value=(value)
    app_cli('set', resource[:key], resource[:value])
  end
end
 

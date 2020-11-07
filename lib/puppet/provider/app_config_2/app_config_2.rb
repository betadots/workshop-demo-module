# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require 'open3'

# Implementation for the app_config_2 type using the Resource API.
class Puppet::Provider::AppConfig2::AppConfig2 < Puppet::ResourceApi::SimpleProvider
  #confine :exists => '/opt/app/bin/app.exe'
  #has_command(:app_cli, '/opt/app/bin/app.exe')
  def get(context)

    @result = []
    stdout,stderr,status = Open3.capture3('/opt/app/bin/app.exe list')
    if status.success?
      @result = stdout.split(/\n/).grep(/^#{key}/)
    end
    if @result.length > 1
      raise ParserError, 'found multiple config items found, please fix this'
    end
    if @result.length == 0
      return false
    else
      @result[0].split[1]
    end
    #context.debug('Returning pre-canned example data')
    #[
    #  {
    #    key: 'foo',
    #    ensure: 'present',
    #    value: 'bar',
    #  },
    #  {
    #    key: 'bar',
    #    ensure: 'absent',
    #  },
    #]
  end

  def create(context, key, should)
    context.notice("Creating '#{key}' with #{should.inspect}")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe set #{key} #{should}")
    if status.success?
      stdout
    end
  end

  def update(context, key, should)
    context.notice("Updating '#{key}' with #{should.inspect}")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe set #{key} #{should}")
    if status.success?
      stdout
    end
  end

  def delete(context, key)
    context.notice("Deleting '#{key}'")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe rm #{key}")
    status
  end
end


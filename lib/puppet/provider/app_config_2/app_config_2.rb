# frozen_string_literal: true

require 'puppet/resource_api/simple_provider'
require 'open3'

# Implementation for the app_config_2 type using the Resource API.
class Puppet::Provider::AppConfig2::AppConfig2 < Puppet::ResourceApi::SimpleProvider
  #confine :exists => '/opt/app/bin/app.exe'
  #has_command(:app_cli, '/opt/app/bin/app.exe')
  def get(context)
    context.debug('Returning data from command')

    @result = []
    stdout,stderr,status = Open3.capture3('/opt/app/bin/app.exe list')
    if status.success?
      @command_result = stdout.split(/\n/)
      @command_result.each do |line|
        next if line == '---'
        key = line.split(':')[0]
        value = line.split(':')[1].strip
        hash = {
          'ensure': 'present',
          'key': key,
          'value': value,
        }
        @result += [ hash ]
      end
      return @result
    else
      ParseError "Error running command"
    end
  end

  def create(context, key, should)
    context.notice("Creating '#{key}' with #{should[:value]}")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe set #{key} #{should[:value]}")
    if status.success?
      true
    end
  end

  def update(context, key, should)
    context.notice("Updating '#{key}' with #{should[:value]}")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe set #{key} #{should[:value]}")
    if status.success?
      true
    end
  end

  def delete(context, key)
    context.notice("Deleting '#{key}'")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe rm #{key}")
    if status.success?
      true
    end
  end
end


# frozen_string_literal: true
#
# This provider is used for a demo application
#   https://github.com/tuxmea/workshop-demo-app
# This application must be configred using the app.exe
# executable.

require 'puppet/resource_api/simple_provider'
require 'open3'

# Implementation for the app_config_2 type using the Resource API.
class Puppet::Provider::AppConfig2::AppConfig2 < Puppet::ResourceApi::SimpleProvider
  #confine :exists => '/opt/app/bin/app.exe'
  #has_command(:app_cli, '/opt/app/bin/app.exe')

  # test_data used in provider testing
  def test_data(context)
    [
      {
        key: 'foo',
        ensure: 'present',
        value: 'bar',
      },
      {
        key: 'bar',
        ensure: 'present',
        value: 'bar',
      },
    ]
  end
  # get the existing key/value pairs using the real command
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
          'key': 'key',
          'value': 'value',
        }
        @result += [ hash ]
      end
      return @result
    else
      raise ParseError "Error running command: \n#{stderr}"
    end
  end

  # create a setting using the app command
  def create(context, key, should)
    context.notice("Creating '#{key}' with #{should[:value]}")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe set #{key} #{should[:value]}")
    # Missing error handling. This is just for demo
    if status.success?
      true
    end
  end

  # update an existing setting using the app command
  def update(context, key, should)
    context.notice("Updating '#{key}' with #{should[:value]}")
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe set #{key} #{should[:value]}")
    # Missing error handling. This is just for demo
    if status.success?
      true
    end
  end

  # delete a setting using the app command
  def delete(context, key)
    context.notice("Deleting '#{key}'")
    # Missing error handling. This is just for demo
    stdout,stderr,status = Open3.capture3("/opt/app/bin/app.exe rm #{key}")
    if status.success?
      true
    end
  end
end


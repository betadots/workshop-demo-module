# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include project_d::app_config
class project_d::app_config {

  App_config {
    ensure => present,
  }
  app_config { 'loglevellllllllll':
    key    => 'loglevel',
    value  => 'debug',
  }
  app_config { 'user':
    value  => 'martin',
  }
  app_config { 'cachepath':
    value  => '/etc/app/cache',
  }

}

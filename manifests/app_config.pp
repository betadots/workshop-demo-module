# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include demo_module::app_config
class demo_module::app_config {

  $sorted_list = ['one', 'two'].sort
  notify { $sorted_list: }

  App_config {
    ensure => present,
  }
  app_config { 'loglevellllllllll':
    key   => 'loglevel',
    value => 'debug',
  }
  app_config { 'user':
    value => 'martin',
  }
  app_config { 'cachepath':
    value => '/etc/app/cache',
  }

}

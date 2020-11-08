app_config_2 { 'foo':
  ensure => present,
  value  => 'bar',
}
app_config_2 { 'foo2':
  ensure => absent,
}

class demo_module (
  String[1]    $username = 'demo',
  Stdlib::Fqdn $realserver = 'demo.domain.tld',
  Boolean      $manage_access = true,
){
  notify { "Configured user: ${username}": }
  notify { "Configured real server: ${realserver}": }
  if $manage_access {
    notify { 'We manage access': }
  } else {
    notify { 'NOT managing access': }
  }
}

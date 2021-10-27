plan demo_module::falschername (
  TargetSpec $servergruppe_1,
  TargetSpec $servergruppe_2,
  TargetSpec $servergruppe_3,
  String[1]  $dateiinhalt,
  Stdlib::Absolutepath $pfad,
){
  $version = run_task('enterprise_tasks::get_agent_version', $servergruppe_1)
  out::message($version)

  $kernel = run_task('facter_task', $servergruppe_2, 'fact' => 'kernel')
  out::message($kernel)

  # https://puppet.com/docs/bolt/latest/plan_functions.html#write-file
  # https://puppet.com/docs/pe/2019.8/plans_limitations.html
  # write_file ist in PE Plans nicht verfügbar
  #write_file($dateiinhalt, $pfad, $servergruppe_3)

  # https://puppet.com/docs/bolt/latest/applying_manifest_blocks.html#applying-manifest-blocks-from-a-puppet-plan
  apply($servergruppe_3, _catch_errors => true, _noop => false,) {
    file { $pfad:
      content => $dateiinhalt,
    }
  }
}

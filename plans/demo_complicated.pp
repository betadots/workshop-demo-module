#
# @summary workshop demo plan to cal a few tasks
#
# @param puppet_agent_group desired list of nodes where we collect the puppet agent version
# @param kernelversion_group node list where we will collect the fact
# @param file_group where we will create the awesome new file
# @param file_path the path to the awesome file
# @param file_content the content of the awesome file
# @param file_ensure desired state for awesome file
#
# @author <tim.meusel@betadots.de>
#
plan app1_example::demo_complicated (
  TargetSpec $puppet_agent_group,
  TargetSpec $kernelversion_group,
  TargetSpec $file_group,
  Stdlib::Absolutepath $file_path = '/tmp/spirit',
  String[1] $file_content = 'Hi!',
  Enum['file', 'absent'] $file_ensure = 'file',
) {
  $agent_results = run_task(
    'enterprise_tasks::get_agent_version',
    $puppet_agent_group,
    'Gather the Puppet Agent version',
  )
  # simple output
  # out::message($agent_results)

  # more beautiful:
  # https://www.puppet.com/docs/bolt/latest/bolt_types_reference.html#resultset
  if $agent_results.ok {
    $versions = $agent_results.results.map |$agent_result| { "${agent_result.target}: ${agent_result.value['version']}" }
    # requires https://github.com/voxpupuli/puppet-format
    $rows = $agent_results.results.map |$agent_result| { [$agent_result.target, $agent_result.value['version']] }
    out::message("Puppet versions are: ${versions}")
    $table = format::table(
      {
        title => 'Puppet Agent Versions',
        head  => ['Node', 'Version'],
        rows  => $rows,
        style => {width => 60 },
      }
    )
    out::message("\n${table}")
  } else {
    $errors = $agent_results.results.map |$agent_result| { "${agent_result.target}: ${agent_result.value['version']}" }
    fail('plan app1_example::workshop_plan: task enterprise_tasks::get_agent_version failed')
  }

  $kernel_results = run_task( 'facter_task', $kernelversion_group, 'Get the kernelversion fact', { 'fact' => 'kernelversion', })
  #out::message($kernel_results)
  $output = $kernel_results.results.map |$kernel_result| { $kernel_result.value['kernelversion'] }
  out::message(join($output, ', '))

  apply($file_group, '_description' => "manage ${file_path}") {
    file { $file_path:
      ensure  => $file_ensure,
      content => "${file_content}\n",
    }
  }

  $nodes_from_puppetdb = puppetdb_query('inventory[certname] {trusted.extensions.pp_role = "appserver"}')
  $target_hosts = $nodes_from_puppetdb.map |$r| { $r["certname"] }
  $plan_output = run_plan('enterprise_tasks::get_service_status', { 'service' => 'pxp-agent', 'target' => $target_hosts })
  out::message($plan_output)
}

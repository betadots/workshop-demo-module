# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include project_d
class demo_module {
  $bool = true
  $integer_1 = project_d::any2int($bool)
  notify { "Integer 1: ${integer_1}": }

  $string = 'foo'
  $integer_2 = project_d::any2int($string)
  notify { "Integer 2: ${integer_2}": }

  $maintenance_day = project_d::maintenance_day()
  notify { " Wartungtag: ${maintenance_day}": }

}


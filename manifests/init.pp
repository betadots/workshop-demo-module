# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include demo_module
class demo_module (
  Boolean   $bool = true,
  String[1] $string = 'foo',
){
  $integer_1 = demo_module::any2int($bool)
  notify { "Integer 1: ${integer_1}": }

  $integer_2 = demo_module::any2int($string)
  notify { "Integer 2: ${integer_2}": }

  $maintenance_day = demo_module::maintenance_day()
  notify { " Wartungtag: ${maintenance_day}": }

}


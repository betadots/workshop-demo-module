$result = demo_module::resolver('google.com')
notify { "google com to ip: ${result}": }

$result2 = demo_module::resolver('8.8.8.8')
notify { "IP 8888 to name: ${result2}": }

$result3 = demo_module::resolver()
notify { "no arg: localhost: ${result3}": }

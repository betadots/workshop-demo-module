$day = demo_module::maintenance_day()

notify { "Maintenance Day: ${day}": }

import 'default.pp'

exec { 
	'install beanstalkd':
    	command => '/usr/bin/apt-get -y install beanstalkd',
    	require => Exec['apt-get update'];

	# make sure beanstalkd is stopped - we will start it via supervisor
	"beanstalkd stop":
		command => '/etc/init.d/beanstalkd stop',
		require => Exec['install beanstalkd'];

	'install supervisor':
    	command => '/usr/bin/easy_install supervisor',
    	require => Exec['install python-setuptools'];
}

file { 
	'/etc/supervisor/conf.d/supervisord-beanstalkd.conf':
		ensure => file,
		source => '/vagrant/provision/files/supervisord-beanstalkd.conf',
		require => Exec['install supervisor'];
} 

service { 
	"supervisor stop":
		ensure => stopped,
		notify => Service['supervisor start'];

	"supervisor start":
		ensure => running,
		require => [
			Exec['beanstalkd stop'], 
			File['/etc/supervisor/conf.d/supervisord-beanstalkd.conf']
		];
}

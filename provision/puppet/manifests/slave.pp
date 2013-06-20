import 'default.pp'

exec { 
    'install libzmq-dev':
        command => '/usr/bin/apt-get -y install libzmq-dev';

    'install pyzmq':
        command => '/usr/bin/easy_install pyzmq',
        require => Exec['install libzmq-dev'];

    'install circus':
        command => '/usr/bin/pip install circus',
        require => Exec['install libzmq-dev', 'install python-pip', 'install pip-requirements', 'install pyzmq'];

    'install libevent-dev':
        command => '/usr/bin/apt-get -y install libevent-dev';

    'install circus-web':
        command => '/usr/bin/pip install circus-web',
        require => Exec['install libevent-dev', 'install python-pip', 'install circus'];

    'install pip-requirements':
        command => '/usr/bin/pip install -r /vagrant/provision/pip-requirements.txt',
        require => Exec['install python-pip'];
}

file { 
    '/etc/circus.ini':
        ensure => file,
        source => '/vagrant/provision/files/circus.ini',
        require => Exec['install circus'];

    '/etc/init/circus.conf':
        ensure => file,
        source => '/vagrant/provision/files/circus.conf',
        require => File['/etc/circus.ini'];
}

service { 'circus':
    ensure => running,
    require => File['/etc/init/circus.conf']
}
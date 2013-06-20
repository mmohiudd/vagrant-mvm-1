group { 'puppet':
    ensure => present,
}

exec { 
    'apt-get update': 
        command => '/usr/bin/apt-get update';

    'install gcc build-essential':
        command => '/usr/bin/apt-get -y install gcc build-essential';

    'install python-pip':
        command => '/usr/bin/apt-get -y install python-pip';

    'install python-dev':
        command => '/usr/bin/apt-get -y install python-dev';

    'install python-setuptools':
        command => '/usr/bin/apt-get -y install python-setuptools';

    'update hosts':
        command => '/vagrant/provision/shell/network.sh',
        require => File['/vagrant/provision/shell/network.sh'];

}

file { 
    '/vagrant/provision/shell/network.sh' :
        ensure => present,
        owner => "vagrant",
        group => "vagrant",
        mode => "0777",
        source => '/vagrant/provision/shell/network.sh';
}

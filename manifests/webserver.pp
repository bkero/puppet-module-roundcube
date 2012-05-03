class roundcube::webserver inherits roundcube {
    package { 'apache2':
        ensure => $roundcube::package_ensure
    }
    file {
        'vhost':
            content => template('roundcube/vhost.conf.erb'),
            name    => '/etc/apache2/sites-available/roundcube.conf',
            notify  => Service['apache2'],
            require => Package['apache2'];
        'vhost-enable':
            ensure  => link,
            name    => '/etc/apache2/sites-enabled/roundcube.conf',
            target  => '/etc/apache2/sites-available/roundcube.conf',
            mode    => '0644',
            require => File['vhost'];
    }

    service { 'apache2':
        ensure     => running,
        hasstatus  => true,
        hasrestart => true,
        enable     => true,
    }
}

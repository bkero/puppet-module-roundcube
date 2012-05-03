class roundcube::webserver inherits roundcube {
    package { 'apache':
        ensure => $roundcube::package_ensure
    }
    file {
        'vhost':
            content => template('puppet:///modules/roundcube/vhost.conf'),
            name    => '/etc/apache2/sites-available/roundcube.conf',
            require => Package['apache'];
        'vhost-enable':
            ensure  => link,
            name    => '/etc/apache2/sites-enabled/roundcube.conf',
            target  => '/etc/apache2/sites-available/roundcube.conf',
            mode    => '0644',
            require => File['vhost'];
    }
}

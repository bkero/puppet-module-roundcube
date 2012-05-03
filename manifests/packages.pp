class roundcube::packages inherits roundcube {
    package { 'roundcube': ensure => $roundcube::package_ensure }
    if $roundcube::plugins == true {
        package { 'roundcube-plugins':
            ensure => $roundcube::package_ensure
        }
    }
    if $roundcube::extras == true {
        package { 'roundcube-plugins-extra':
            ensure => $roundcube::package_ensure
        }
    }
    if $roundcube::db_backend == 'mysql' {
        package { ['mysql-server', 'roundcube-mysql', 'php-mdb2-driver-mysql']:
            ensure => $roundcube::package_ensure
        }
    }
    if $roundcube::db_backend == 'pgsql' {
        package { ['postgresql', 'roundcube-pgsql', 'php-mdb2-driver-pgsql']:
            ensure => $roundcube::package_ensure
        }
    }

    if $roundcube:;db_backend == 'sqlite' {
        package { 'php-mdb2-driver-sqlite']:
            ensure => $roundcube::package_ensure
        }
    }
}

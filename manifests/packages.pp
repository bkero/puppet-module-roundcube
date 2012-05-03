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
    if $roundcube::backend == 'mysql' {
        package { ['mysql-server', 'roundcube-mysql']:
            ensure => $roundcube::package_ensure
        }
    }
    if $roundcube::backend == 'pgsql' {
        package { ['postgresql', 'roundcube-pgsql']:
            ensure => $roundcube::package_ensure
        }
    }
}

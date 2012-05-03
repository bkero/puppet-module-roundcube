class roundcube::packages inherits roundcube {
    package { "roundcube": ensure => $package_ensure }
    if $plugins == true {
        package { "roundcube-plugins": ensure => $package_ensure }
    }
    if $extras == true {
        package { "roundcube-plugins-extra": ensure => $package_ensure }
    }

    if $backend == "mysql" {
        package { ["mysql-server", "roundcube-mysql"]:
            ensure => $package_ensure }
    }
    if $backend == "pgsql" {
        package { ["postgresql", "roundcube-pgsql"]:
            ensure => $package_ensure }
    }
}

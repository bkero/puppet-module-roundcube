# Class: roundcube
#
# This module manages roundcube
#
# Parameters:
#   backend: Database backend to use: sqlite, mysql, pgsql (default: sqlite)
#   plugins: Boolean to include roundcube plugins (default: false)
#   extras: Boolean to include roundcube extra plugins (default: false)
#   manage_http: Boolean to manage a http service (default: true)
#   autoupdate: Boolean to automatically update (default: false)
#
# Actions:
#   Installs, configures, and manages roundcube webmail service
#       (and optionally a http service beneath)
#
# Requires:
#
# Sample Usage:
#   Simple usage:
#   class { "roundcube" }
#
#   Complex usage:
#   class { "roundcube":
#       backend => "pgsql",
#       db_hostname => "localhost",
#       db_username => "roundcube",
#       db_password => "hunter2",
#       autoupdate  => true,
#       plugins     => true,
#       extras      => true,
#       manage_http => false,
#       
#
# [Remember: No empty lines between comments and class definition]
class roundcube($backend="sqlite",
                $plugins=false,
                $extras=false,
                $manage_http=true,
                $ensure="running",
                $autoupdate=false,
                $db_hostname="UNSET",
                $db_username="UNSET",
                $db_password="UNSET",
    )
{

        # Parameter checking
    if ! ($ensure in ['running', 'stopped']) {
        fail("ensure parameter must be running or stoppd")
    }
    if $autoupdate == true {
        $package_ensure = latest
    } elsif $autoupdate == false {
        $package_ensure = present
    } else {
        fail("autoupdate parameter must be true or false")
    }

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

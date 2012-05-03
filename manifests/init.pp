# Class: roundcube
#
# This module manages roundcube
#
# Parameters:
#   db_backend: Database backend to use: sqlite, mysql, pgsql (default: sqlite)
#   plugins: Boolean to include roundcube plugins (default: false)
#   extras: Boolean to include roundcube extra plugins (default: false)
#   manage_http: Boolean to manage a http service (default: true)
#   autoupdate: Boolean to automatically update (default: false)
#
# Optional database parameters (only if not using sqlite)
#   db_username: Database username    (default: roundcube)
#   db_password: Database password    (default: UNSET)
#   db_dbname  : Database name        (default: roundcube)
#   db_hostname: Database hostname    (default: localhost)
#   db_basepath: Database basepath    (default: "")
#   db_port    : Database port number (default: 3306)
#
# Optional webserver parameters (only useful with manage_http => true)
#   server_name: String to enter a vhost servername (default: mail.bke.ro)
#   server_port: Port to listen on (default: 80)
#
#   NOTE: All parameters are optional
#
# Actions:
#   Installs, configures, and manages roundcube webmail service
#       (and optionally a http service beneath)
#
# Requires:
#
# Sample Usage:
#   Simple usage:
#   class { 'roundcube' }
#
#   Complex usage:
#   class { 'roundcube':
#       db_backend => 'pgsql',
#       db_hostname => 'localhost',
#       db_username => 'roundcube',
#       db_dbname   => 'roundcube',
#       db_password => 'hunter2',
#       autoupdate  => true,
#       plugins     => true,
#       extras      => true,
#       manage_http => false,
#
# [Remember: No empty lines between comments and class definition]
class roundcube($plugins=false,
                $extras=false,
                $manage_http=true,
                $autoupdate=false,
                $db_backend='sqlite',
                $db_hostname='UNSET',
                $db_username='UNSET',
                $db_password='UNSET',
                $db_basepath='',
                $db_dbname='roundcube',
                $db_port='3306',
                $server_name='mail.bke.ro',
                $server_port='80'
    )
{
    include roundcube::packages

    if $roundcube::manage_http == true {
        include roundcube::webserver
    }

        # Parameter checking
    if $roundcube::autoupdate == true {
        $package_ensure = latest
    } elsif $roundcube::autoupdate == false {
        $package_ensure = present
    } else {
        fail('autoupdate parameter must be true or false')
    }

    file { 'db.inc.php':
        ensure  => present,
        name    => '/etc/roundcube/db.inc.php',
        content => template('roundcube/db.inc.php.erb'),
    }
}

    
# Install Apache
Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/sbin"}
exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
# make sure apt-update run before package
Exec["apt-update"] -> Package <| |>

include wpconfiguration
include apache
include database
include wordpress

# Puppet file intended to install server componenets for FiveFilters.org web services
# This file is intended for base images of:
# Ubuntu 20.04
# On a *new* Ubuntu 20.04 server instance (Hetzner Cloud/Linode/Digital Ocean, etc.):
# > apt-get update
# > apt-get install puppet
# > puppet apply ubuntu-20.04.pp
$document_root = '/vagrant'
    # You can change the values of these variables
    # according to your preferences
    
# Install Apache
Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/sbin"}
exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
# make sure apt-update run before package
Exec["apt-update"] -> Package <| |>
# password :tvxJ*(FIaUw0(ADFZB
#admin
#admin@example.com
include apache
include database
include wordpress



# Puppet file intended to install server componenets for FiveFilters.org web services
# This file is intended for base images of:
# Ubuntu 20.04
# On a *new* Ubuntu 20.04 server instance (Hetzner Cloud/Linode/Digital Ocean, etc.):
# > apt-get update
# > apt-get install puppet
# > puppet apply ubuntu-20.04.pp
$document_root = '/vagrant'
include apache



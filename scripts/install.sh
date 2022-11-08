#!/bin/bash
command -v puppet > /dev/null && { echo "Puppet is installed! skipping" ; exit 0; }
echo "Let's download the DEB file"
wget https://apt.puppetlabs.com/puppet6-release-$(lsb_release -cs).deb
echo "File downloaded!"
dpkg -i puppet6-release-$(lsb_release -cs).deb
echo "File installed"
echo "Update system"
apt-get update
echo "Install puppet agent"
apt-get install -y puppet
#puppet module install puppetlabs-apache
#puppet module install puppetlabs-mysql
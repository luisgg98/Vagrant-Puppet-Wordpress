Vagrant.configure("2") do |config|
    # Vagrant tutorial
    # HOW TO UNDERSTAND THIS FILE
    # https://javiermartinalonso.github.io/devops/devops/vagrant/2018/02/09/vagrant-vagrantfile.html

	
	config.vm.define "web" do |web|
		web.vm.box = "bento/ubuntu-20.04"
		
		#web.vm.network "forwarded_port", guest: 80, host: 8080
		web.vm.hostname = 'actividadWordpress'
		web.vm.network "private_network", ip: "192.168.33.10"
		
		web.vm.network "public_network"

		web.vm.synced_folder "./backup", "/vagrant_data", create: true
		# Example puppet-wordpress
		# https://github.com/example42/puppet-wordpress
		# https://github.com/adullact/puppet-wordpress

		web.vm.provider "virtualbox" do |vb|
			vb.memory = "2048"
		end

		####### Install Puppet Agent #######
		web.vm.provision "shell", path: "./scripts/install.sh"
		####### Provision #######
		#web.vm.provision :shell do |shell|
		#	shell.inline = "mkdir -p /etc/puppet/modules;
		#					puppet module install puppetlabs-apache"
		#end
		
		# Puppet Provisioner
		# https://developer.hashicorp.com/vagrant/docs/provisioning/puppet_apply
		web.vm.provision "puppet" do |puppet|
			puppet.module_path = "modules"    
			#module_path (string or array of strings) - Path or paths, on the host, to the directory which contains Puppet modules, if any.
			puppet.options = "--verbose --debug"
			puppet.manifests_path = "manifests"   # Default
			puppet.manifest_file = "default.pp"   # Default
			#puppet.module_path = "~/.puppet/modules"
		end
	end
	

end
class apache {
      # Install Apache
  Exec { path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/sbin"}

  exec { 'apt-update':
    command => '/usr/bin/apt-get update'
  }
  # make sure apt-update run before package
  Exec["apt-update"] -> Package <| |>

  package { 'apache2':
    ensure => installed,
  }
  service { 'apache2':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/apachectl configtest && /usr/sbin/service apache2 reload",
  } 

  exec { "enable-mod_rewrite":
		require => Package["apache2"],
		before => Service["apache2"],
		#command => "/usr/sbin/a2enmod rewrite",
		command => "a2enmod rewrite",
	}

	file { "/etc/apache2/mods-available/mpm_prefork.conf":
		ensure => present,
		content => "<IfModule mpm_prefork_module>
        StartServers                     5
        MinSpareServers           5
        MaxSpareServers          10
        MaxRequestWorkers         80
        MaxConnectionsPerChild   0
</IfModule>",
		require => Package["apache2"],
		notify => Exec["restart-apache"]
	}
	
	exec { "enable-prefork":
		require => Package["apache2"],
		command => "a2dismod mpm_event && a2enmod mpm_prefork",
	}

  exec { "restart-apache":
		command => "service apache2 restart",
		require => Package["apache2"],
		refreshonly => true
	}


  # Add support for PHP 
  package {
    "php": ensure => latest 
  }
  package { 
    "php-mysql": ensure => latest 
  }

  package { 
    "libapache2-mod-php": ensure => latest,
  	require => Package["apache2"],
		notify => Exec["restart-apache"] 
  }

  #php libapache2-mod-php php-mysql
}

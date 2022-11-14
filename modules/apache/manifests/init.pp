class apache {

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
		command => "a2enmod rewrite",
	}

  file { "/etc/apache2/sites-available/wordpress.conf":
		ensure => present,
		content => "<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress/
    <Directory /srv/www/wordpress/>
        Options FollowSymLinks
        AllowOverride Limit Options FileInfo
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>",
		require => [Package["apache2"], Service["apache2"]],
		before => Exec["enable-wordpress-site"],
		notify => Exec["restart-apache"]
	}

  exec { "enable-wordpress-site":
		require => Package["apache2"],
		command => "a2ensite wordpress && a2dissite 000-default",
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
    "php-curl": ensure => latest 
  }
  package { 
    "php-bcmath": ensure => latest 
  }
  package { 
    "php-intl": ensure => latest 
  }
  package { 
    "php-json": ensure => latest 
  }
  package { 
    "php-imagick": ensure => latest 
  }
  package {
    "php-mbstring": ensure => latest 
  }
  package {
    "php-xml": ensure => latest 
  }
  package {
    "php-zip": ensure => latest 
  }

  package { 
    "libapache2-mod-php": ensure => latest,
  	require => Package["apache2"],
		notify => Exec["restart-apache"] 
  }

}

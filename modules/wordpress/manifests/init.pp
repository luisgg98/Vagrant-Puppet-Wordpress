class wordpress {

    # Copy the Wordpress bundle to /tmp
    exec{
      "Create folder":
      command => "mkdir -p /srv/www/"
    }


    # Copy to /srv/www/wordpress/
    exec { 'copy':
        command => "curl https://wordpress.org/latest.tar.gz | tar zx -C /srv/www"
    }

    # Generate the wp-config.php file using the template
    file { '/srv/www/wordpress/wp-config.php':
        ensure => present,
        require => Exec['copy'],
        content => template("wordpress/wp-config.php.erb")
    }
    exec{
      "Change owner":
      command => "chown -R www-data: /srv/www && chmod 755 -R ."
    }
}

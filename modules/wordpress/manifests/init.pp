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
    
    file { '/srv/www/wordpress/wp-config.php':
        ensure => present,
        require => Exec['copy'],
        content => template("wordpress/wp-config.php.erb")
    }
    exec{
      "Change owner":
      command => "chown -R www-data: /srv/www && chmod 755 -R ."
    }

    exec{
      "Install WP CLI":
      command => "curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp"
    }

    exec{
      "Configure Wordpress with WP CLI":
      command => "wp core install --url='http://127.0.0.1' --title='Herramientas de automatización de despliegues: Luis Garcia' --admin_user='${wpconfiguration::admin_user}' --admin_password='${wpconfiguration::admin_pass}' --admin_email='${wpconfiguration::admin_mail}' --allow-root --path='/srv/www/wordpress'"
    }

}

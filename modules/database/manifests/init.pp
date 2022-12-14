class database {
  # Add support for MySQL
  package{
    "mysql-server": ensure => latest 
  }
  package {
    "mysql-client":ensure => latest 
  }
  # Set the root password
  exec { 'Create database and grant access': #CREATE DATABASE wordpress;
    command => "mysql -u root -e \"CREATE DATABASE wordpress; CREATE USER ${wpconfiguration::db_user}@${wpconfiguration::db_host} IDENTIFIED BY '${wpconfiguration::db_user_password}'; GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER ON ${wpconfiguration::db_name}.* TO ${wpconfiguration::db_user}@${wpconfiguration::db_host}; FLUSH PRIVILEGES;\"",
    require => Package["mysql-server"]
  }
  
  service { 'mysql':
    ensure => running,
    enable => true,
    hasstatus  => true,
    restart => "/usr/sbin/service mysql restart",
  } 

}



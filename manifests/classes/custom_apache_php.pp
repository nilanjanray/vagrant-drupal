class custom_apache_php {
  include stdlib
  #include apache
  class { 'apache':
    mpm_module => 'prefork',
    default_vhost => false,
  }
  
  include apache::mod::rewrite
  # If need to open any extra port we can do it from below syntax.
  # apache::listen { '8081': }  

  $dir = 'app/drupalroot/web'
  #$drupaldir = 'www'

  exec { 'mkdir_cert_dir':
    command => "mkdir -p /opt/${dir}",
    unless  => "test -d /opt/${dir}",
  }

  file { "/srv/www":
    ensure => "directory",
  }

  # Ensure to create soft-link.
  file { '/srv/www/drupal':
    ensure => 'link',
    target => '/opt/app/drupalroot',
  }
  
  # create log directory.
  file { "/srv/www/drupal/log":
    ensure => "directory",
  }

  # create error log.
  file { "/srv/www/drupal/log/drupal_error.log":
    ensure => "present",
  }


  $docroot = '/srv/www/drupal/web'
  $scriptalias          = '/usr/lib/cgi-bin'

  apache::vhost { 'drupal':
    port => 8081,
    docroot => $docroot,
    scriptalias => $scriptalias,
    serveradmin => $serveradmin,
    override => "All",
    error_log => true,
    access_log => true,
    #error_log_file => $error_log_file,
    #access_log_file => $access_log_file,
    #priority => '15',
  }



  class {'apache::mod::php':
    require => Package["php5"]
  }
  
  package { php5:
    ensure => installed,
  }
	
  package { php5-cli:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-common:
    ensure => installed,
    require => Package["php5"]
  }
}

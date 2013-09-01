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
  $project_dir = 'www'

  exec { 'mkdir_cert_dir':
    command => "mkdir -p /opt/${dir}",
    unless  => "test -d /opt/${dir}",
  }

  file { "/srv/${project_dir}":
    ensure => "directory",
  }

  # Ensure to create soft-link.
  file { '/srv/www/drupal':
    ensure => 'link',
    target => '/opt/app/drupalroot',
  }
  
  # Setup apache virtual host.
  
  $docroot = '/srv/www/drupal/web'
  $scriptalias = '/usr/lib/cgi-bin'

  apache::vhost { 'drupal':
    serveraliases => [
    'dev.drupal-mind.org',
    ],
    port => 8081,
    docroot => $docroot,
    scriptalias => $scriptalias,
    serveradmin => $serveradmin,
    override => "All",
    error_log => true,
    access_log => true,
    #priority => '15',
  }

  include php_fix

}

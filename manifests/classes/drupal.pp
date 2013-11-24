class drupal {
  #Drush installation using pear.
  include drush
  #Some pear packages.
  exec { "pear upgrade --force Console_Getopt":
    command => "pear upgrade --force Console_Getopt",
    user=> root,
    require => [Package['php-pear']]
  }
  exec { "pear upgrade --force pear":
    command => "pear upgrade --force pear",
    user => root,
    require => [Package['php-pear']]
  }
  exec { "pear upgrade-all":
    command => "pear upgrade-all",
    user => 'root',
    require => [Package['php-pear']]
  }

  #exec { 'chown -R vagrant. /srv/www/drupal':
   # command => 'chown -R vagrant. /srv/www/drupal',
    #user => 'root'
  #}

  #exec { "rm -rf /srv/www/drupal/web":
   # command => "rm -rf /srv/www/drupal/web",
    #user => 'root',
  #}


  #Execution & Installation of drush.
  drush::exec { 'drush-drupal-download':
    command        => 'dl --drupal-project-rename=drop1 drupal --destination=/srv/www/drupal/web',
    #root_directory => '/srv/www/drupal',
  }
  
  #Change Owner ship to apache
  file { "/srv/www/drupal/web/drop1/sites/default" : 
    ensure => directory,
    group => "www-data",
    owner => "www-data",
    recurse => true,     
  }
}

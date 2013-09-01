class php_fix {

  package { php5:
    ensure => installed,
  }
  package { php5-mysql:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-imap:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-gd:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-dev:
    ensure => installed,
    require => Package["php5"]
  }
  package { php-pear:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-curl:
    ensure => installed,
    require => Package["php5"]
  }
  
  package { php5-memcache:
    ensure => installed,
    require => Package["php5"]
  }
 
  package { php-apc:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-cli:
    ensure => installed,
    require => Package["php5"]
  }
  package { php5-common:
    ensure => installed,
    require => Package["php5"]
  }

  class {'apache::mod::php':
    require => Package["php5"]
  }


  augeas { 'php-config':
    context => '/files/etc/php5/apache2/php.ini/PHP',
    changes => [
      'set date.timezone UTC',
      'set short_open_tag Off',
      'set memory_limit 256M',
      'set max_execution_time 60',
      'set error_reporting E_ALL | E_STRICT',
      'set display_errors On',
      'set display_startup_errors On',
      'set post_max_size 32M',
      'set upload_max_filesize 32M'
    ],
    require => Package['php5'],
    notify => Service['apache2']
  }

}

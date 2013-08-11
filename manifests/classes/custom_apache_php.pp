class custom_apache_php {
  include apache
  class {'apache::mod::php':
    require => Package["php5"]
  }
  apache::loadmodule{'rewrite':}
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

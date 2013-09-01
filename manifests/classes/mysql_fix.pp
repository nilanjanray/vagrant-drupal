class mysql_fix {
  include mysql

  class { 'mysql::server':
    config_hash => { 'root_password' => 'root' }, 
  }

  mysql::db { 'drupal_db':
    user     => 'root',
    password => 'root',
    host     => 'localhost',
    grant    => ['all'],
  }
}

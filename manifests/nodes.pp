node 'vagrant.local' {
  include custom_apache_php
  include curl
  include mysql_fix
  include drupal
  include git_fix
}

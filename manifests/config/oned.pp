# Class: nebula::config::oned
#
#
class nebula::config::oned (
    $config_path = '/etc/one/oned.conf',
    $db_backend = 'sqlite',
    $db_host = undef,
    $db_port = undef,
    $db_user = undef,
    $db_password = undef,
    $db_name = undef,
    ) {


  file { $config_path:
      ensure  => file,
      content => template('nebula/config/oned.conf.erb'),
      require => Package['opennebula', 'opennebula-sunstone'],
  }

}
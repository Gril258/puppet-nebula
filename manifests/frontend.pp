# Class: nebula::frontend
#
#
class nebula::frontend (
    $db_backend     = 'sqlite',
    $db_host        = undef,
    $db_port        = undef,
    $db_user        = undef,
    $db_password    = undef,
    $db_name        = undef,
    $start_password = 'nebulastarterpassword',
){


  package { 'opennebula':
    ensure  => installed,
    require => Class['nebula::repo']
  }

  package { 'opennebula-sunstone':
    ensure  => installed,
    require => Class['nebula::repo']
  }

  package { 'opennebula-gate':
    ensure  => installed,
    require => Class['nebula::repo']
  }

  package { 'opennebula-flow':
    ensure  => installed,
    require => Class['nebula::repo']
  }

  file { '/var/lib/one/.one/one_auth':
    ensure  => file,
    content => "oneadmin:${start_password}",
    require => Package['opennebula', 'opennebula-sunstone'],
  }

  class { 'nebula::config::oned':
    db_backend  => $db_backend,
    db_host     => $db_host,
    db_port     => $db_port,
    db_user     => $db_user,
    db_password => $db_password,
    db_name     => $db_name,
  }

  service { 'opennebula':
      ensure  => running,
      enable  => true,
      #hasrestart => true,
      #hasstatus  => true,
      require => Class['nebula::config::oned'], File['/var/lib/one/.one/one_auth']],
  }

  service { 'opennebula-sunstone':
      ensure  => running,
      enable  => true,
      #hasrestart => true,
      #hasstatus  => true,
      require => [Class['nebula::config::oned'],File['/var/lib/one/.one/one_auth']],
  }


}
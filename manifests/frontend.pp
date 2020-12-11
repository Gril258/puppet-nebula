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


  File <| name == '/var/lib/one/.ssh/known_hosts' |> {
      owner  => 'oneadmin',
      group  => 'oneadmin',
  }

  @@sshkey { "${::fqdn}-nebula":
    type         => ecdsa-sha2-nistp256,
    host_aliases => [ $::ipaddress, $::hostname, $::fqdn ],
    key          => $::sshecdsakey,
    target       => '/var/lib/one/.ssh/known_hosts',
    require      => Package['opennebula-node'],
    tag          => [ 'sshkey-nebula-for-kvm' ],
  }

  Sshkey <<| tag == 'sshkey-nebula-node'|>>

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
      require => [Class['nebula::config::oned'], File['/var/lib/one/.one/one_auth']],
  }

  service { 'opennebula-sunstone':
      ensure  => running,
      enable  => true,
      #hasrestart => true,
      #hasstatus  => true,
      require => [Class['nebula::config::oned'],File['/var/lib/one/.one/one_auth']],
  }


}
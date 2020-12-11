# Class: nebula::node
#
# TODO
class nebula::node (
  $node_type,
    ){

  @@sshkey { "${::fqdn}-nebula-node":
    type         => ecdsa-sha2-nistp256,
    host_aliases => [ $::ipaddress, $::hostname, $::fqdn ],
    key          => $::sshecdsakey,
    target       => '/var/lib/one/.ssh/known_hosts',
    require      => Package['opennebula'],
    tag          => [ 'sshkey-nebula-node' ],
  }

  case $node_type {
    'kvm': {
      package { 'opennebula-node':
          ensure => installed,
      }
    }
    default: {
      fail("unsupported node type ${node_type}")
    }
  }
}
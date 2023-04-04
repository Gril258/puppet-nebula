# Class: nebula::repo
#
#
class nebula::repo (
  $version,
  ) {

  case $::operatingsystem {
    'debian': {
      case $::lsbdistcodename {
        'bullseye': {
          apt::source { 'opennebula':
            location => "https://downloads.opennebula.io/repo/${version}/Debian/11",
            release  => 'stable',
            repos    => 'opennebula',
            pin      => '600',
            key      => {
              id     => '0B2D385C7C9304B11A0367B905A05927906DC27C',
              source => 'https://downloads.opennebula.io/repo/repo2.key',
            },
          }
        }
        'buster': {
          apt::source { 'opennebula':
            location => "https://downloads.opennebula.io/repo/${version}/Debian/10",
            release  => 'stable',
            repos    => 'opennebula',
            pin      => '600',
            key      => {
              id     => '0B2D385C7C9304B11A0367B905A05927906DC27C',
              source => 'https://downloads.opennebula.io/repo/repo2.key',
            },
          }
        }
        'stretch': {
          apt::source { 'opennebula':
            location => "https://downloads.opennebula.io/repo/${version}/Debian/9",
            release  => 'stable',
            repos    => 'opennebula',
            pin      => '600',
            key      => {
              id     => '0B2D385C7C9304B11A0367B905A05927906DC27C',
              source => 'https://downloads.opennebula.io/repo/repo2.key',
            },
          }
        }
        default: {
          fail('unsupported major release')
        }
      }
    }
    default: {
      fail('unsupported operatingsystem')
    }
  }
}

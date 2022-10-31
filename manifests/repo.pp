# Class: nebula::repo
#
#
class nebula::repo (
  $version,
  ) {

  case $::operatingsystem {
    'debian': {
      case $::lsbdistcodename {
        'buster': {
          apt::source { 'opennebula':
            location => "https://downloads.opennebula.io/repo/${version}/Debian/10",
            release  => 'stable',
            repos    => 'opennebula',
            pin      => '600',
            key      => {
              id     => '92B77188854CF23E1634DA89592F7F0585E16EBF',
              source => 'https://downloads.opennebula.io/repo/repo.key',
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
              id     => '92B77188854CF23E1634DA89592F7F0585E16EBF',
              source => 'https://downloads.opennebula.io/repo/repo.key',
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

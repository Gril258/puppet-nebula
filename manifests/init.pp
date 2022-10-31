# Class: nebula
#
#
class nebula (
  $version = '5.12',
) {

  class {'nebula::repo':
    version => $version,
  }

}

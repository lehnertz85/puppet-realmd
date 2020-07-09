# Class: realmd::install
#
#
class realmd::install {

  if !defined(Exec['/usr/bin/apt-get update']) {
    exec { '/usr/bin/apt-get update':
      refreshonly => true,
    }
  }
  
  if !defined(Package['adcli']) {
    package { 'adcli':
      ensure  => installed,
      require => Exec['/usr/bin/apt-get update'],
    }
  }

  if !defined(Package['sssd']) {
    package { 'sssd':
      ensure  => installed,
      require => Exec['/usr/bin/apt-get update'],
    }
  }

  if !defined(Package['sssd-tools']) {
    package { 'sssd-tools':
      ensure  => installed,
      require => Exec['/usr/bin/apt-get update'],
    }
  }

  if !defined(Package['samba-common']) {
    package { 'samba-common':
      ensure  => installed,
      require => Exec['/usr/bin/apt-get update'],
    }
  }

  if !defined(Package['realmd']) {
    package { 'realmd':
      ensure  => installed,
      require => Exec['/usr/bin/apt-get update'],
    }
  }
}
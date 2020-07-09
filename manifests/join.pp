# Class: realmd::join
#
#
class realmd::join (
    $desktop = false,
  ){

  exec { 'joinad':
    command      => '/bin/echo <your_join_users_password> | /usr/sbin/realm --verbose join <your_domain> -U <your_joined_users_username>',
    path         => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    creates      => '/etc/krb5.keytab'
  }
  ->
  file { '/etc/sssd/sssd.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/realmd/sssd.conf',
  }

  if $desktop {
    if !defined(Service['lightdm']) {
      service { 'lightdm':
        subscribe   => [File['/etc/security/group.conf'],
                        File['/etc/lightdm/lightdm.conf']
                       ],
      } # end service
    } # end if
  } # end if

  if !defined(Service['sssd']) {
      service { 'sssd':
        subscribe   => File['/etc/sssd/sssd.conf'],
      }
  }
}
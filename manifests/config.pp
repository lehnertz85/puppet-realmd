# Class: realmd::config
#
#
class realmd::config (
    $desktop = false,
  ){

  # Add Domain Controllers to hosts file on each host (DC1,DC2)
  file { '/etc/hosts':
    ensure  => present,
    content => template('realmd/hosts.erb'),
  }
  ->
  file { '/etc/realmd.conf':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/realmd/realmd.conf',
  }
  ->
  file { '/etc/security/group.conf':
    ensure  => present,
    source  => 'puppet:///modules/realmd/group.conf',
  }
  ->
  # Allow AD users to create home folders.
  file { '/etc/pam.d/common-session':
    ensure  => present,
    source  => 'puppet:///modules/realmd/common-session',
  }
  ->
  # Create private folder, otherwise the join with fail.
  file { '/var/lib/samba/private/':
    ensure  => directory,
  }

  if $desktop {
    # Edit gnome login settings
    file { '/etc/lightdm/lightdm.conf':
      ensure  => present,
      source  => 'puppet:///modules/realmd/lightdm.conf',
    }

    if !defined(Service['lightdm']) {
      service { 'lightdm':
        subscribe   => [File['/etc/security/group.conf'],
                        File['/etc/lightdm/lightdm.conf']
                       ],
      } # end service
    } # end if
  } #end if
}
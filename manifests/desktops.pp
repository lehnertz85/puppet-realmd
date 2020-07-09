# == Class: realmd:desktop
#
# This module is used to join Debian 8 to Active Directory.
# Realmd is installed on Debian 8 by default
#
#
# === Parameters
# desktop - if true, then all config files and services related to a desktop
# environment will installed or restarted.
#
# === Authors
#
#
class realmd::desktop {

  class { 'realmd':
    desktop => true,
  }
  
}
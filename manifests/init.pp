# == Class: realmd
#
# This module is used to join Debian 8 to Active Directory.
# Realmd is installed on Debian 8 by default
#
#
# === Parameters
#
#
# === Authors
#
# 
class realmd (
    $desktop = false,
  ){
  
  anchor { 'realmd::begin': }

  ->

  class { 'realmd::install': }

  ->

  class { 'realmd::config': 
    desktop => $desktop,
  }

  ->

  class { 'realmd::join':
    desktop => $desktop,
  }

  ->

  anchor { 'realmd::end': }
}
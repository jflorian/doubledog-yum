#
# == Define: yum::repo_package
#
# Manages a repository configuration indirectly via packaging.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-yum Puppet module.
# Copyright 2015-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define yum::repo_package (
        String                  $arch,
        String                  $dist,
        String                  $rel,
        String                  $uri,
        String                  $ver,
        Ddolib::File::Ensure    $ensure='present',
    ) {

    include '::yum'

    case $ensure {

        'absent', false: {

            package { $name:
                ensure => absent,
            }

        }

        default: {

            if $ver  > '' { $v = "-${ver}" }  else { $v = '' }
            if $rel  > '' { $r = "-${rel}" }  else { $r = '' }
            if $dist > '' { $d = ".${dist}" } else { $d = '' }
            if $arch > '' { $a = ".${arch}" } else { $a = '' }

            exec { "${::yum::tool} -y install ${uri}/${name}${v}${r}${d}${a}.rpm":
                unless => "rpm -q ${name}",
            }

        }

    }

}

# modules/yum/manifests/repo_package.pp
#
# == Define: yum::repo_package
#
# Manages a YUM repository configuration via package.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   Name of the repository package.
#
# [*arch*]
#   Architecture of the repository package.  E.g., 'noarch'. Required, but may
#   be ''.
#
# [*dist*]
#   Distribution tag of the repository package.  E.g., 'fc20'.  Required, but
#   may be ''.
#
# [*rel*]
#   Release number of the repository package.  E.g., '1'.  Required, but may
#   be ''.
#
# [*uri*]
#   The URI for obtaining the repository package.  Must be one supported by
#   the 'yum install' command.  This should include everything from the
#   protocol up to, but not including, the file name.
#
# [*ver*]
#   Version number of the repository package.  E.g., '20'.  Required, but may
#   be ''.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015 John Florian


define yum::repo_package (
        $uri,
        $ver,
        $rel,
        $dist,
        $arch,
        $ensure='present',
    ) {

    case $ensure {

        'absent': {

            package { $name:
                ensure => absent,
            }

        }

        default: {

            if $ver  > '' { $v = "-${ver}" }  else { $v = '' }
            if $rel  > '' { $r = "-${rel}" }  else { $r = '' }
            if $dist > '' { $d = ".${dist}" } else { $d = '' }
            if $arch > '' { $a = ".${arch}" } else { $a = '' }

            exec { "${::yum::params::tool} -y install ${uri}/${name}${v}${r}${d}${a}.rpm":
                unless  => "rpm -q ${name}",
            }

        }

    }

}

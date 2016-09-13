# modules/yum/manifests/params.pp
#
# == Class: yum::params
#
# Parameters for the yum puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2013-2016 John Florian

class yum::params {

    case $::operatingsystem {

        'CentOS': {

            $tool = 'yum'
            $yum_conf_target = '/etc/yum.conf'

        }

        'Fedora': {

            $tool = 'dnf'
            $yum_conf_target = undef

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}

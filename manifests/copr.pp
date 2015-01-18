# modules/yum/manifests/copr.pp
#
# == Class: yum::copr
#
# Manages the copr plugin for yum on a host.
#
# === Parameters
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class yum::copr (
        $ensure='present',
    ) {

    include 'yum::params'

    if $ensure != 'absent' and $yum::params::copr_packages == undef {
        fail "no copr plugin available for ${::operatingsystem} ${::operatingsystemrelease}"
    }

    package { $yum::params::copr_packages:
        ensure => $ensure,
    }

}

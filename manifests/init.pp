#
# == Class: yum
#
# Manages yum/dnf on a host.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-yum Puppet module.
# Copyright 2010-2021 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class yum (
        Optional[Boolean]               $best,
        Optional[String[1]]             $bugtracker_url,
        Optional[String[1]]             $cachedir,
        Optional[Boolean]               $clean_requirements_on_remove,
        Optional[String[1]]             $conf_target,
        Optional[Integer[0, 10]]        $debuglevel,
        Optional[String[1]]             $distroverpkg,
        Optional[Integer[0, 1]]         $gpgcheck,
        Optional[Integer[0]]            $installonly_limit,
        Optional[Integer[0, 1]]         $keepcache,
        Optional[Integer[0, 1]]         $plugins,
        Optional[String[1]]             $proxy,
        Enum['dnf', 'yum']              $tool,
        Optional[Array[String[1], 1]]   $unwanted_packages,
    ) {

    if $conf_target {
        file { $conf_target:
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            seluser => 'system_u',
            selrole => 'object_r',
            seltype => 'etc_t',
            content => epp('yum/main.conf.epp'),
        }
    }

    ::yum::remove { $unwanted_packages: }

}

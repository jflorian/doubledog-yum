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
# Copyright 2010-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class yum (
        Optional[String[1]]             $conf_target,
        Optional[String[1]]             $content,
        Optional[String[1]]             $source,
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
            content => $content,
            source  => $source,
        }
    }

    ::yum::remove { $unwanted_packages: }

}

#
# == Define: yum::repo_file
#
# Manages a repository configuration file directly.
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


define yum::repo_file (
        Optional[String[1]]     $content=undef,
        Ddolib::File::Ensure    $ensure='present',
        Optional[String[1]]     $filename=$title,
        Optional[String[1]]     $source=undef,
    ) {

    file { "/etc/yum.repos.d/${filename}.repo":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'system_conf_t',
        content => $content,
        source  => $source,
    }

}

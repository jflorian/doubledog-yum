#
# == Define: yum::plugin_conf
#
# Manages a configuration file for a plugin.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-yum Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define yum::plugin_conf (
        Optional[String[1]]             $content=undef,
        Ddolib::File::Ensure            $ensure='present',
        Optional[String[1]]             $filename="${title}.conf",
        Optional[Stdlib::FileSource]    $source=undef,
    ) {

    file { "/etc/yum/pluginconf.d/${filename}":
        ensure  => $ensure,
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

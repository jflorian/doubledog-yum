# modules/yum/manifests/init.pp
#
# == Class: yum
#
# Manages yum/dnf on a host.
#
# === Parameters
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*content*]
#   Literal content for the yum.conf file.  If neither "content" nor "source"
#   is given, the content of the file will be left unmanaged.
#
#   Ignored if the host uses dnf instead of yum.
#
# [*source*]
#   URI of the yum.conf file content.  If neither "content" nor "source" is
#   given, the content of the file will be left unmanaged.
#
#   Ignored if the host uses dnf instead of yum.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2010-2017 John Florian


class yum (
        $content=undef,
        $source=undef,
    ) inherits ::yum::params {

    if $::yum::params::yum_conf_target {
        file { $::yum::params::yum_conf_target:
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

    # not used and slows yum startup
    ::yum::remove { 'PackageKit-yum-plugin': }

}

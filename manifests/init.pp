# modules/yum/manifests/init.pp
#
# == Class: yum
#
# Manages yum on a host.
#
# === Parameters
#
# [*content*]
#   Literal content for the yum.conf file.  One and only one of "content" or
#   "source" must be given.
#
# [*source*]
#   URI of the yum.conf file content.  One and only one of "content" or
#   "source" must be given.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class yum (
        $content=undef,
        $source=undef,
    ) {

    include 'yum::params'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
    }

    file { '/etc/yum.conf':
        content => $content,
        source  => $source,
    }

    # not used and slows yum startup
    yum::remove { 'PackageKit-yum-plugin': }

}

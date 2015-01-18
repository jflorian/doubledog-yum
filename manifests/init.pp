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
# [*copr_plugin*]
#   If 'present', the yum plugin for copr support will be installed.  If
#   'absent' the plugin will be removed.  The default is 'absent'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class yum (
        $content=undef,
        $source=undef,
        $copr_plugin='absent',
    ) {

    include 'yum::params'

    class { 'yum::copr':
        ensure => $copr_plugin,
    }

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

# modules/yum/manifests/cron.pp
#
# Synopsis:
#       Configures a host to apply yum updates periodically via cron.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       conf_source             URI of yum-cron configuration source.

class yum::cron ($conf_source) {

    include 'yum::params'

    package { $yum::params::packages:
        ensure => installed,
        notify => Service[$yum::params::services],
    }

    # While yum-updatesd has some nice features, it's a bloated memory pig.
    package { 'yum-updatesd':
        ensure  => absent,
    }

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
        before      => Service[$yum::params::services],
        notify      => Service[$yum::params::services],
        subscribe   => Package[$yum::params::packages],
    }

    file { $yum::params::cron_conf_target:
        source  => $conf_source,
    }

    service { $yum::params::services:
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

}

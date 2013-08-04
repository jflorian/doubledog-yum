# modules/yum/manifests/cron.pp
#
# Synopsis:
#       Configures a host to apply yum updates periodically via cron.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#
#       NONE

class yum::cron {

    include 'yum::params'

    package { $yum::params::packages:
        ensure  => installed,
        notify  => Service[$yum::params::services],
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
        source  => "puppet:///modules/yum/$yum::params::cron_conf_source",
    }

    service { $yum::params::services:
        enable      => true,
        ensure      => running,
        hasrestart  => true,
        hasstatus   => true,
    }

}

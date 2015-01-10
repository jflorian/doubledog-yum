# modules/yum/manifests/core.pp
#
# Synopsis:
#       Installs the YUM repo configuration for core software.
#
# Parameters:
#       Name__________  Notes_  Description___________________________
#


class yum::core {

    include 'doubledog::subsys::yum::doubledog'
    include 'doubledog::subsys::yum::local_fedora'

    File {
        owner       => 'root',
        group       => 'root',
        mode        => '0644',
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'etc_t',
    }

    file { '/etc/yum.conf':
        source  => [
            'puppet:///private-host/yum/yum.conf',
            'puppet:///private-domain/yum/yum.conf',
            'puppet:///modules/yum/yum.conf',
        ],
    }

    # not used and slows yum startup
    yum::remove { 'PackageKit-yum-plugin': }

}

# modules/yum/manifests/classes/core.pp
#
# Synopsis:
#       Installs the YUM repo configuration for core software.
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include yum::core

class yum::core {

    include yum::doubledog
    include yum::local-fedora

    if $operatingsystem == 'Fedora' {

        if $operatingsystemrelease >= 12 {
            # we don't use delta RPM support
            yum::remove { 'yum-presto': }
        }

        if $operatingsystemrelease >= 14 {
            # not used and slows yum startup
            yum::remove { 'PackageKit-yum-plugin': }
        }

    }

}

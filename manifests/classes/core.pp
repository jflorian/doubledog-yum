# /etc/puppet/modules/yum/manifests/classes/core.pp
#
# Synopsis:
#       Installs the YUM repo configuration for core software
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

}

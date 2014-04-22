# modules/yum/manifests/everything.pp
#
# Synopsis:
#       Installs the YUM repo configuration for all software.
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include 'yum::everything'

class yum::everything {

    include 'yum::core'
    include 'yum::rpmfusion'

}

# modules/yum/manifests/adobe.pp
#
# Synopsis:
#       Installs the YUM repo configuration for Adobe software.
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include 'yum::adobe'

class yum::adobe {

    install_repo_rpm_from_file {"adobe-release-${architecture}-1.0-1.noarch":
    }

}

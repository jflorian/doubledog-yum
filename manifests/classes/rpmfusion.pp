# /etc/puppet/modules/yum/manifests/classes/rpmfusion.pp
#
# Synopsis:
#       Installs the YUM repo configuration for rpmfusion software
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include yum::rpmfusion

class yum::rpmfusion {

    config_repo {"rpmfusion-free":
        server_uri  => "http://download1.rpmfusion.org/free/fedora",
        pkg_name    => "rpmfusion-free-release",
        pkg_release => "stable.noarch",
    }

    config_repo {"rpmfusion-nonfree":
        server_uri  => "http://download1.rpmfusion.org/nonfree/fedora",
        pkg_name    => "rpmfusion-nonfree-release",
        pkg_release => "stable.noarch",
        require     => Exec["config-repo-rpmfusion-free"],
    }

}

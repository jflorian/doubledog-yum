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

    install_repo_rpm {"rpmfusion-free":
        server_uri  => "http://download1.rpmfusion.org/free/fedora",
        pkg_name    => "rpmfusion-free-release",
        pkg_release => "stable.noarch",
    }

    install_repo_rpm {"rpmfusion-nonfree":
        server_uri  => "http://download1.rpmfusion.org/nonfree/fedora",
        pkg_name    => "rpmfusion-nonfree-release",
        pkg_release => "stable.noarch",
        require     => Exec["rpmfusion-free"],
    }

}

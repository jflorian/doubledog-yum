# modules/yum/manifests/classes/adobe.pp
#
# Synopsis:
#       Installs the YUM repo configuration for Adobe software
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include yum::adobe

class yum::adobe {

    install_repo_rpm {"adobe":
        server_uri      => "http://linuxdownload.adobe.com/adobe-release",
        # Yes, it's i386 and noarch, really!  Sigh ...
        pkg_name        => "adobe-release-i386",
        pkg_release     => "1.0-1.noarch",
    }

}

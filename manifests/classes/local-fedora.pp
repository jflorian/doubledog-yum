# modules/yum/manifests/classes/local-fedora.pp
#
# Synopsis:
#       Installs the YUM repo configuration for local-fedora software
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include yum::local-fedora

class yum::local-fedora {

    install_repo_rpm {"local-fedora":
        server_uri  => "http://www.doubledog.org/yum/fedora/${operatingsystemrelease}/${architecture}",
        pkg_name    => "yum-local-mirror-conf",
        pkg_release => $operatingsystemrelease ? {
            "11"        => "10-1.fc10.noarch",
            "12"        => "10-1.fc10.noarch",
            "13"        => "13-1.fc13.noarch",
            "14"        => "14-1.fc14.noarch",
            "15"        => "15-1.fc15.noarch",
            "16"        => "16-1.fc15.noarch",
        },
    }

}

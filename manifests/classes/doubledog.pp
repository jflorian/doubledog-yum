# modules/yum/manifests/classes/doubledog.pp
#
# Synopsis:
#       Installs the YUM repo configuration for doubledog software
#
# Parameters:
#       NONE
#
# Requires:
#       Class["Yum"]
#
# Example usage:
#
#       include yum::doubledog

class yum::doubledog {

    install_repo_rpm {"doubledog":
        server_uri  => "http://www.doubledog.org/yum/fedora/${operatingsystemrelease}/${architecture}",
        pkg_name    => "doubledog-yum-repo",
        pkg_release => $operatingsystemrelease ? {
            "11"        => "10-1.fc10.noarch",
            "12"        => "12-1.fc12.noarch",
            "13"        => "13-2.fc13.noarch",
            "14"        => "14-1.fc14.noarch",
            "15"        => "15-1.fc15.noarch",
        },
    }

}

# modules/yum/manifests/doubledog.pp
#
# Synopsis:
#       Installs the YUM repo configuration for doubledog software.
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

    yum::install_repo_rpm_from_uri {"doubledog":
        server_uri  => "http://www.doubledog.org/yum/fedora/${operatingsystemrelease}/${architecture}",
        pkg_name    => "doubledog-yum-repo",
        pkg_release => $operatingsystemrelease ? {
            "15"        => "15-1.fc15.noarch",
            "16"        => "16-1.fc16.noarch",
        },
    }

}

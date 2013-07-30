# modules/yum/manifests/rpmfusion.pp
#
# Synopsis:
#       Installs the YUM repo configuration for rpmfusion software.
#
# Parameters:
#       NONE
#
# Requires:
#       Class['Yum']


class yum::rpmfusion {

    yum::install_repo_rpm_from_uri {'rpmfusion-free':
        server_uri  => 'http://download1.rpmfusion.org/free/fedora',
        pkg_name    => 'rpmfusion-free-release',
        pkg_release => "$operatingsystemrelease.noarch"
    }

    yum::install_repo_rpm_from_uri {'rpmfusion-nonfree':
        server_uri  => 'http://download1.rpmfusion.org/nonfree/fedora',
        pkg_name    => 'rpmfusion-nonfree-release',
        pkg_release => "$operatingsystemrelease.noarch",
        require     => Exec['rpmfusion-free'],
    }

}

# modules/yum/manifests/local-fedora.pp
#
# Synopsis:
#       Installs the YUM repo configuration for local-fedora software.
#
# Parameters:
#       NONE
#
# Requires:
#       Class['Yum']
#
# Example usage:
#
#       include 'yum::local-fedora'

class yum::local-fedora {

    yum::install_repo_rpm_from_uri {'local-fedora':
        server_uri  => "http://www.doubledog.org/yum/fedora/${operatingsystemrelease}/${architecture}",
        pkg_name    => 'yum-local-mirror-conf',
        pkg_release => $operatingsystemrelease ? {
            '16'        => '16-1.fc16.noarch',
            '17'        => '17-1.fc17.noarch',
            '18'        => '18-1.fc18.noarch',
            '19'        => '19-1.fc19.noarch',
        },
    }

}

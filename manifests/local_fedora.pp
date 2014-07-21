# modules/yum/manifests/local_fedora.pp
#
# == Class: yum::local_fedora
#
# Installs the YUM repo configuration for Fedora software from the local
# mirror.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class yum::local_fedora {

    yum::install_repo_rpm_from_uri {'local-fedora':
        server_uri  => "http://www.doubledog.org/yum/fedora/${::operatingsystemrelease}/noarch",
        pkg_name    => 'yum-local-mirror-conf',
        pkg_release => "${::operatingsystemrelease}" ? {
            # list exceptions here, as necessary
            20      => "${::operatingsystemrelease}-3.fc${::operatingsystemrelease}.noarch",
            default => "${::operatingsystemrelease}-1.fc${::operatingsystemrelease}.noarch",
        },
    }

}

# modules/yum/manifests/doubledog.pp
#
# == Class: yum::doubledog
#
# Installs the YUM repo configuration for doubledog software.
#
# === Parameters
#
# NONE
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>


class yum::doubledog {

    # Generally, hosts should use the repo configuration matching their Fedora
    # installation release.  The builder hosts are an exception since the repo
    # package they need doesn't yet exist.  Thus they are directed to that
    # from the prior release.  Once the package does become available, yum
    # will update this package like any other.
    $current_rel = $::operatingsystemrelease
    $prior_rel = $current_rel - 1
    $use_rel = $hostname ? {
        /^builder[-_]/  => $prior_rel,
        default         => $current_rel,
    }

    yum::install_repo_rpm_from_uri {'doubledog':
        server_uri  => "http://www.doubledog.org/yum/fedora/${use_rel}/noarch",
        pkg_name    => 'doubledog-yum-repo',
        pkg_release => "${::operatingsystemrelease}" ? {
            # list exceptions here, as necessary
            '20'    => "${use_rel}-2.fc${use_rel}.noarch",
            default => "${use_rel}-1.fc${use_rel}.noarch",
        },
    }

}

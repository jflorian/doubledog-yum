# modules/yum/manifests/definitions/install_repo_rpm.pp
#
# Synopsis:
#       Installs a YUM repo configuration via rpm accessed by URI
#
# Parameters:
#       name:           The name of the YUM repository.
#       source:         The rpm URI for obtaining the repo-conf package.
#
# Requires:
#       Class["yum"]
#
# Example usage:
#
#       include yum
#
#       yum::install_repo_rpm {"adobe":
#           server_uri      => "http://linuxdownload.adobe.com/adobe-release",
#           # Yes, it's i386 and noarch, really!  Sigh ...
#           pkg_name        => "adobe-release-i386",
#           pkg_release     => "1.0-1.noarch",
#       }



define yum::install_repo_rpm ($server_uri, $pkg_name, $pkg_release) {

    exec { "${name}":
        command => "rpm -ivh ${server_uri}/${pkg_name}-${pkg_release}.rpm",
        unless  => "rpm -q ${pkg_name}",
    }

}

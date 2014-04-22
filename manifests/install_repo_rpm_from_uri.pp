# modules/yum/manifests/install_repo_rpm_from_uri.pp
#
# Synopsis:
#       Installs a YUM repo configuration via rpm accessed by URI.
#
# Parameters:
#       name:           The name of the YUM repository.
#       source:         The rpm URI for obtaining the repo-conf package.
#
# Requires:
#       Class["yum"]



define yum::install_repo_rpm_from_uri ($server_uri, $pkg_name, $pkg_release) {

    exec { "${name}":
        command => "yum -y install ${server_uri}/${pkg_name}-${pkg_release}.rpm",
        unless  => "rpm -q ${pkg_name}",
    }

}

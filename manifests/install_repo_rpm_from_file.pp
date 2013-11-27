# modules/yum/manifests/install_repo_rpm_from_file.pp
#
# Synopsis:
#       Installs a YUM repo configuration via rpm on puppet master.
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
#       include 'yum'
#
#       install_repo_rpm_from_file {"myrepo-${architecture}-1.0-1.noarch":
#       }



define yum::install_repo_rpm_from_file () {

    $rpm_file = "${name}.rpm"
    $cached_rpm = "/var/cache/yum/${rpm_file}"

    file { "${cached_rpm}":
        group	=> 'root',
        mode    => '0640',
        owner   => 'root',
        source  => [
            "puppet:///private-host/yum/${rpm_file}",
            "puppet:///private-domain/yum/${rpm_file}",
            "puppet:///modules/yum/${rpm_file}",
        ],
    }

    exec { "${name}":
        command => "yum -y install ${cached_rpm}",
        require => File["${cached_rpm}"],
        unless  => "rpm -q ${name}",
    }
}

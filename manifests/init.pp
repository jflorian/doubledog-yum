# /etc/puppet/modules/yum/manifests/init.pp

class yum {

    define config_repo($server_uri, $pkg_name, $pkg_release) {
	exec { "config-repo-${name}":
	    command 	=> "rpm -ivh ${server_uri}/${pkg_name}-${pkg_release}.rpm",
	    unless	=> "rpm -q ${pkg_name}",
	}
    }

    config_repo {"adobe":
	server_uri	=> "http://linuxdownload.adobe.com/adobe-release",
        # Yes, it's i386 and noarch, really!  Sigh ...
	pkg_name	=> "adobe-release-i386",
	pkg_release	=> "1.0-1.noarch",
    }

    if ($operatingsystem == "Fedora") {
        config_repo {"doubledog":
            server_uri	=> "http://www.doubledog.org/yum/fedora/${operatingsystemrelease}/${architecture}",
            pkg_name	=> "doubledog-yum-repo",
            # TODO: use operatingsystemrelease once packages are built for all
            pkg_release	=> "10-1.fc10.noarch",
        }

        config_repo {"local-fedora":
            server_uri	=> "http://www.doubledog.org/yum/fedora/${operatingsystemrelease}/${architecture}",
            pkg_name	=> "yum-local-mirror-conf",
            # TODO: use operatingsystemrelease once packages are built for all
            pkg_release	=> "10-1.fc10.noarch",
        }

        config_repo {"rpmfusion-free":
            server_uri	=> "http://download1.rpmfusion.org/free/fedora",
            pkg_name	=> "rpmfusion-free-release",
            pkg_release	=> "stable.noarch",
        }

        config_repo {"rpmfusion-nonfree":
            server_uri	=> "http://download1.rpmfusion.org/nonfree/fedora",
            pkg_name	=> "rpmfusion-nonfree-release",
            pkg_release	=> "stable.noarch",
            require		=> Exec["config-repo-rpmfusion-free"],
        }
    }

}

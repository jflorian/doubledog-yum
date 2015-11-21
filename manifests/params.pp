# modules/yum/manifests/params.pp
#
# == Class: yum::params
#
# Parameters for the yum puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2013-2015 John Florian

class yum::params {

    $cron_service_enable    = true
    $cron_service_ensure    = 'running'
    $update_cmd             = 'default'
    $update_messages        = true
    $download_updates       = true
    $apply_updates          = false
    $random_sleep           = 120
    $emit_via               = 'stdio'
    $email_from             = 'root@localhost'
    $email_to               = 'root'
    $email_host             = 'localhost'

    case $::operatingsystem {

        'CentOS': {

            $tool = 'yum'
            $services = 'yum-cron'
            $packages = 'yum-cron'
            $yum_conf_target = '/etc/yum.conf'

            # CentOS 7 also provides an hourly job, but it will be left at its
            # default (i.e., disabled).
            $cron_conf_target = '/etc/yum/yum-cron.conf'

        }

        'Fedora': {

            if $::operatingsystemrelease >= '22' {
                $tool = 'dnf'
                $yum_conf_target = undef
            } else {
                $tool = 'yum'
                $yum_conf_target = '/etc/yum.conf'
            }
            $services = 'yum-cron'
            $packages = 'yum-cron'

            # Fedora 19 also provides an hourly job, but it will be left
            # at its default (i.e., disabled).
            $cron_conf_target = '/etc/yum/yum-cron.conf'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}

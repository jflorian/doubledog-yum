# modules/yum/manifests/params.pp
#
# Synopsis:
#       Parameters for the yum puppet module.


class yum::params {

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

            $services = [
                'yum-cron',
            ]
            $packages = [
                'yum-cron',
            ]

            # CentOS 7 also provides an hourly job, but it will be left at its
            # default (i.e., disabled).
            $cron_conf_target = '/etc/yum/yum-cron.conf'

            # CentOS doesn't have the yum plugin.
            $copr_packages = undef

        }

        'Fedora': {

            $services = [
                'yum-cron',
            ]
            $packages = [
                'yum-cron',
            ]

            if $::operatingsystemrelease < 19 {
                $cron_conf_target = '/etc/sysconfig/yum-cron'
            } else {
                # Fedora 19 also provides an hourly job, but it will be left
                # at its default (i.e., disabled).
                $cron_conf_target = '/etc/yum/yum-cron.conf'
            }

            if $::operatingsystemrelease >= 20 {
                $copr_packages = [
                    'yum-plugin-copr',
                ]
            } else {
                # The yum plugin was introduced in Fedora 20.
                $copr_packages = undef
            }

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}

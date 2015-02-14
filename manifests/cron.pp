# modules/yum/manifests/cron.pp
#
# == Class: yum::cron
#
# Manages the yum-cron service.
#
# === Parameters
#
# [*ensure*]
#   Service is to be 'running' (default) or 'stopped'.
#
# The following parameters go straight into the yum-cron configuration file
# unmodified with the exception of boolean values which get translated from
# proper booleans (true, false) into their equivalent 'yes'/'no' strings.
#
# [*update_cmd*]
#   What kind of update to use:
#     default                       = yum upgrade
#     security                      = yum --security upgrade
#     security-severity:Critical    = yum --sec-severity=Critical upgrade
#     minimal                       = yum --bugfix upgrade-minimal
#     minimal-security              = yum --security upgrade-minimal
#
# [*update_messages*]
#   Whether a message should be emitted when updates are available, were
#   downloaded, or applied.
#
# [*download_updates*]
#   Whether updates should be downloaded when they are available.
#
# [*apply_updates*]
#   Whether updates should be applied when they are available.  Note that
#   download_updates must also be true for the update to be applied.
#
# [*random_sleep*]
#   Maximum amout of time to randomly sleep, in minutes.  The program will
#   sleep for a random amount of time between 0 and random_sleep minutes
#   before running.  This is useful for e.g., staggering the times that
#   multiple systems will access update servers.  If random_sleep is 0 or
#   negative, the program will run immediately.
#
# [*emit_via*]
#   How to send messages.  Valid options are stdio and email.  If emit_via
#   includes stdio, messages will be sent to stdout; this is useful to have
#   cron send the messages.  If emit_via includes email, this program will
#   send email itself according to the configured options.  If emit_via is
#   None or left blank, no messages will be sent.
#
# [*email_from*]
#   The address to send email messages from.
#
# [*email_to*]
#   List of addresses to send messages to.
#
# [*email_host*]
#   Name of the host to connect to to send email messages.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2013-2015 John Florian



class yum::cron (
        $ensure             = $::yum::params::cron_service_ensure,
        $update_cmd         = $::yum::params::update_cmd,
        $update_messages    = $::yum::params::update_messages,
        $download_updates   = $::yum::params::download_updates,
        $apply_updates      = $::yum::params::apply_updates,
        $random_sleep       = $::yum::params::random_sleep,
        $emit_via           = $::yum::params::emit_via,
        $email_from         = $::yum::params::email_from,
        $email_to           = $::yum::params::email_to,
        $email_host         = $::yum::params::email_host,
    ) inherits ::yum::params {

    package { $::yum::params::packages:
        ensure => installed,
        notify => Service[$::yum::params::services],
    }

    File {
        owner     => 'root',
        group     => 'root',
        mode      => '0644',
        seluser   => 'system_u',
        selrole   => 'object_r',
        seltype   => 'etc_t',
        before    => Service[$::yum::params::services],
        notify    => Service[$::yum::params::services],
        subscribe => Package[$::yum::params::packages],
    }

    file { $yum::params::cron_conf_target:
        content => template('yum/yum-cron.conf.erb'),
    }

    service { $::yum::params::services:
        ensure     => $ensure,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
    }

}

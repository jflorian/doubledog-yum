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
# This file is part of the doubledog-yum Puppet module.
# Copyright 2013-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class yum::params {

    case $::operatingsystem {

        'CentOS': {

            $tool = 'yum'

        }

        'Fedora': {

            $tool = 'dnf'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}

#
# == Define: yum::remove
#
# Remove a package directly with yum/dnf.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-yum Puppet module.
# Copyright 2012-2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


define yum::remove {

    include '::yum'

    exec { "${::yum::tool} -y remove ${name}":
        onlyif => "rpm -q ${name}",
    }

}

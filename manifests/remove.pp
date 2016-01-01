# modules/yum/manifests/remove.pp
#
# == Define: yum::remove
#
# Remove a package directly with yum/dnf to work around quirks with Puppet's
# "package" resource has had issues with removing dependencies.  At some
# point they introduced support for an ensurable of "purged" which mostly
# works, but in versions prior to 4.2 the resource type will report
# Package[name]/ensure: created with every application of the catalog after
# the package has actually been removed.  There are two issues with that
# behavior:
#   1. "created" is confusing because the package is actually purged
#   2. it's reporting noise since no action is actually being taken
#
# In summary, this definition is still the de facto way to remove a package
# that has dependencies when some Puppet clients are older than v4.2.
#
# See also: https://tickets.puppetlabs.com/browse/PUP-1295
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   Name of the package to be removed.
#
# ==== Optional
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2012-2016 John Florian


define yum::remove {

    include '::yum::params'

    exec { "${::yum::params::tool} -y remove ${name}":
        onlyif  => "rpm -q ${name}",
    }

}

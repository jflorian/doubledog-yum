# modules/yum/manifests/repo_file.pp
#
# == Define: yum::repo_file
#
# Manages a YUM repository configuration file via source or literal content.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the YUM repository file instance unless the
#   "filename" parameter is not set in which case this must provide the value
#   normally set with the "filename" parameter.
#
# ==== Optional
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*filename*]
#   The name to be given the file when installed.  This should be the base
#   name alone without any ".repo" extension or any directory pathing.  This
#   may be used in place of "namevar" if it's beneficial to give namevar an
#   arbitrary value.
#
# [*content*]
#   Literal content for the YUM repository file.  If neither "content" nor
#   "source" is given, the content of the file will be left unmanaged.
#
# [*source*]
#   URI of the YUM repository file content.  If neither "content" nor "source"
#   is given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2015 John Florian


define yum::repo_file (
        $ensure='present',
        $filename=undef,
        $content=undef,
        $source=undef,
    ) {

    if $filename {
        $filename_ = $filename
    } else {
        $filename_ = $name
    }

    file { "/etc/yum.repos.d/${filename_}.repo":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'system_conf_t',
        content => $content,
        source  => $source,
    }

}

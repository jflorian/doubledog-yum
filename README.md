<!--
# This file is part of the doubledog-yum Puppet module.
# Copyright 2018 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later
-->

# yum

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with yum](#setup)
    * [What yum affects](#what-yum-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with yum](#beginning-with-yum)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module provides utilities and other resources to assist in usage of yum/dnf.

## Setup

### What yum Affects

### Setup Requirements

### Beginning with yum

## Usage

## Reference

**Classes:**

* [yum](#yum-class)

**Defined types:**

* [yum::plugin\_conf](#yumplugin\_conf-defined-type)
* [yum::remove](#yumremove-defined-type)
* [yum::repo\_file](#yumrepo\_file-defined-type)
* [yum::repo\_package](#yumrepo\_package-defined-type)


### Classes

#### yum class

This class manages the basic yum/dnf configuration.

##### `tool` (required)
The executable name of the packaging tool, typically `'yum'` or `'dnf'`.  The default should be correct for supported platforms.

##### `conf_target`
Fully-qualified name of the `yum.conf` or `dnf.conf` configuration file.  The default should be correct for supported platforms.  If `undef`, the file will not be managed at all.

##### `content`
Literal content for the yum/dnf configuration file.  If both *content* and *source* are `undef`, the content of the file will be left unmanaged.

Ignored if *conf_target* is `undef`.

##### `source`
Puppet URI by which the yum/dnf configuration content will be provided.  If both *content* and *source* are `undef`, the content of the file will be left unmanaged.  By default, this module will provide a default matching that shipped by the OS.

Ignored if *conf_target* is `undef`.

##### `unwanted_packages`
An array of package names to be forcibly removed.  The default is appropriate for hosts typically managed by Puppet.


### Defined types

#### yum::plugin\_conf defined type

This defined type manages a plugin configuration file.

##### `namevar` (required)
An arbitrary identifier for the repository file instance unless the *filename* parameter is not set in which case this must provide the value normally set with the *filename* parameter.

##### `content`
Literal content for the configuration file.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `ensure`
Instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `filename`
The name to be given the installed file.  This should be the base name alone without any `'.conf'` suffix nor any path detail.  This may be used in place of *namevar* if it's beneficial to give namevar an arbitrary value.

##### `source`
URI of the configuration file content.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.


#### yum::remove defined type

This defined type removes a package, or an array of packages, directly with yum/dnf to work around quirks with Puppet's own *package* type which has had issues with removing dependencies.  At some point they introduced support for an ensurable of "purged" which mostly works, but in versions prior to 4.2 the resource type will report Package[name]/ensure: created with every application of the catalog after the package has actually been removed.  There are two issues with that behavior:

  1. "created" is confusing because the package is actually purged
  2. it's reporting noise since no action is actually being taken

In summary, this definition is still the de facto way to remove a package that has dependencies when some Puppet clients are older than v4.2.

See also https://tickets.puppetlabs.com/browse/PUP-1295.

##### `namevar` (required)
The package name, or array of package names, to be removed.


#### yum::repo\_file defined type

This defined type manages a repository configuration file directly.

##### `namevar` (required)
An arbitrary identifier for the repository file instance unless the *filename* parameter is not set in which case this must provide the value normally set with the *filename* parameter.

##### `content`
Literal content for the configuration file.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.

##### `ensure`
Instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `filename`
The name to be given the installed file.  This should be the base name alone without any `'.repo'` suffix nor any path detail.  This may be used in place of *namevar* if it's beneficial to give namevar an arbitrary value.

##### `source`
URI of the configuration file content.  If neither *content* nor *source* is given, the content of the file will be left unmanaged.


#### yum::repo\_package defined type

This defined type manages a repository configuration file indirectly via packaging.

##### `namevar` (required)
Name of the repository package.

##### `arch`
Architecture of the repository package.  E.g., `'noarch'`. Required, but may be `''` (an empty string).

##### `dist`
Distribution tag of the repository package.  E.g., `'fc28'`.  Required, but may be `''`.

##### `ensure`
Instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `rel`
Release number of the repository package.  E.g., `'1'`.  Required, but may be `''`.

##### `uri`
The URI for obtaining the repository package.  Must be one supported by
the `'yum install'` (or `'dnf install`') command.  This should include everything from the protocol up to, but not including, the file name.

##### `ver`
Version number of the repository package.  E.g., `'20'`.  Required, but may be `''`.


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.

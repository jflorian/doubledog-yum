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


### Classes

#### yum class

This class manages the basic yum/dnf configuration.

##### `conf_target`:
Fully-qualified name of the `yum.conf` or `dnf.conf` configuration file.  The default should be correct for supported platforms.  If `undef`, the file will not be managed at all.

##### `content`:
Literal content for the yum/dnf configuration file.  If both *content* and *source* are `undef`, the content of the file will be left unmanaged.

Ignored if *conf_target* is `undef`.

##### `source`:
Puppet URI by which the yum/dnf configuration content will be provided.  If both *content* and *source* are `undef`, the content of the file will be left unmanaged.  By default, this module will provide a default matching that shipped by the OS.

Ignored if *conf_target* is `undef`.

##### `unwanted_packages`:
An array of package names to be forcibly removed.  The default is appropriate for hosts typically managed by Puppet.


### Defined types


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.

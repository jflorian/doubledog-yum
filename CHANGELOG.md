<!--
This file is part of the doubledog-yum Puppet module.
Copyright 2018-2021 John Florian
SPDX-License-Identifier: GPL-3.0-or-later

Template

## [VERSION] WIP
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->

# Change log

All notable changes to this project (since v1.1.0) will be documented in this file.  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [2.2.1] WIP
### Added
- `yum::best` parameter
- Fedora 34 support
### Changed
- defaults now generally assume dnf with only CentOS 7 now deviating
### Deprecated
### Removed
- Fedora 31 support
### Fixed
- CentOS 8 gets managed as yum but should be dnf
### Security

## [2.2.0] 2020-12-09
### Added
- CentOS 8 support
- Fedora 31-33 support
- dependency on `puppetlabs/stdlib` now allows version 6
### Removed
- Fedora 28-30 support

## [2.1.0] 2019-03-28
### Changed
- dependency on `doubledog/ddolib` now expects 1 >= version < 2

## [2.0.0] 2018-12-24
### Added
- Fedora 28/29 support
### Changed
- `yum::tool` now accepts `'dnf'` or `'yum'` only
- now compatible with `puppetlabs-stdlib` version 5
- `yum` class no longer accepts `content` nor `source` parameters, but now accepts many new parameters for more proper control:
    - `bugtracker_url`
    - `cachedir`
    - `clean_requirements_on_remove`
    - `debuglevel`
    - `distroverpkg`
    - `gpgcheck`
    - `installonly_limit`
    - `keepcache`
    - `plugins`
    - `proxy`
### Removed
- Fedora 26/27 support

## [1.1.0 and prior] 2018-12-15

This and prior releases predate this project's keeping of a formal CHANGELOG.  If you are truly curious, see the Git history.

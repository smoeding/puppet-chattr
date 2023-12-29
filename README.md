# chattr

[![Build Status](https://github.com/smoeding/puppet-chattr/actions/workflows/CI.yaml/badge.svg)](https://github.com/smoeding/puppet-chattr/actions/workflows/CI.yaml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/stm/chattr.svg)](https://forge.puppetlabs.com/stm/chattr)
[![License](https://img.shields.io/github/license/smoeding/puppet-chattr.svg)](https://raw.githubusercontent.com/smoeding/puppet-chattr/master/LICENSE)

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with chattr](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with chattr](#beginning-with-chattr)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module contains the `chattr` custom type to add or remove file attributes from a file on a Linux filesystems. One of the most useful file attributes is `immutable` which prevents any future modification of the file.

## Setup

### Setup Requirements

The module contains a custom type so pluginsync must be enabled.

### Beginning with chattr

Set the immutable file attribute for a configuration file that should not be modified after the initial installation:

``` puppet
chattr { '/etc/machine-id':
  immutable => true,
}
```

## Usage

The type implements an optional boolean parameter for each file attribute. The current setting for the file attribute will not be changed if you leave the parameter unset.

Setting the parameter to `true` will set the attribute and setting the parameter to `false` will remove the attribute from the file.

## Limitations

The module does not yet support all available file attributes.

Some file attributes are read-only and can't be changed.

Also note that different file systems support different subsets of the available file attributes. Check if the intended file attribute is really available on your system.

## Development

Feel free to open issues or pull requests on Github.

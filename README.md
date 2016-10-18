Bash Utilities
==============

Índice
------

* [Prerequisites][prerequisites].
* [Installation][Installation].
* [API][api].
    + [Configuration][api_configuration].
    	+ [config_get][api_configuration_get].
* [License][license].



Prerequisites
-------------
* Linux/Mac OS


Installation
------------
```shell
cd ~
git clone https://github.com/comodinx/bash-utilities.git bash
cd bash
./scripts/install.bash
```

> Note. If the commands not found in terminal. Please run this code `source ~/.bash_profile`

API
---

## Configuration

Set your necesary configuration.

Default configuration
```shell
git.master.branch=master
git.development.branch=develop
base.directory=<value of variable $HOME>
```

#### config_get

Return config value for `key`

*Alias: cget*

```shell
config_get -k "base.directory"
# <value of variable $HOME>

config_get -k "not.exists.key" -d "default/value"
# default/value
```


License
-------
Base Utilities is available under the MIT license. See the LICENSE file for more info.

<!-- deep links -->
[prerequisites]: #prerequisites
[installation]: #installation
[api]: #api
[api_configuration]: #configuration
[api_configuration_get]: #config_get
[license]: #license

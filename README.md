Bash Utilities
==============

Índice
------

* [Prerequisites][prerequisites].
* [Installation][Installation].
* [API][api].
    + [Configuration][api_configuration].
    	+ [get][api_configuration_get].
    	+ [put][api_configuration_put].
    	+ [has][api_configuration_has].
    	+ [remove][api_configuration_remove].
    	+ [show][api_configuration_show].
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

> Note. All commands print the help with `-h` argument.

### Configuration

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

#### config_put

Put config `value` for `key` in configuration file

*Alias: cput*

```shell
config_put -k "my.custom.configuration" -v "my.custom.configuration.value"
```

#### config_has

Return `true` (`0`) if config `key` exists

*Alias: chas*

```shell
config_has -k "my.custom.exists.configuration"
echo "$?"
# 0

config_has -k "my.custom.not.exists.configuration"
echo "$?"
# 1
```

#### config_remove

Remove config value for `key` in configuration file

*Alias: cremove*

```shell
config_remove -k "my.custom.configuration"
```

#### config_show

Show all config values in configuration file

*Alias: cshow*

```shell
config_show
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
[api_configuration_put]: #config_put
[api_configuration_has]: #config_has
[api_configuration_remove]: #config_remove
[api_configuration_show]: #config_show
[license]: #license

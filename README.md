Bash Utilities
==============

Index
-----

* [Prerequisites][prerequisites].
* [Installation][Installation].
* [API][api].
    + [Configuration][api_configuration].
    	+ [get][api_configuration_get].
    	+ [put][api_configuration_put].
    	+ [has][api_configuration_has].
        + [remove][api_configuration_remove].
        + [show][api_configuration_show].
    + [GIT][api_git].
        + [initialize repository][api_git_init].
        + [check if branch exists][api_git_branch_exists].
        + [get current branch][api_git_branch].
        + [get development branch][api_git_branch_development].
        + [rebase][api_git_rebase].
        + [rebase master][api_git_rebase_master].
        + [rebase development][api_git_rebase_development].
        + [merge][api_git_merge].
        + [push][api_git_push].
        + [version][api_git_version].
        + [tag][api_git_tag].
    + [NPM][api_npm].
        + [update][api_npm_update].
    	+ [check][api_npm_check].
    + [Images (TODO documentation)][api_images].
    + [Helpers (TODO documentation)][api_helpers].
        + [logs][api_helpers_logs].
        + [user interaction][api_helpers_user_interaction].
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

### GIT

#### git_init

Initialize a GIT repository

*Alias: ginit*

```shell
git_init -o https://github.com/comodinx/bash-utilities.git

# Change comment for first commit. Dafault comment is "Initial commit"
git_init -o https://github.com/comodinx/bash-utilities.git -c "First commit"

# Change branch for first push. Dafault branch is "master"
git_init -o https://github.com/comodinx/bash-utilities.git -b develop
```

#### git_br_exists

Check if branch exists in GIT repository

*Alias: gbrexists*

```shell
git_br_exists -b myexistsbranch
echo "$?"
# 0

git_br_exists -b mynotexistsbranch
echo "$?"
# 1

# Check only remotes branchs
git_br_exists -b myremotebranch -r
echo "$?"
# 0

# Print details
git_br_exists -b myexistsbranch -d
# Available

git_br_exists -b mynotexistsbranch -d
# Unavailable
```

#### git_br

Get your current branch

*Alias: gbr*

```shell
git_br
# <your current branch name>
```

#### git_br_development

Get your development branch setting in configuration with key `"git.development.branch"`

*Alias: git_br_dev, gbrdev*

```shell
git_br_development
# <your development branch name (config_get -k "git.development.branch")>
```

#### git_rebase

Rebase from origin your current or selected branch 

*Alias: greb*

```shell
# Rebase your current branch
git_rebase

# Rebase selected branch
git_rebase -b mybranch
```

#### git_master

Change your current to master branch and rebase from origin this branch (master)

*Alias: gmas*

```shell
git_master
```

#### git_development

Change your current to development branch and rebase from origin this branch (`git_br_development`)

*Alias: gdev*

```shell
git_development
```

#### git_merge

Merge your branch with other branch

*Alias: gmer*

```shell
# Merge your current branch with the development branch (git_br_development)
git_merge

# Merge selected branch with the development branch (git_br_development)
git_merge -b mybranch

# Merge selected branch with the other branch
git_merge -b mybranch -o otherbranch
```

#### git_push

Add all files, commit with comment and push to origin

> Note. This command prevent add, commit and push in master or development (`git_br_development`) branches. For force push use `-f` argument

*Alias: gpus*

```shell
# Push your current branch
git_push -c "Update README.md"

# Push selected branch
git_push -c "Update README.md" -b mybranch

# Force push master or development branch
git checkout master
git_push -c "Update README.md" -f
```

#### git_version

Calculate tagging code version in format Major.minor.patch

> Note. This command use `git describe --abbrev=0 --tags`, but to use `git tag --list` use `-f` argument

*Alias: gver*

```shell
# Calculate next tagging version. Note: increased is smart. Automatically calculates levels "minor" and/or "patch" when level is "major" or "minor"
git_version

# Calculate next tagging version, but find current max tag version in list (git tag --list)
git_version -f

# Calculate previous tagging version. Note: decreased is not smart.
git_version -d

# Get current tagging version
git_version -c
# OR 
git_version -c -f

# Calculate next tagging version, but increment level major
git_version -c -l major
# OR
git_version -c -l M

# Calculate next tagging version, but increment level minor
git_version -c -l minor
# OR
git_version -c -l m

```


#### git_tag

Tagging code version

*Alias: gtag*

```shell
# Tagging with default comment. Default comment is the tag specified
git_tag -t 1.0.0

# Tagging with comment
git_tag -t 1.0.0 -c "Release 1.0.0"
```

### NPM

#### npm_update

Update node modules

*Alias: npmu*

```shell
npmu

# Prevent remove current node_modules folder
npmu -o
```

#### npm_check

Check if NPM module exists

*Alias: npmc*

```shell
npmc -m grunt-cli
echo "$?"
# 0

# Print details
npmc -m grunt-cli -d
# Available (Global)

npmc -m express -d
# Available (Local)

npmc -m unexistsmodule -d
# Unavailable
```

### Helpers

#### Logs

Logger has several utility methods

##### logcolors

```shell
# Print log color help with full information
logcolors
# OR Alias
lcolors
```

##### log[level]

```shell
# Print log in specific level: "trace", "debug", "info", "warn", "error", "success" and "note"
# Usage log[level] or l[level]
# Example:
logsuccess
# OR Alias
lsuccess
```

#### User interaction

User interaction has several utility methods

##### read_confirm

```shell
# Asks the user for confirmation in format "y" or "n"
read_confirm -m "Did you mean?"
# OR Alias
readc -m "Did you mean?"
```

##### read_input

```shell
# Asks the user to enter the requested information
read_input -m "Enter your name:"
# OR Alias
readi -m "Enter your name:"
# With limit of characters
readi -m "Enter your name:" -l 50
# With sub message
readi -m "Enter your name:" -s "(Required)"
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
[api_git]: #git
[api_git_init]: #git_init
[api_git_branch_exists]: #git_br_exists
[api_git_branch]: #git_br
[api_git_branch_development]: #git_br_development
[api_git_rebase]: #git_rebase
[api_git_rebase_master]: #git_master
[api_git_rebase_development]: #git_development
[api_git_merge]: #git_merge
[api_git_push]: #git_push
[api_git_version]: #git_version
[api_git_tag]: #git_tag
[api_npm]: #npm
[api_npm_update]: #npm_update
[api_npm_check]: #npm_check
[api_images]: #images
[api_helpers]: #helpers
[api_helpers_logs]: #logs
[api_helpers_user_interaction]: #user-interaction
[license]: #license

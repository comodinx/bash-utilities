#! bash/bash

### Includes
source ~/bash/scripts/helpers/index.bash


### Local variables
help=false
name=''


### Parse arguments
while getopts ":c:h" opt; do
    case "${opt}" in
        c)  name=$OPTARG;;
        h)  help=true;;
    esac
done


### Check arguments
if [ "$help" != false ]
then
    utils_help -n command_install -a cinstall -d 'Install command' -o '-c Command name'
    exit 0
fi

if [ -z "$name" ]
then
    logwarn 'Please enter a command name'
    exit 1
fi

if command_check -c "$name"
then
    logwarn "Already installed"
    exit 1
fi


### Source function
if is_os_mac
then
    brew install $1
else
    apt-get install $1
fi
